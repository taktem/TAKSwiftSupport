//
//  LoadingView.swift
//  Pods
//
//  Created by 西村 拓 on 2015/12/05.
//
//

import UIKit

public final class LoadingView: UIView {
    
    // Default loading icon size
    private static let DEFAULT_IMAGE_SIZE = CGSizeMake(40.0, 40.0)
    
    // Minimum loading time
    private static let MIN_SHOW_LOADING_TIME = 0.4
    
    // Window
    private var loadingWindow: UIWindow?
    
    // LoadingImage
    var loadingImage: UIImage? {
        didSet {
            loadingImageView.image = loadingImage
            
            if let size = imageSize {
                loadingImageView.frame.size = size
            } else {
                loadingImageView.frame.size = LoadingView.DEFAULT_IMAGE_SIZE
            }
        }
    }
    
    // Loading animation images
    
    // Loading icon size
    var imageSize: CGSize? {
        didSet {
            if let size = imageSize {
                loadingImageView.frame.size = size
            }
        }
    }
    
    // Loading start time
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
        
        loadingImageView.frame.size = LoadingView.DEFAULT_IMAGE_SIZE
        loadingImageView.center = self.center
        loadingImageView.backgroundColor = UIColor.clearColor()
        
        addSubview(loadingImageView)
    }

    // MARK: Util
    /**
    Set loading icon
    */
    public class func setLoadingImage(image: UIImage, size: CGSize?) {
        let loadingView = LoadingView.sharedInstance
        
        loadingView.loadingImage = image
        loadingView.imageSize = size
        loadingView.loadingImageView.center = loadingView.center
    }
    
    /**
     Set loading animation images
     */
    public class func setLoadingImage(images: [UIImage], size: CGSize?, duration: NSTimeInterval) {
        let loadingView = LoadingView.sharedInstance
        
        loadingView.loadingImageView.image = images.first
        loadingView.loadingImageView.animationImages = images
        loadingView.loadingImageView.animationDuration = duration
        loadingView.loadingImageView.animationRepeatCount = 0
        if let size = size {
            loadingView.loadingImageView.frame.size = size
            loadingView.loadingImageView.center = loadingView.center
        }
    }
    
    /**
    Start loading
    */
    public final class func show() {
        
        dispatch_async(dispatch_get_main_queue(), {
            let loadingView = LoadingView.sharedInstance
            loadingView.frame = UIScreen.mainScreen().bounds
            loadingView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
            
            // Stock current time
            loadingView.showDate = NSDate()
            
            // Rotate animation or Flip animation
            if loadingView.loadingImageView.animationImages?.count > 0 {
                loadingView.loadingImageView.startAnimating()
            } else {
                loadingView.startRotateAnimation()
            }
            
            loadingView.loadingWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
            loadingView.loadingWindow?.backgroundColor = UIColor.clearColor()
            loadingView.loadingWindow?.windowLevel = UIWindowLevelAlert - 1
            
            loadingView.loadingWindow?.makeKeyAndVisible()
            loadingView.loadingWindow?.addSubview(loadingView)
            
            UIView.animateWithDuration(0.3, animations: { _ in
                }, completion: {(Bool) -> Void in
                    loadingView.alpha = 1.0
            })
        })
    }
    
    /**
     Stop loading
     */
    public final class func dismiss() {
        let loadingView = LoadingView.sharedInstance
        
        var delayTime = 0.0;
        
        let elaspedTime = NSDate().timeIntervalSinceDate(loadingView.showDate);
        if (elaspedTime<1.5) {
            delayTime = LoadingView.MIN_SHOW_LOADING_TIME - elaspedTime;
        }
        
        loadingView.performSelector(Selector("closeAnimaton"), withObject: nil, afterDelay: delayTime)
    }
    
    // MARK: Animation
    /**
    Finish loading animation
    */
    final func closeAnimaton() {
        // Stop loading
        dispatch_async(dispatch_get_main_queue(), {
            UIView.animateWithDuration(0.4, animations: {
                self.alpha = 0.0
                }, completion: { _ in
                    self.removeFromSuperview()
                    
                    // Back to main window
                    self.loadingWindow?.windowLevel = -1000.0
                    self.loadingWindow = nil
                    UIApplication.sharedApplication().delegate?.window??.makeKeyAndVisible()
            })
        })
    }
    
    /**
     Start rotate animation
     */
    private final func startRotateAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 1.0
        animation.repeatCount = Float.infinity
        animation.fromValue = 0.0
        animation.toValue = 2 * M_PI
        
        loadingImageView.layer.addAnimation(animation, forKey: "rotate-layer")
    }
}
