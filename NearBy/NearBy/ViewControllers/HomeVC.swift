//
//  HomeVC.swift
//  NearBy
//
//  Created by Islam Elgaafary on 23/05/2021.
//

import UIKit

class HomeVC: UIViewController {
    //MARK:- Properties
    
    // MARK:- IBoutlets
    @IBOutlet weak var nearbyTableView: UITableView!
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    
    // MARK:- IBActions
    @IBAction func modePressed(_ sender: Any) {
        
    }
    
    //MARK:- Private functions
    
    /// configureTableView : `delegate`, `dataSource`
    /// and make `separatorStyle` to be none instead of singleLine
    private func configureTableView() {
        nearbyTableView.delegate = self
        nearbyTableView.dataSource = self
        nearbyTableView.separatorStyle = .none
    }

    
}

// MARK: - UITableView Delegate and DataSource
extension HomeVC: UITableViewDataSource, UITableViewDelegate{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
