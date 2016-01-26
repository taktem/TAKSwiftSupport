//
//  String+Format.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/11.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

public extension String {
    
    /**
    *  金額などの、カンマ３桁区切り
    *
    *  @param value 元になる数値
    */
    static func stringByCurrencyFormat(value value: Int) -> String {
        return stringByNumeralFormatWithValue(value, separator: ",", size: 3)
    }
    
    /**
     *  フォーマットを指定して、数値を文字列に変換する
     *
     *  @param value     元になる数値
     *  @param separator 区切り文字
     *  @param size      グルーピング文字数
     */
    static func stringByNumeralFormatWithValue(
        value: Int,
        separator: String,
        size: Int
        ) -> String {
            let format = NSNumberFormatter()
            format.numberStyle = .DecimalStyle
            format.groupingSeparator = separator
            format.groupingSize = size
            
            return format.stringForObjectValue(value)!
    }
}
