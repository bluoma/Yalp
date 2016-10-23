//
//  BusinessFilterQueryDTO.swift
//  Yalp
//
//  Created by Bill on 10/14/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import Foundation
import CoreLocation

enum YelpSortMode: Int {
    case bestMatch = 0, distance, highestRated, reviewCount
}

class BusinessFilterQueryDTO: CustomStringConvertible, CustomDebugStringConvertible {
   
    //If term isn’t included we search everything. 
    //The term keyword also accepts business names such as "Starbucks".
    //`term`: string. Optional search term (e.g. "food", "restaurants").
    var searchTerm: String = "Restaurants"
    
    //Specifies the combination of "address, neighborhood, city, state or zip, optional country"
    //to be used when searching for businesses.
    //`location`: string. Required if either latitude or longitude is not provided.
    var location: String = ""
    
    //`latitude`: decimal
    //Required if location is not provided. Latitude of the location you want to search near by.
    //`longitude`: decimal
    //Required if location is not provided. Latitude of the location you want to search near by.
    var latLon: CLLocation = locationFromLocation(loc: sfLatLon) //SF
    
    //Search radius in meters.
    //If the value is too large, a AREA_TOO_LARGE error may be returned.
    //The max value is 40000 meters (25 miles).
    //`radius`: int. Optional.
    var searchRadius: Int = 40000
    
    //See the list of supported categories.
    //The category filter can be a list of comma delimited categories.
    //For example, "bars,french" will filter by Bars and French.
    //The category identifier should be used (for example "discgolf", not "Disc Golf").
    //`categories`: string. Optional categories to filter the search results with.
    var categories: [String] = []
    
    //Sort the results by one of the these modes: best_match, rating, review_count or distance.
    //`sort_by`: string. Optional. By default it's best_match.
    var sortBy: String = "best_match"
    
    //Additional filters to search businesses.
    //You can use multiple attribute filters at the same time by providing a comma separated string,
    //like this "attribute1,attribute2".
    //`attributes`: string. Optional. Currently, the valid values are hot_and_new and deals.
    var includeDeals: Bool = false
    var includeHotAndNew: Bool = false
    
    //user pressed search button, actually search. reset to false after FiltersViewController dismissed
    var doSearch: Bool = false
    
    //if user types in location string, use it going forward if it yeilds valid placemark
    var useCustomLocationString = false

    //prefer to use placemark, since it has city, state if populated
    var placemark: CLPlacemark? = nil
    
    
    func yelpParamDict() -> [String:Any] {
        
        var paramDict: [String:Any] = [:]
        
        paramDict["term"] = searchTerm
        
        if let placemark = self.placemark {
            
            if let placemarkLoc = placemark.location {
                paramDict["latitude"] = placemarkLoc.coordinate.latitude
                paramDict["longitude"] = placemarkLoc.coordinate.longitude
            }
            else if let city = placemark.locality,
                let state =  placemark.administrativeArea {
                paramDict["location"] = city + ", " + state
            }
        }
        else {
            paramDict["latitude"] = latLon.coordinate.latitude
            paramDict["longitude"] = latLon.coordinate.longitude
        }
        
        paramDict["radius"] = searchRadius
        paramDict["sort_by"] = sortBy
        
        if (includeDeals && includeHotAndNew) {
            paramDict["attributes"] = "deals,hot_and_new"
        }
        else if (includeDeals && !includeHotAndNew) {
            paramDict["attributes"] = "deals"
        }
        else if (!includeDeals && includeHotAndNew) {
            paramDict["attributes"] = "hot_and_new"
        }
        
        if categories.count > 0 {
            var catString = ""
            for (i, cat) in categories.enumerated() {
                catString += cat
                if i < categories.count - 1 {
                    catString += ","
                }
            }
            paramDict["categories"] = catString
        }

        
        return paramDict
    }
    
    func yelpQueryString() -> String {
        
        let paramDict = yelpParamDict()
        
        var resultString = ""
        var idx = 0
        for (key, val) in paramDict {
            
            if (idx == 0) {
                resultString += "?"
            }
            else {
                resultString += "&"
            }
            
            resultString += "\(key)=\(val)"
            idx = idx + 1;
        }
        
        if let qString = resultString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
        
            return qString
        }
        else {
            dlog("bad query string: \(resultString)")
        }
        return ""
    }
    
    public var description: String {
        return "searchByTerm: \(searchTerm), categories: \(categories), sortBy: \(sortBy), location: \(location), radius: \(searchRadius), placemark: \(placemark)"
    }
    
    var debugDescription: String {
        return "searchByTerm: \(searchTerm), categories: \(categories), sortBy: \(sortBy), location: \(location), radius: \(searchRadius), placemark: \(placemark)"
    }
}



//The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
