//
//  LoadingView.swift
//  Pods
//
//  Created by 西村 拓 on 2015/12/05.
//
//

import UIKit

public class LoadingView: UIView {
    
    // 指定基準がない場合のローティングアイコンサイズ
    private let DEFAULT_IMAGE_SIZE = CGSizeMake(40.0, 40.0)
    
    // 最低ローディング表示時間
    private let MIN_SHOW_LOADING_TIME = 0.4
    
    // Window
    private let loadingWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
    
    // ローディングイメージ
    var loadingImage: UIImage? {
        didSet {
            loadingImageView.image = loadingImage
            
            if let size = imageSize {
                loadingImageView.frame.size = size
            } else if let size = imageSize {
                loadingImageView.frame.size = size
            }
        }
    }
    
    // ローディングアイコンサイズ指定（未指定の場合画像サイズを使用）
    var imageSize: CGSize? {
        didSet {
            if let size = imageSize {
                loadingImageView.frame.size = size
            }
        }
    }
    
    // 表示時間管理用
    private var showDate = NSDate()
    
    // Loadin Icon ImageView
    private let loadingImageView = UIImageView()

    // MARK: - Singleton
    class var sharedInstance : LoadingView {
        struct Singleton {
            static let instance : LoadingView = LoadingView()
        }
        return Singleton.instance
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.mainScreen().bounds)
        
        loadingImageView.frame.size = DEFAULT_IMAGE_SIZE
        loadingImageView.center = self.center
        loadingImageView.backgroundColor = UIColor.clearColor()
        
        addSubview(loadingImageView)
    }

    // MARK: Util
    public class func setLoadingImage(image: UIImage, size: CGSize?) {
        let loadingView = LoadingView.sharedInstance
        
        loadingView.loadingImage = image
        loadingView.imageSize = size
    }
    
    public class func show() {
        let loadingView = LoadingView.sharedInstance
        loadingView.frame = UIScreen.mainScreen().bounds
        loadingView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        
        /** 現在時刻を設定 **/
        loadingView.showDate = NSDate()
        
        loadingView.startRotateAnimation()
        
        loadingView.loadingWindow.backgroundColor = UIColor.clearColor()
        loadingView.loadingWindow.windowLevel = UIWindowLevelAlert - 1
        loadingView.loadingWindow.makeKeyAndVisible()
        
        loadingView.loadingWindow.addSubview(loadingView)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            UIView.animateWithDuration(0.3, animations: {() -> Void in
                }, completion: {(Bool) -> Void in
                    loadingView.alpha = 1.0
            })
        })
    }
    
    public class func dismiss() {
        let loadingView = LoadingView.sharedInstance
        
        var delayTime = 0.0;
        
        let elaspedTime = NSDate().timeIntervalSinceDate(loadingView.showDate);
        if (elaspedTime<1.5) {
            delayTime = loadingView.MIN_SHOW_LOADING_TIME - elaspedTime;
        }
        
        loadingView.performSelector(Selector("closeAnimaton"), withObject: nil, afterDelay: delayTime)
    }
    
    // MARK: Animation
    func closeAnimaton() {
        /** ローディング終了 **/
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            UIView.animateWithDuration(0.4, animations: {() -> Void in
                self.alpha = 0.0
                }, completion: {(Bool) -> Void in
                    
                    self.removeFromSuperview()
                    
                    // 制御をアプリケーションメインWindowに戻す
                    self.loadingWindow.windowLevel = -1000.0
                    UIApplication.sharedApplication().delegate?.window??.makeKeyAndVisible()
            })
        })
    }
    
    private func startRotateAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 1.0
        animation.repeatCount = Float.infinity
        animation.fromValue = 0.0
        animation.toValue = 2 * M_PI
        
        loadingImageView.layer.addAnimation(animation, forKey: "rotate-layer")
    }
}
