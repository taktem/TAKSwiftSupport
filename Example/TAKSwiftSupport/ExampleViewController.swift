//
//  ExampleViewController.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/09/19.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ExampleViewController: UIViewController {
    
    // Alertサンプル用ラベル
    @IBOutlet private weak var alertLabel: UILabel!
    
    /// Rx
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - ALERT Example
    @IBAction func alertButtonTapped(sender: UIButton) {
        Alert.show(
            title: "タイトル",
            message: "テストメッセージ",
            buttonTitles: ["OK", "Cancel"])
            .subscribeNext {
                [unowned self] selectedIndex -> Void in
                switch selectedIndex {
                case 0:
                    self.alertLabel.text = "OK"
                    
                case 1:
                    self.alertLabel.text = "Cancel"
                    
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
