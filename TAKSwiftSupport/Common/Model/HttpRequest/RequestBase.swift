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
import RxCocoa

import ObjectMapper

/// APiリクエストのベースとなるクラス
public class RequestBase: NSObject {
    /// Rx
    public let requestDisposeBag = DisposeBag()
    
    /// Alamofire本体
    private let manager = Manager.sharedInstance
    
    // Requestオブジェクト
    private var request: Request?

    /// 付与するヘッダ情報
    public var httpHeaders = [String: String]()
    
    /**
     基礎設定を指定して初期化
     
     - parameter hostName:   FQDN
     - parameter path:       URLパス
     - parameter method:     httpメソッド
     - parameter parameters: クエリ
     - parameter encording:  リクエストエンコードタイプ
     */
    public init(
        hostName: String,
        path: String,
        method: Alamofire.Method,
        parameters: [String: AnyObject],
        encording: ParameterEncoding) {
        super.init()
            
            request = self.manager.request(
                method,
                hostName + "/" + path,
                parameters: parameters,
                encoding: encording,
                headers: httpHeaders)
    }
    
    private func setHeaders() {
        for key: String in httpHeaders.keys {
            
        }
    }
    
    final public func requstJson<T: Responsible>(
        ) -> Observable<T> {
            let source: Observable<T> = create { (observer: AnyObserver<T>) in
                self.request?.responseJSON { response in
                    switch response.result {
                    case .Success(let value):
                        if let mapper = Mapper<T>().map(value) {
                            observer.onNext(mapper)
                            observer.onCompleted()
                            print("\(self.request?.request?.URL):Result = \(value)")
                        } else {
                            observer.onCompleted()
                        }
                        
                    case .Failure(let error):
                        print("\(self.request?.request?.URL):Error = " + error.localizedDescription)
                        observer.on(.Error(error))
                    }
                }
                
                return AnonymousDisposable {
                    
                }
            }
            
            return source
    }
    
}
