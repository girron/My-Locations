//
//  LocationCell.swift
//  MyLocations
//
//  Created by Jack Burton on 8/3/16.
//  Copyright © 2016 Pork Chop Express. All rights reserved.////

import UIKit

class LocationCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureForLocation(_ location: Location) {
        if location.locationDescription.isEmpty {
            descriptionLabel.text = "(No Description)"
        } else {
            descriptionLabel.text = location.locationDescription
        }
        
        if let placemark = location.placemark {
            var text = ""
            text.addText(text: placemark.subThoroughfare)
            text.addText(text: placemark.thoroughfare, withSeparator: " ")
            text.addText(text: placemark.locality, withSeparator: ", ")
            addressLabel.text = text
        } else {
            addressLabel.text = String(format: "Lat: %.8f, Long: %.8f", location.latitude, location.longitude)
        }
        photoImageView.image = imageForLocation(location)
    }
    
    func imageForLocation(_ location: Location) -> UIImage {
        if location.hasPhoto, let image = location.photoImage {
            return image.resizedImageWithBounds(CGSize(width: 52, height: 52))
        }
        return UIImage()
    }

}
