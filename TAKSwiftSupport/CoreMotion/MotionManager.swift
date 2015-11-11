//
//  MotionManager.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/11.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

import UIKit
import CoreMotion

public class MotionManager: NSObject {
    private let manager = CMMotionManager()
    
    public func startAccelerometerUpdates(interval interval: NSTimeInterval) {
        manager.accelerometerUpdateInterval = interval;
        
        guard let queue = NSOperationQueue.currentQueue() else {
            return
        }
        
        manager.startAccelerometerUpdatesToQueue(queue) {
            (data: CMAccelerometerData?, error: NSError?) -> Void in
            
            let x = data?.acceleration.x
            let y = data?.acceleration.y
            let z = data?.acceleration.z
            
            print("x: \(x), y: \(y), z: \(z)")
        }
    }
    
    public func stopAccelerometerUpdates() {
        manager.stopAccelerometerUpdates()
    }
}