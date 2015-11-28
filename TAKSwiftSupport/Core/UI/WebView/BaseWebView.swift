//
//  BaseWebView.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/07.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import WebKit

@objc public protocol BaseWebViewDelegate: UIWebViewDelegate {
    /**
     WEBView内ロードではなく、Pushして読み込む必要がある場合
     
     - parameter url: 読み込み対象URL
     */
    optional func pushWebViewController(url url: NSURL)

     /**
     WEBView内ロードではなく、その他アクションを必要とする場合
     
     - parameter url: 読み込み対象URL
     */
    optional func isNeedSomeAction(url url: NSURL)
}

public class BaseWebView: UIWebView, UIWebViewDelegate {
    
    /// 外部ブラウザで開くべきURL文字列Set
    var openSafariUrlStringSet = Set<String>()
    
    /// Pushで開くべきURL文字列Set
    var pushUrlStringSet = Set<String>()
    
    /// その他、カスタムアクションを行うURL文字列Set
    var needActionUrlStringSet = Set<String>()
    
    /// デリゲートを統合する
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
    
    /// デリゲート統合用
    private weak var baseWebViewDelegate: BaseWebViewDelegate?
    
    /// htmlタイトル
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
    
    //MARK: - WEBView Delegate
    public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        var allow = true
        if let result = baseWebViewDelegate?.webView?(webView, shouldStartLoadWithRequest: request, navigationType: navigationType) {
            allow = result
        }
        
        allow = !(
            !allow || // Superクラスで非許可の場合は中断
            isOpenSafari(url: request.URL) // 外部ブラウザ対象だったら中断
        )
        
        return allow
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
    
    // Open Permission
    /**
    外部ブラウザ対象URLを追加する（部分一致
    
    - parameter strings: 外部ブラウザ対象URL文字列配列
    */
    final public func addDenyUrlStrings(strings strings: [String]) {
        for string in strings {
            openSafariUrlStringSet.insert(string)
        }
    }
    
    /**
     読み込み時にPushすべきURLを追加する（部分一致）
     
     - parameter strings: Push対象URL文字列配列
     */
    final public func addPushUrlStrings(strings strings: [String]) {
        for string in strings {
            pushUrlStringSet.insert(string)
        }
    }
    
    /**
     読み込み時にアクションを必要とするURLを追加する（部分一致）
     
     - parameter strings: Push対象URL文字列配列
     */
    final public func addNeedActionUrlStrings(strings strings: [String]) {
        for string in strings {
            needActionUrlStringSet.insert(string)
        }
    }
    
    /**
    *  URLが外部ブラウザ対象だったら読み込み拒否を返し、外部ブラウザを開く
    *
    *  @param url 対象URL
    *
    *  @return 読み込み許可する場合YES
    */
    private func isOpenSafari(url url: NSURL?) -> Bool {
        var result = false
        
        // 非許可文字列検索
        for denyString in openSafariUrlStringSet {
            if
                let url = url,
                let _ = url.absoluteString.rangeOfString(denyString) {
                result = true
                
                if UIApplication.sharedApplication().canOpenURL(url) {
                    UIApplication.sharedApplication().openURL(url)
                }
                
                break
            }
        }

        return result
    }
}

extension UIWebView {
    //MARK: - Util
    public class func addUserAgent(string: String) {
        let webView = UIWebView(frame:CGRectZero)
        let useragent : String = webView.sendJavaScript(string: "navigator.userAgent")!
        
        let addedUserAgent = useragent.stringByAppendingString(string)
        
        let agentDict = ["UserAgent":addedUserAgent]
        NSUserDefaults.standardUserDefaults().registerDefaults(agentDict)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /**
     WebViewに対してJS Functionをコールする
     
     - parameter string: JS文字列
     */
    public func sendJavaScript(string string: String) -> String? {
        return self.stringByEvaluatingJavaScriptFromString(string)
    }
}
