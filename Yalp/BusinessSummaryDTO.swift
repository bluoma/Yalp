//
//  BusinessSummaryDTO.swift
//  Yalp
//
//  Created by Bill on 10/12/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import Foundation

class BusinessSummaryDTO : CustomStringConvertible, CustomDebugStringConvertible {
    
    var businessId: String = ""
    var name: String = ""
    var address: String = ""
    var city: String = ""
    var state: String = ""
    var zipCode: String = ""
    var countryCode: String = ""
    var phoneNumber: String = ""
    var urlString: String = ""
    var imageUrlString: String = ""
    var categories: String = ""
    var distance: Int = -1
    var reviewCount: Int = 0
    var rating: Double = 0.0
    var price: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0

    var fullAddress: String {
        return "\(address) \(city), \(state) \(zipCode)"
    }
    
    init() {
        
    }
    
    convenience init(jsonDict: NSDictionary) {
        self.init()
        
        if let businessId = jsonDict["id"] as? String {
            self.businessId = businessId
        }
        if let name = jsonDict["name"] as? String {
            self.name = name
        }
        if let locDict = jsonDict["location"] as? NSDictionary,
           let address = locDict["address1"] as? String,
           let city = locDict["city"] as? String,
           let state = locDict["state"] as? String,
           let zipCode = locDict["zip_code"] as? String,
           let countryCode = locDict["country"] as? String
        {
            self.address = address
            self.city = city
            self.state = state
            self.zipCode = zipCode
            self.countryCode = countryCode
        }
        if let phone = jsonDict["phone"] as? String {
            self.phoneNumber = phone
        }
        if let url = jsonDict["url"] as? String {
            self.urlString = url
        }
        if let imageUrl = jsonDict["image_url"] as? String {
            self.imageUrlString = imageUrl
        }
        if let imageUrl = jsonDict["image_url"] as? String {
            self.imageUrlString = imageUrl
        }
        if let latitude = jsonDict.value(forKeyPath: "coordinates.latitude") as? Double {
            self.latitude = latitude
        }
        if let longitude = jsonDict.value(forKeyPath: "coordinates.longitude") as? Double {
            self.longitude = longitude
        }
        if let price = jsonDict["price"] as? String {
            self.price = price
        }
        if let reviewCount = jsonDict["review_count"] as? Int {
            self.reviewCount = reviewCount
        }
        if let rating = jsonDict["rating"] as? Double {
            self.rating = rating
        }
        if let cats = jsonDict["categories"] as? [[String: AnyObject]] {
            
            for (i, cat) in cats.enumerated() {
                
                if let catName = cat["title"] as? String {
                    if (i < cats.count - 1) {
                        categories += catName + ", "
                    }
                    else {
                        categories += " " + catName
                    }
                }
            }
        }
    }
    
    var description: String {
        return "id: \(businessId), name: \(name), address: \(address) \(city), \(state)  \(zipCode) imageUrl: \(imageUrlString) cats: \(categories)"
    }
    
    var debugDescription: String {
        return "id: \(businessId), name: \(name), address: \(address) \(city), \(state)  \(zipCode) imageUrl: \(imageUrlString)"
    }

    

}


/*
 
 {
 "id": "chai-thai-noodles-oakland-2",
 "url": "https://www.yelp.com/biz/chai-thai-noodles-oakland-2?adjust_creative=nqpS3O6BlMmugVQrcuPuYA&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=nqpS3O6BlMmugVQrcuPuYA",
 "rating": 4,
 "categories": [
 {
 "title": "Thai",
 "alias": "thai"
 },
 {
 "title": "Laotian",
 "alias": "laotian"
 },
 {
 "title": "Noodles",
 "alias": "noodles"
 }
 ],
 "name": "Chai Thai Noodles",
 "coordinates": {
 "latitude": 37.794959,
 "longitude": -122.253372
 },
 "price": "$$",
 "image_url": "https://s3-media4.fl.yelpcdn.com/bphoto/xaL1DyV9x-0xs0veQ6PxKQ/o.jpg",
 "review_count": 679,
 "phone": "+15108322500",
 "location": {
 "address1": "545 International Blvd",
 "zip_code": "94606",
 "city": "Oakland",
 "state": "CA",
 "country": "US",
 "address3": "",
 "address2": "Ste B"
 }
 }
 
 
 */
