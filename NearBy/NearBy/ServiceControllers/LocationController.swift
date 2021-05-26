//
//  LocationController.swift
//  NearBy
//
//  Created by Islam Elgaafary on 24/05/2021.
//

import UIKit
import CoreLocation


class LocationController {
    private var locationManager = CLLocationManager()
    private var lat:Double?
    private var long:Double?
    private var viewController = UIViewController()
    private var realTime = false
    
    private init(){}
    
    static var shared = LocationController()
    
    
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
                requestLocation()
            }
            
        }
    }
    
    
    private func requestLocation() {
        
        // MUST add note here WHY requestLocation 
        realTime ? locationManager.startMonitoringSignificantLocationChanges(): locationManager.requestLocation()
       
    }
    
    
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
            self.viewController.dismiss(animated: true, completion: nil)
        }))
        
            viewController.present(alert, animated: false, completion: nil)
    }
    
}



