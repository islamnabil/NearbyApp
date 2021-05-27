//
//  HomeVC.swift
//  NearBy
//
//  Created by Islam Elgaafary on 23/05/2021.
//

import UIKit
import CoreLocation
import PKHUD

class HomeVC: UIViewController {
    //MARK:- Properties
    var nearbyPlaceViewModel = NearbyPlacesViewModel.shared
    
    // MARK:- IBoutlets
    @IBOutlet weak var nearbyTableView: UITableView!
    @IBOutlet weak var modeButton: UIBarButtonItem!
    var errorView: ErrorView!
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        nearbyPlaceViewModel.setupLocation(forViewCotroller: self, statusInfoFor: modeButton)
    }

    
    // MARK:- IBActions
    @IBAction func modePressed(_ sender: Any) {
        nearbyPlaceViewModel.updateMode(realtime: !AppSettings.shared.isRealTimeMode(), statusInfoFor: modeButton)
    }
    
    //MARK:- Private functions
    
    /// configureTableView : `delegate`, `dataSource`
    /// and make `separatorStyle` to be none instead of singleLine
    private func configureTableView() {
        nearbyTableView.register(UINib(nibName: "NearbyTableCell", bundle: nil), forCellReuseIdentifier: "NearbyTableCell")
        nearbyTableView.delegate = self
        nearbyTableView.dataSource = self
        nearbyTableView.separatorStyle = .none
    }


}

// MARK: - UITableView Delegate and DataSource
extension HomeVC: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearbyPlaceViewModel.placesCount
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NearbyTableCell.self),for: indexPath) as! NearbyTableCell
        let place = nearbyPlaceViewModel.place(forIndexPath: indexPath)
       // nearbyPlaceViewModel.getPlacePhoto(id: place.id ?? "", index: indexPath.row, table: tableView)
        cell.configureView(place: place)
        cell.selectionStyle = .none
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
}

extension HomeVC:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let coordinate = location.coordinate
           nearbyPlaceViewModel.getPlaces(lat: coordinate.latitude, long: coordinate.longitude, tableView: nearbyTableView)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        ErrorView(errorType: .SomeError, onView: self.view)
    }
    
}
