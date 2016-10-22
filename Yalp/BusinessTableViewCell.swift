//
//  BusinessTableViewCell.swift
//  Yalp
//
//  Created by Bill on 10/13/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
    
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var reivewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dollarLabel: UILabel!

    var imageUrlString: String? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        businessImageView.layer.cornerRadius = 3
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(businessSummary: BusinessSummaryDTO) -> Void {

        let cell = self;
        
        cell.businessImageView.image = nil
        cell.businessNameLabel.text = businessSummary.name
        cell.reivewsLabel.text = "\(businessSummary.reviewCount) reviews"
        cell.addressLabel.text = businessSummary.fullAddress
        cell.categoryLabel.text = businessSummary.categories
        
        if (businessSummary.distance >= 0) {
            let miles: Double = Double(businessSummary.distance) * 0.000621371
            cell.distanceLabel.text = String(format:"%.02f mi", miles)
        }
        else {
            cell.distanceLabel.text = "?? mi"
        }
        cell.dollarLabel.text = businessSummary.price
        cell.ratingLabel.text = String(businessSummary.rating)
        if let imageUrl = URL(string: businessSummary.imageUrlString) {
            cell.businessImageView.setImageWith(imageUrl)
            
            
            let urlRequest: URLRequest = URLRequest(url:imageUrl)
            cell.imageUrlString = businessSummary.imageUrlString
            cell.businessImageView.setImageWith(_:urlRequest, placeholderImage: nil,
                                                  success: { (request: URLRequest, response: HTTPURLResponse?, image: UIImage) -> Void in
                                                    //nil `response` means image came from cache
                                                    if (response != nil) {
                                                        cell.businessImageView.alpha = 0.0;
                                                        cell.businessImageView.image = image
                                                        UIView.animate(withDuration: 0.3, animations: { () -> Void in
                                                            cell.businessImageView.alpha = 1.0
                                                        })
                                                    }
                                                    else {
                                                        cell.businessImageView.image = image
                                                    }
                },
                                                  failure: { (request: URLRequest, response: HTTPURLResponse?, error: Error) -> Void in
                                                    dlog("image fetch failed: \(error) for url: \(cell.imageUrlString)")
                                                    cell.businessImageView.image = nil})
            
        }
        else {
            dlog("no imageurl: \(businessSummary.name)")
            cell.businessImageView.image = nil
        }

        
        
    }

}
