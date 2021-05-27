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
        
        
        /// NOTE: `VenuesPhotos` endPoint is a `premium` calls, so it has a daily limits.
        /// Source: https://developer.foursquare.com/docs/places-api/rate-limits
        ///
        /// Exceeding limits API will return a`429 error` until the time of reset
        /// so in this case I assume the returned imageLink data is `"imageLink"` instead of real link
        /// and make the image's background color to be `Yellow` for as the downloaded image indicator.
        if place.image == "imageLink" {
            placeImage.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        }else {
            placeImage.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        
    }

    
}
