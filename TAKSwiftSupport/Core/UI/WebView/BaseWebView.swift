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
    
    /// URLリクエスト許可ステータス初期値
    public var defaultAllowLoadRequest = true
    
    /// 外部ブラウザで開くべきURL文字列Set
    private var denyiUrlStringSet = Set<String>()
    
    /// 読み込み許可対象URL文字列セット
    private var allowUrlContainSet = Set<String>()
    
    /// Pushで開くべきURL文字列Set
    private  var pushUrlStringSet = Set<String>()
    
    /// その他、カスタムアクションを行うURL文字列Set
    private var needActionUrlStringSet = Set<String>()
    
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
            isOpenSafari(url: request.URL) || // 外部ブラウザ対象だったら中断
            isPushUrl(url: request.URL) || // Push遷移対象URLだったら中断
            isNeedAction(url: request.URL) // カスタムアクション対象URLだったら中断
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
            denyiUrlStringSet.insert(string)
        }
    }
    
    // Open Permission
    /**
    読み込み許可対象URLを追加する（部分一致
    
    - parameter strings: 外部ブラウザ対象URL文字列配列
    */
    final public func addAllowUrlStrings(strings strings: [String]) {
        for string in strings {
            allowUrlContainSet.insert(string)
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
    *  @return 読み込み許可する場合true
    */
    private func isOpenSafari(url url: NSURL?) -> Bool {
        var allow = defaultAllowLoadRequest
        
        guard let url = url else {
            return allow
        }
        
        // 非許可文字列検索
        for denyString in denyiUrlStringSet {
            if let _ = url.absoluteString.rangeOfString(denyString) {
                allow = true
                
                break
            }
        }
        
        // 許可文字列検索
        for allowString in allowUrlContainSet {
            if let _ = url.absoluteString.rangeOfString(allowString) {
                allow = false
                
                break
            }
        }
        
        // 非許可の場合は外部ブラウザへ
        if allow {
            if UIApplication.sharedApplication().canOpenURL(url) {
                UIApplication.sharedApplication().openURL(url)
            }
        }

        return allow
    }
    
    /**
     URLがPush対象だったら読み込み拒否を返し、PushDelegateをコールする
     
     - parameter url: 対象URL
     
     - returns: 別画面へPushする場合はtrue
     */
    private func isPushUrl(url url: NSURL?) -> Bool {
        var allow = defaultAllowLoadRequest
        
        // 非許可文字列検索
        for denyString in pushUrlStringSet {
            if
                let url = url,
                let _ = url.absoluteString.rangeOfString(denyString) {
                    allow = true
                    
                    self.baseWebViewDelegate?.pushWebViewController?(url: url)
                    
                    break
            }
        }
        
        return allow
    }
    
    /**
     カスタムアクションを必要とする場合
     
     - parameter url: 対象URL
     
     - returns: カスタムアクションを必要とする場合はtrue
     */
    private func isNeedAction(url url: NSURL?) -> Bool {
        var result = defaultAllowLoadRequest
        
        // 非許可文字列検索
        for denyString in needActionUrlStringSet {
            if
                let url = url,
                let _ = url.absoluteString.rangeOfString(denyString) {
                    result = true
                    
                    self.baseWebViewDelegate?.isNeedSomeAction?(url: url)
                    
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
