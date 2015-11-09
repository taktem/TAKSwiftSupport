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

extension BaseViewController {
    public class func initWithStoryBoard(
        storyBoardName storyBoardName: String
        ) -> BaseViewController? {
        let storyBoard = UIStoryboard.init(name: storyBoardName, bundle: NSBundle.mainBundle())
        return storyBoard.instantiateInitialViewController() as? BaseViewController
    }
    
    public class func initWithStoryBoard(
        storyBoardName storyBoardName: String,
        identifier: String
        ) -> BaseViewController? {
        let storyBoard = UIStoryboard.init(name: storyBoardName, bundle: NSBundle.mainBundle())
        return storyBoard.instantiateViewControllerWithIdentifier(identifier) as? BaseViewController
    }
}
