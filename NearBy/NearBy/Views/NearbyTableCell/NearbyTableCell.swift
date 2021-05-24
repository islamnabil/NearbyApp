//
//  NearbyTableCell.swift
//  NearBy
//
//  Created by Islam Elgaafary on 23/05/2021.
//

import UIKit

class NearbyTableCell: UITableViewCell {

    // MARK:- IBoutlets
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeeAddressLabel: UILabel!
    
    func configureView(place:PlaceModel) {
        placeImage.SetImage(link: place.image ?? "")
        placeNameLabel.text = place.name ?? ""
        placeeAddressLabel.text = place.location?.address ?? ""
    }
    
}
