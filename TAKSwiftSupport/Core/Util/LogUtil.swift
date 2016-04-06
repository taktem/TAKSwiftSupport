//
//  LogUtil.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/11.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

/**
 デバッグ時のみ出力するログ 
 Pods内のOther Swift Flagsに-D DEBUGが必要
 */

public func DLog(message: AnyObject?,
    function: String = #function,
    line: Int = #line,
    file: String = #file) {
        #if DEBUG
            print("[\(lastPass(fileName: file)):\(function) Line:\(line)] : \(message)" )
        #endif
}

public func DLog(message: AnyObject,
    function: String = #function,
    line: Int = #line,
    file: String = #file) {
        #if DEBUG
            print("[\(lastPass(fileName: file)):\(function) Line:\(line)] : \(message)" )
        #endif
}

/**
 無条件で出力するログ
 */
public func ALog(message: AnyObject?,
    function: String = #function,
    line: Int = #line,
    file: String = #file) {
        print("[\(lastPass(fileName: file)):\(function) Line:\(line)] : \(message)" )
}

public func ALog(message: AnyObject,
    function: String = #function,
    line: Int = #line,
    file: String = #file) {
        print("[\(lastPass(fileName: file)):\(function) Line:\(line)] : \(message)" )
}

/**
 パス分割
 */
private func lastPass(fileName fileName: String) -> String {
    guard let lastPath = fileName.componentsSeparatedByString("/").last else {
        return ""
    }
    
    return lastPath
}

public class Benchmark {
	/// Identifier & StartDate
	private static var stockIdentifier = [String: NSDate]()
	
	/**
	Start
	
	- parameter identifier: Process Idenitifier
	*/
	public final class func startProcess(identifier: String) {
		Benchmark.stockIdentifier[identifier] = NSDate()
	}
	
	/**
	Finish
	
	- parameter identifier: Process Identifier
	*/
	public final class func finishProcess(identifier: String) {
		guard let startTime = Benchmark.stockIdentifier[identifier] else {
			return
		}
		Benchmark.stockIdentifier.removeValueForKey(identifier)
		
		let elapsed = NSDate().timeIntervalSinceDate(startTime)
		let formatedElapsed = String(format: "%.3f", elapsed)
		DLog("Benchmark: \(identifier), Elasped time: \(formatedElapsed)(s)")
	}
}
