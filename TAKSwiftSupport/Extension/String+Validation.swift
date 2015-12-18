//
//  String+Validation.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/11.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

public enum CompOperator {
    case Less
    case LessOrEqual
    case Equal
    case GreaterOrEqual
    case Greater
}

public extension String {
    
    //MARK: - Validation
    /**
    文字数バリデーション
    
    :param: string          対象文字列
    :param: validationCount 制約数値
    :param: compOperator    比較ルール
    
    :returns: 比較ルールにそってバリデーションが通ればtrue
    */
    func validationTextCount(validationCount validationCount: Int, compOperator: CompOperator) -> Bool {
        let compare = self.characters.count - validationCount
        
        var result = false
        
        switch compOperator {
        case .Less:
            if compare < 0 {
                result = true
            }
            
        case .LessOrEqual:
            if compare <= 0 {
                result = true
            }
            
        case .Equal:
            if compare == 0 {
                result = true
            }
            
        case .GreaterOrEqual:
            if compare >= 0 {
                result = true
            }
            
        case .Greater:
            if compare > 0 {
                result = true
            }
        }
        
        return result
    }
    
    /**
     半角英数チェック
     
     :param: string 対象文字列
     
     :returns: バリデーションが通ればtrue
     */
    func validationAlphanumeric() -> Bool {
        return checkRegularExpression(pattern: "[a-zA-Z0-9]+")
    }
    
    
    /**
     正規表現ベース
     
     :param: string  対象文字列
     :param: pattern 正規表現制約
     
     :returns: バリデーションが通ればtrue
     */
    func checkRegularExpression(pattern pattern: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluateWithObject(self)
    }
}
