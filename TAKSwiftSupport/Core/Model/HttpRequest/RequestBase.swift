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
                
                let _ = self?.responseJson()
                    .subscribe(
                        onNext: { jsonString in
                            if let mapper = Mapper<T>().map(jsonString) {
                                observer.onNext(mapper)
                                observer.onCompleted()
                                self?.successLog(jsonString)
                            } else {
                                let error = NSError(errorType: .ModelMappingError)
                                observer.onError(error)
                                self?.errorLog(error)
                            }
                        }, onError: { error in
                            observer.onError(error)
                        }, onCompleted: { }, onDisposed: { }
                    )
                
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
                
                let _ = self?.responseJson()
                    .subscribe(
                        onNext: { jsonString in
                            if let mapper = Mapper<T>().mapArray(jsonString) {
                                observer.onNext(mapper)
                                observer.onCompleted()
                                self?.successLog(jsonString)
                            } else {
                                let error = NSError(errorType: .ModelMappingError)
                                observer.onError(error)
                                self?.errorLog(error)
                            }
                        }, onError: { error in
                            observer.onError(error)
                        }, onCompleted: { }, onDisposed: { }
                )
                
                return AnonymousDisposable { }
            }
            
            return source
    }
    
    //MARK: - Util
    /**
    レスポンスをJsonマッピングする
    */
    private final func responseJson() -> Observable<String> {
        let source: Observable<String> = Observable.create {
            [weak self] (observer: AnyObserver<String>) in
            
            self?.request?.responseData { [weak self] response in
                let result = self?.mappingJson(response: response)
                if let jsonString = result?.jsonString {
                        observer.onNext(jsonString)
                        observer.onCompleted()
                } else if let error = result?.error {
                    observer.onError(error)
                    self?.errorLog(error)
                }
            }
            
            return AnonymousDisposable { }
        }
        
        return source
    }
    
    /**
     レスポンスオブジェクトからJson文字列へマッピングする
     */
    private final func mappingJson(response response: Response<NSData, NSError>?) -> (jsonString: String?, error: NSError?) {

        // 入力値がない場合
        guard let response = response else { return (nil, NSError(errorType: .JsonMappingError)) }
        
        switch response.result {
        case .Success(let value):
            if let jsonString = self.jsonString(value) {
                return (jsonString, nil)
            } else {
                return (nil, NSError(errorType: .JsonMappingError))
            }
            
        case .Failure(let error):
            return (nil, error)
        }
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
    
    //MARK: - Log
    /**
    Success log
    */
    private final func successLog(resultMessage: String) {
        DLog("\(self.request?.request?.URL):Result = \(resultMessage)")
    }
    
    /**
     Error log
     */
    private final func errorLog(error: NSError) {
        DLog("\(self.request?.request?.URL):Error(\(error.code) = \(error.localizedDescription)")
    }
}
