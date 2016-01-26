//
//  ShareUtil.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2016/01/26.
//  Copyright © 2016年 TakuNishimura. All rights reserved.
//

import UIKit

/// OS標準シェア制御用
public class ShareUtil: NSObject {
    
    /// シェアActivityViewController
    private var shareController: UIActivityViewController?
    
    /**
     URLを指定してシェア
     */
    public func shareWithUrl(url: NSURL) -> Self {
        shareController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        return self
    }
    
    /**
     KeyWindowにシェア表示
     */
    public final func show() {
        guard let
            window = UIApplication.sharedApplication().keyWindow,
            shareController = shareController else {
            return
        }
        
        window.rootViewController?.presentViewController(shareController, animated: true, completion: nil)
    }
}
