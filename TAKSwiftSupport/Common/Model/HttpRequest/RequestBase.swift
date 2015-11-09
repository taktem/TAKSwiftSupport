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

/// APiリクエストのベースとなるクラス
public class RequestBase: NSObject {
    public let requestDisposeBag = DisposeBag()
    
    private let manager = Manager.sharedInstance
    
    final public func connect(
        hostname hostname:String,
        path: String,
        method: Alamofire.Method,
        parameters:[String:AnyObject]) -> Observable<NSDictionary?> {
            
            let urlString = hostname + path
            
            return create {
                [unowned self] observer in
                
                self.manager.request(
                    .GET,
                    urlString,
                    parameters: parameters)
                    .responseJSON { response in
                        switch response.result {
                        case .Success(let value):
                            if let jsonDic = value as? NSDictionary {
                                observer.on(.Next(jsonDic))
                                observer.onCompleted()
                            }
                        case .Failure(let error):
                            // 通信のエラーハンドリングしたいなら
                            observer.on(.Error(error))
                        }
                }
                
                return AnonymousDisposable {
                    
                }
            }
    }
}
