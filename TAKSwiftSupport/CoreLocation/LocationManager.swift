//
//  LocationManager.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/12/13.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

import CoreLocation

import RxSwift

/// CoreLocation
public class LocationManager: NSObject, CLLocationManagerDelegate {
    
    /// Singleton Object
    public static let sharedInstance: LocationManager = LocationManager()
    
    /// Rx
    private let disposeBag = DisposeBag()
    
    /// CoreLocation Instance
    let manager = CLLocationManager()
    
    /// Location
    public let currentLocation = Variable(CLLocation(latitude:35.681382, longitude: 139.7638953))
    
    /// 要求精度
    public var verticalAccuracy = 100.0
    public var horizontalAccuracy = 100.0
    
    /// Cycle
    public override init() {
        super.init()
        
        // 初期設定
        defaultSetting()
    }
    
    //MARK: - Util
    private func defaultSetting() {
        
        // Delegate
        manager.delegate = self
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyBest

        // パーミッション要求
        manager.requestWhenInUseAuthorization()
    }
    
    //MARK: - Controller
    /**
    ロケーション取得開始
    */
    public func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }
    
    public func startUpdatingLocationOnce() {
        currentLocation
            .filter {
                [weak self] location -> Bool in
                
                var result = true
                
                // 精度フィルタ
                if location.verticalAccuracy < self?.verticalAccuracy &&
                    location.horizontalAccuracy < self?.horizontalAccuracy {
                        result = true
                }
                
                return result
            }
            .take(1)
            .subscribeNext {
                [weak self] location -> Void in
                self?.stopUpdatingLocation()
            }
            .addDisposableTo(disposeBag)
        
        startUpdatingLocation()
    }
    
    
    /**
    ロケーション取得停止
    */
    public func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
        manager.delegate = nil
    }
    
    //MARK: - Delegate
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // 精度フィルタ
        if location.verticalAccuracy > verticalAccuracy ||
            location.horizontalAccuracy > horizontalAccuracy {
                return
        }
        
        currentLocation.value = location
    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
    }
    
    public func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        
    }
    
    public func locationManagerDidPauseLocationUpdates(manager: CLLocationManager) {
        
    }
    
    public func locationManagerDidResumeLocationUpdates(manager: CLLocationManager) {
        
    }
}
