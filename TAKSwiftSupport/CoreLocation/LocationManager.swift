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
    private let stockLocation: Variable<CLLocation?> = Variable(nil)
    public let currentLocation: Variable<CLLocation?> = Variable(nil)
    
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
        stockLocation
            .filter({ location -> Bool in
                return location != nil
            })
            .subscribeNext {
                [weak self] location -> Void in
                
                self?.currentLocation.value = location
            }
            .addDisposableTo(disposeBag)
        
        manager.startUpdatingLocation()
    }
    
    public func startUpdatingLocationOnce() {
        stockLocation
            .filter({ location -> Bool in
                return location != nil
            })
            .take(1)
            .subscribeNext {
                [weak self] location -> Void in
                
                self?.currentLocation.value = location
                
                self?.stopUpdatingLocation()
            }
            .addDisposableTo(disposeBag)
        
        manager.startUpdatingLocation()
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
        
        stockLocation.value = location
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
