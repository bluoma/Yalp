//
//  Constants.swift
//  Yalp
//
//  Created by Bill on 10/6/16.
//  Copyright © 2016 Bill. All rights reserved.
//

import Foundation

//MARK: - dlog
public func dlog(_ message: String, _ filePath: String = #file, _ functionName: String = #function, _ lineNum: Int = #line)
{
    #if DEBUG
        
        let url  = URL(fileURLWithPath: filePath)
        let path = url.lastPathComponent
        var fileName = "Unknown"
        if let name = path.characters.split(separator: ",").map(String.init).first {
            fileName = name
        }
        let logString = String(format: "%@.%@[%d]: %@", fileName, functionName, lineNum, message)
        NSLog(logString)
        
    #endif
    
}


public let defaultAppearanceKey = "defaultAppearanceKey"


//MARK: - YelpApi

public let yelpClientId = "nqpS3O6BlMmugVQrcuPuYA"
public let yelpClientSecret = "c8bfR7nWfDUfLL54sPgrORHy5nML3eEvbQdtB8tbtPCfVXPZEwJS0j8jbt1idL7B"

public let yelpOauth2Endpoint = "https://api.yelp.com/oauth2/token"
public let yelpOauth2PostBody = "grant_type=client_credentials&client_id=\(yelpClientId)&client_secret=\(yelpClientSecret)"


public let yelpAuthTokenName = "access_token"
public var yelpCurrentAuthToken = ""

public var yelpCurrentAuthTokenExpires = 0  //initially 15552000, which is 180 days.

public let yelpBusinessSearchEndpoint = "https://api.yelp.com/v3/businesses/search"
public var yelpOathBearerHeaderKey = "Authorization"
public var yelpOathBearerHeaderVal = "Bearer \(yelpCurrentAuthToken)"



 
