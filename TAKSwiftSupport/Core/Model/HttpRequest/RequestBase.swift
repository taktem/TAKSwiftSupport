//
//  RequestBase.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/06.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

import Alamofire

import RxSwift

import ObjectMapper

public enum Method: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

/// APiリクエストのベースとなるクラス
public class RequestBase: NSObject {
    
    /// Rx
    public let requestDisposeBag = DisposeBag()
    
    /// Alamofire本体
    private let manager = Manager.sharedInstance
    
    // Requestオブジェクト
    private var request: Request?
    
    /**
     基礎設定を指定してリクエストオブジェクト生成
     
     - parameter hostName:   FQDN
     - parameter path:       URLパス
     - parameter method:     httpメソッド
     - parameter parameters: クエリ
     - parameter encording:  リクエストエンコードタイプ
     */
    public final func createRequest(
        hostName hostName: String,
        path: String,
        method: Method,
        parameters: [String: AnyObject],
        encording: ParameterEncoding,
        headers: [String: String]) -> Request? {
            
            guard let requestUrl = hostName.appending(pathComponent: path) else {
                return request
            }
            
            request = self.manager.request(
                Alamofire.Method(rawValue: method.rawValue)!,
                requestUrl,
                parameters: parameters,
                encoding: encording,
                headers: headers)
            
            return request
    }
    
    /**
     レスポンス形式がJsonの場合、Entityを指定してObjectMapperでマッピングまで行う
     
     - returns: <T: Responsible>
     */
    public final func requestJson<T: Responsible>(
        ) -> Observable<T> {
            let source: Observable<T> = Observable.create {
                [weak self] (observer: AnyObserver<T>) in
                
                self?.request?.responseData { [weak self] response in
                    if let
                        jsonString = self?.mappingJson(response: response),
                        mapper = Mapper<T>().map(jsonString) {
                            observer.onNext(mapper)
                            observer.onCompleted()
                            DLog("\(self?.request?.request?.URL):Result = \(jsonString)")
                    } else {
                        let error = NSError(errorType: .JsonMappingError)
                        observer.onError(error)
                        DLog("\(error.localizedDescription)")
                    }
                }
                
                return AnonymousDisposable { }
            }
            
            return source
    }
    
    /**
     レスポンス形式がルート配列のJsonの場合、Entityを指定してObjectMapperでマッピングまで行う
     
     - returns: <T: [Responsible]>
     */
    public final func requestJson<T: Responsible>(
        ) -> Observable<[T]> {
            let source: Observable<[T]> = Observable.create {
                [weak self] (observer: AnyObserver<[T]>) in
                
                self?.request?.responseData { [weak self] response in
                    if let
                        jsonString = self?.mappingJson(response: response),
                        mapper = Mapper<T>().mapArray(jsonString) {
                            observer.onNext(mapper)
                            observer.onCompleted()
                            DLog("\(self?.request?.request?.URL):Result = \(jsonString)")
                    } else {
                        let error = NSError(errorType: .JsonMappingError)
                        observer.onError(error)
                        DLog("\(error.localizedDescription)")
                    }
                }
                
                return AnonymousDisposable { }
            }
            
            return source
    }
    
    //MARK: - Util
    /**
     レスポンスオブジェクトからJson文字列へマッピングする
     */
    private final func mappingJson(response response: Response<NSData, NSError>?) -> String? {

        // 入力値がない場合
        guard let response = response else { return nil }
        
        switch response.result {
        case .Success(let value):
            if let jsonString = self.jsonString(value) {
                return jsonString
            }
        default: break
        }
        
        return nil
    }
    
    /**
     NSDataをJson文字列化
     */
    private final func jsonString(data: NSData) -> String? {
        var buffer = [UInt8](count:data.length, repeatedValue:0)
        data.getBytes(&buffer, length:data.length)
        
        if let jsonString = String(bytes:buffer, encoding:NSJapaneseEUCStringEncoding) {
            return jsonString
        } else if let jsonString = String(bytes:buffer, encoding:NSUTF8StringEncoding) {
            return jsonString
        }
        
        return nil
    }
}
