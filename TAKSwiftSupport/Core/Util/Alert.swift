//
//  Alert.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/09/16.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

import RxSwift

public class Alert: NSObject {

    /// AlertController
    private var alertController :UIAlertController?
    
    /// ボタン押下時のコールバック保持用
    private var observer: AnyObserver<Int>?
    
    /// 明示的に閉じるまで自身を強参照で保持する
    private var strongSelf: Alert?
    
    /// 描画先のWindow
    private let alertWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
    
    /**
     内部処理用、AlertControllerインスタンス生成
     
     - parameter title:   タイトル
     - parameter message: 本文
     - parameter titles:  ボタンタイトル配列
     */
    init(title: String,
        message: String!,
        titles: [String]) {
            super.init()
            
            alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            if let controller = alertController {
                for index in 0..<titles.count {
                    controller.addAction(addAction(title: titles[index], index: index))
                }
            }
    }
    
    /**
     各ボタンアクションを追加する
     
     - parameter title: ボタンタイトル
     - parameter index: ボタンインデックス
     
     - returns: UIAlertAction
     */
    private func addAction(
        title title: String,
        index:Int) -> UIAlertAction {
            return UIAlertAction(title: title, style: .Default, handler: {
                [weak self](action: UIAlertAction!) -> Void in
                self?.alertWindow.rootViewController?.view.removeFromSuperview()
                self?.alertWindow.rootViewController = nil;
                
                self?.alertWindow.windowLevel = -1000
                
                if let observer = self?.observer {
                    observer.on(.Next(index))
                    observer.onCompleted()
                }
                self?.strongSelf = nil
                })
    }
    
    /**
     内部処理用、アラートインスタンス生成 & コールバック用オブジェクト保持
     */
    private func show() -> Observable<Int> {
        strongSelf = self
        
        let viewController = UIViewController()
        alertWindow.backgroundColor = UIColor.clearColor()
        alertWindow.windowLevel = UIWindowLevelAlert + 1000
        
        alertWindow.rootViewController = viewController
        alertWindow.makeKeyAndVisible()
        
        viewController.presentViewController(
            alertController!,
            animated: true, completion: { () -> Void in
            
        })
        
        return create {
            [weak self] (observer: AnyObserver<Int>) -> Disposable in
            self?.observer = observer
            
            return AnonymousDisposable {
                
            }
        }
    }
    
    /**
     タイトル、メッセージ、コールバックを指定してアラートを表示する
     特に、インスタンス保持の必要はない
     
     - parameter title:        タイトル
     - parameter message:      本文
     - parameter buttonTitles: ボタンタイトル配列
     
     - returns: Subscribeした場合は選択ボタンインデックスが通知される
     */
    public class func show(
        title title: String,
        message: String!,
        buttonTitles: [String]) -> Observable<Int> {
            
            let alertController = Alert(
                title: title,
                message: message,
                titles: buttonTitles)
            
            return alertController.show()
    }
}
