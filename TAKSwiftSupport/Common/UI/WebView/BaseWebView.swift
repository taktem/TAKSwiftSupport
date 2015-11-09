//
//  BaseWebView.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/07.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import WebKit

@objc public protocol BaseWebViewDelegate: UIWebViewDelegate {
    
}

public class BaseWebView: UIWebView, UIWebViewDelegate {
    
    // デリゲートを統合する
    override public var delegate: UIWebViewDelegate? {
        didSet {
            guard let delegate = delegate else {
                return
            }
            
            if unsafeAddressOf(delegate) != unsafeAddressOf(self) {
                baseWebViewDelegate = delegate as? BaseWebViewDelegate
            }
            
            super.delegate = self
        }
    }
    
    // デリゲート統合用
    private weak var baseWebViewDelegate: BaseWebViewDelegate?
    
    // htmlタイトル
    public var title: String? {
        get {
            return self.stringByEvaluatingJavaScriptFromString("document.title")
        }
    }
    
    //MARK: - Cycle
    public init () {
        super.init(frame: CGRectZero)
        delegate = self
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    //MARK: - Util
    public class func setUserAgent(string: String) {
        let webView = UIWebView()
        let userAgent = webView.stringByEvaluatingJavaScriptFromString("navigator.userAgent")
        let customUserAgent = userAgent?.stringByAppendingString(string)
        
        if let val = customUserAgent {
            NSUserDefaults.standardUserDefaults().registerDefaults(["UserAgent":val])
        }
    }
    
    //MARK: - WEBView Delegate
    public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if let result = baseWebViewDelegate?.webView?(webView, shouldStartLoadWithRequest: request, navigationType: navigationType) {
            return result
        }
        
        return true
    }
    
    public func webViewDidStartLoad(webView: UIWebView) {
        baseWebViewDelegate?.webViewDidStartLoad?(webView)
    }
    
    public func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        baseWebViewDelegate?.webView?(webView, didFailLoadWithError: error)
    }
    
    public func webViewDidFinishLoad(webView: UIWebView) {
        baseWebViewDelegate?.webViewDidFinishLoad?(webView)
    }
}
