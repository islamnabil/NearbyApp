//
//  LocationController.swift
//  NearBy
//
//  Created by Islam Elgaafary on 24/05/2021.
//

import UIKit
import CoreLocation


class LocationController {
    
    //MARK:-  Singleton
    private init(){}
    
    /// Access the singleton instance
    static var shared = LocationController()
    
    
    //MARK:- Properties
    
    /// Access to CLLocationManager instance
    private var locationManager = CLLocationManager()
    
    /// Latitude of cuurent location
    private var lat:Double?
    
    /// longitude of cuurent location
    private var long:Double?
    
    /// UIViewController that confirms `CLLocationManagerDelegate`
    private var viewController = UIViewController()
    
    /// Realtime mode to be `true` OR `false
    private var realTime = false
    
    
    //MARK:- Public Functions
    
    /// Setup location services
    ///
    /// - Parameters:
    ///   - viewCotroller: `UIViewController` that confirms `CLLocationManagerDelegate`
    ///   - realtime: mode to be `true` OR `false`
    func setupLocation(viewController:UIViewController & CLLocationManagerDelegate, realtime:Bool){
        
        self.viewController = viewController
        self.realTime = realtime
        
        locationManager.delegate = viewController
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            let authorizationStatus = CLLocationManager.authorizationStatus()
            
            if (authorizationStatus == CLAuthorizationStatus.denied) {
                showEnableLocationServices()
            }
            if CLLocationManager.locationServicesEnabled() {
                requestLocation(realTime: realtime)
            }
        }
    }
    
    
    /// Request location Data
    /// if `realtime` is `true`, then `startMonitoringSignificantLocationChanges` as with it Apps can expect a notification as soon as the device moves 500 meters or more from its previous notification. It should not expect notifications more frequently than once every five minutes.
    /// if `realtime` is `false`, then `requestLocation` requests location data once.
    ///
    ///
    /// `NOTE`: if I calculate the the diffrence distance to be every 500 meters with `didUpdateLocations` it will consume more energy and resources. and I think we don't need this high accuracy in the app.
    ///
    /// - Parameters:
    ///   - realtime: mode to be `true` OR `false`
     func requestLocation(realTime:Bool) {
        realTime ? locationManager.startMonitoringSignificantLocationChanges(): locationManager.requestLocation()
    }
    
    
    
    //MARK:- Private Functions
    private func showEnableLocationServices() {
        let alert = UIAlertController(title: "", message: "Enable location Services ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (_) in
            ErrorView(errorType: .NoDataFound, onView: self.viewController.view)
            self.viewController.dismiss(animated: true, completion: nil)
        }))
        
        viewController.present(alert, animated: false, completion: nil)
    }
    
    
}



