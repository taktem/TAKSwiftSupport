//
//  BaseTableView.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/04.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

public class BaseTableView: UITableView {
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        layoutMargins = UIEdgeInsetsZero
    }
}
