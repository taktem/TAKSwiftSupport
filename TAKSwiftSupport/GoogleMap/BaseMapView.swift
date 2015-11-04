//
//  BaseMapView.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/09/19.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import GoogleMaps

enum MyError: ErrorType {
    case UnexpectedError
}
func myfunc() throws {
    throw MyError.UnexpectedError
}

class BaseMapView: UIView, GMSMapViewDelegate {

    // Default Setting
    private let DEFAULT_LATITUDE = 35.6969946
    private let DEFAULT_LONGITUDE = 139.678996
    private let DEFAULT_ZOOM = Float(13.0)
    
    // Map Key
    var mapKey: String?
    
    // MapView
    private(set) var mapView: GMSMapView!
    
    // Last used zoom value
    private var currentZoom = Float(13.0)
    
    // Displayed Markers
    private var displayedMarkerArray = [GMSMarker]()
    
    // MARK: - Cycle
    /**
    Init Map With Degault Setting
    */
    func initMapView() {
        self.initMapView(
            latitude: DEFAULT_LATITUDE,
            longitude: DEFAULT_LONGITUDE,
            zoom: DEFAULT_ZOOM)
    }
    
    /**
    Init Map
    
    - parameter latitude:  Latidue
    - parameter longitude: Longitude
    - parameter zoom:      Zoom
    */
    func initMapView(
        latitude latitude:Double,
        longitude: Double,
        zoom: Float) {
            guard (mapKey != nil) else {
                print("GoogleMap key not set")
                return
            }
            
            let baseView = UIView(frame: self.bounds)
            baseView.backgroundColor = UIColor.blackColor()
            
            // Setting Google Map Key
            GMSServices.provideAPIKey(mapKey)
            
            // Setting camera parameter
            let camera = GMSCameraPosition.cameraWithLatitude(
                latitude,
                longitude: longitude,
                zoom: zoom)
            
            // Init map
            mapView = GMSMapView.mapWithFrame(self.bounds, camera: camera)
            mapView.myLocationEnabled = true
            mapView.delegate = self
    }
    
    /**
    Show MapView
    */
    func show() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mapView)
        
        setAutoLayout()
    }
    
    /**
    Setting Autolayout MapView To SuperView
    */
    private func setAutoLayout() {
        let viewsDictionary = [
            "mapView":self.mapView
        ]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[mapView]-0-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[mapView]-0-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary))
    }
    
    // MARK: - Control
    /**
    マップをクリアし、保存している情報をすべて破棄する
    */
    func clearMapview() {
        mapView.clear()
        displayedMarkerArray.removeAll()
    }
    
    /**
    緯度経度と、最後に指定したズーム値を指定してカメラ移動
    
    - parameter latitude:  緯度
    - parameter longitude: 経度
    */
    func setLocationWithLatitude(
        latitude latitude:Double,
        longitude:Double) {
            self.setLocationWithLatitude(
                latitude: latitude,
                longitude: longitude,
                zoom: currentZoom)
    }
    
    /**
    緯度経度、ズーム値を指定してカメラ移動
    
    - parameter latitude:  緯度
    - parameter longitude: 経度
    - parameter zoom:      ズーム
    */
    func setLocationWithLatitude(
        latitude latitude:Double,
        longitude:Double,
        zoom:Float) {
            // ズーム値を記憶
            currentZoom = zoom
            
            // カメラ移動
            self.mapView.animateToCameraPosition(GMSCameraPosition.cameraWithLatitude(
                latitude,
                longitude: longitude,
                zoom: zoom))
    }
    
    // MARK: - Marker
    func addMarker(entity entity: GMSMarkerEntity) -> GMSMarker {
        let marker = GMSMarker()
        
        marker.position = CLLocationCoordinate2DMake(
            entity.latitude,
            entity.longitude
        )
        
        marker.title = entity.name
        marker.snippet = entity.snippet
        
        if let e = entity.iconImage {
            marker.icon = e
        }
        
        if let e = entity.userData {
            marker.userData = e
        }
        
        marker.appearAnimation = kGMSMarkerAnimationPop
        
        displayedMarkerArray.append(marker)
        
        marker.map = self.mapView
        
        return marker
    }
    
    // MARK: - Delegate
    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {
        currentZoom = position.zoom
    }
}
