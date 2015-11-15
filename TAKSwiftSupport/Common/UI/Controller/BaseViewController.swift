//
//  BaseViewController.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/07.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIViewController {
    public class func initWithStoryBoard(
        storyBoardName storyBoardName: String
        ) -> UIViewController? {
        let storyBoard = UIStoryboard.init(name: storyBoardName, bundle: NSBundle.mainBundle())
        return storyBoard.instantiateInitialViewController()
    }
    
    public class func initWithStoryBoard(
        storyBoardName storyBoardName: String,
        identifier: String
        ) -> UIViewController? {
        let storyBoard = UIStoryboard.init(name: storyBoardName, bundle: NSBundle.mainBundle())
        return storyBoard.instantiateViewControllerWithIdentifier(identifier)
    }
}
