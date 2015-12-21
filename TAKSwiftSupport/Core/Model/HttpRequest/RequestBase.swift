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
    public func createRequest(
        hostName hostName: String,
        path: String,
        method: Method,
        parameters: [String: AnyObject],
        encording: ParameterEncoding,
        headers: [String: String]) {
            
            guard let requestUrl = hostName.appending(pathComponent: path) else {
                return
            }
            
            request = self.manager.request(
                Alamofire.Method(rawValue: method.rawValue)!,
                requestUrl,
                parameters: parameters,
                encoding: encording,
                headers: headers)
    }
    
    /**
     レスポンス形式がJsonの場合、Entityを指定してObjectMapperでマッピングまで行う
     
     - returns: <T: Responsible>
     */
    final public func requestJsonDictionary<T: Responsible>(
        ) -> Observable<T> {
            let source: Observable<T> = create { (observer: AnyObserver<T>) in
                self.request?.responseJSON { response in
                    switch response.result {
                    case .Success(let value):
                        if let mapper = Mapper<T>().map(value) {
                            observer.onNext(mapper)
                            observer.onCompleted()
                            DLog("\(self.request?.request?.URL):Result = \(value)")
                        } else {
                            observer.onCompleted()
                        }
                        
                    case .Failure(let error):
                        DLog("\(self.request?.request?.URL):Error = " + error.localizedDescription)
                        observer.on(.Error(error))
                    }
                }
                
                return AnonymousDisposable {
                    
                }
            }
            
            return source
    }
    
    /**
     レスポンス形式がルート配列のJsonの場合、Entityを指定してObjectMapperでマッピングまで行う
     
     - returns: <T: [Responsible]>
     */
    final public func requestJsonArray<T: Responsible>(
        ) -> Observable<[T]> {
            let source: Observable<[T]> = create { (observer: AnyObserver<[T]>) in
                self.request?.responseJSON { response in
                    switch response.result {
                    case .Success(let value):
                        if let mapper = Mapper<T>().mapArray(value) {
                            observer.onNext(mapper)
                            observer.onCompleted()
                            DLog("\(self.request?.request?.URL):Result = \(value)")
                        } else {
                            observer.onCompleted()
                        }
                        
                    case .Failure(let error):
                        DLog("\(self.request?.request?.URL):Error = " + error.localizedDescription)
                        observer.on(.Error(error))
                    }
                }
                
                return AnonymousDisposable {
                    
                }
            }
            
            return source
    }
    
}
