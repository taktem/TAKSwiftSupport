//
//  Alert.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/09/16.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

public class Alert: NSObject {
    
    typealias AlertCompleteBlock = (index: Int) -> Void
    
    private var alertCompleteBlock: AlertCompleteBlock?
    private var alertController :UIAlertController?
    private var strongSelf: Alert?
    
    private let alertWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
    
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
    
    private func addAction(
        title title: String,
        index:Int) -> UIAlertAction {
            return UIAlertAction(title: title, style: .Default, handler: {
                [unowned self](action: UIAlertAction!) -> Void in
                if let block = self.alertCompleteBlock {
                    block(index: index)
                }
                })
    }
    
    func didButtonTapped(callback: AlertCompleteBlock) {
        alertCompleteBlock = callback
    }
    
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
        
        return create { observer -> Disposable in
            self.didButtonTapped {
                [weak self](index) -> Void in
                self?.strongSelf = nil
                
                self?.alertWindow.rootViewController?.view.removeFromSuperview()
                self?.alertWindow.rootViewController = nil;
                
                self?.alertWindow.windowLevel = -1000
                
                observer.on(.Next(index))
                observer.onCompleted()
            }
            
            return AnonymousDisposable {
                
            }
        }
    }
    
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
