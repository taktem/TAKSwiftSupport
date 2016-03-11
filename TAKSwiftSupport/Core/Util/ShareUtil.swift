//
//  ShareUtil.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2016/01/26.
//  Copyright © 2016年 TakuNishimura. All rights reserved.
//

import UIKit

/// UIActivityViewController Control
public class ShareUtil: NSObject {
    
    // Window
    private var window: UIWindow?
    
    /// ActivityViewController
    private var shareController: UIActivityViewController?
    
    /**
     Share with URL
     */
    public func shareWithUrl(url: NSURL) -> Self {
        shareController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        shareController?.completionWithItemsHandler = { [ weak self] _ in
            self?.didComplete()
        }
        
        return self
    }
    
    /**
     Show ShareWindow
     */
    public final func show() {
        
        guard let shareController = shareController else {
            return
        }
        
        // Window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.clearColor()
        window?.windowLevel = UIWindowLevelAlert - 2
        window?.makeKeyAndVisible()
        
        // RootViewController
        let controller = UIViewController()
        window?.rootViewController = controller
        
        controller.presentViewController(shareController, animated: true, completion: nil)
    }
    
    private final func didComplete() {
        window?.rootViewController = nil
        window = nil
    }
}
