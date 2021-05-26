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
    private var placeId:String?
    
    func configureView(place:PlaceModel) {
        placeId = place.id
        placeNameLabel.text = place.name ?? ""
        placeeAddressLabel.text = place.location?.address ?? ""
        placeImage.SetImage(link:place.image ?? "")
        
        if place.image == "imageLink" {
            placeImage.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        }else {
            placeImage.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        
    }

    
}
