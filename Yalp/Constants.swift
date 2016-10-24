//
//  Constants.swift
//  Yalp
//
//  Created by Bill on 10/6/16.
//  Copyright © 2016 Bill. All rights reserved.
//

import UIKit
import CoreLocation

//MARK: - dlog
func dlog(_ message: String, _ filePath: String = #file, _ functionName: String = #function, _ lineNum: Int = #line)
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

//MARK: - alog
func alog(_ message: String, _ filePath: String = #file, _ functionName: String = #function, _ lineNum: Int = #line)
{
    let url  = URL(fileURLWithPath: filePath)
    let path = url.lastPathComponent
    var fileName = "Unknown"
    if let name = path.characters.split(separator: ",").map(String.init).first {
        fileName = name
    }
    let logString = String(format: "%@.%@[%d]: %@", fileName, functionName, lineNum, message)
    NSLog(logString)
}

var sfLatLon: CLLocation = CLLocation(latitude: 37.785771, longitude: -122.406165) //SF

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

func mergeImagesRatingFive() -> UIImage? {
    
    let fiveImage = UIImage(named: "14x14_5")
    let w = 14
    let h = 14
    let o = 2
    let size = CGSize(width: (w * 5) + (o * 4), height: h)
    UIGraphicsBeginImageContext(size)
    
    var point = CGPoint(x: w * 0, y: 0)
    fiveImage!.draw(at: point)
    point = CGPoint(x: w * 1 + o, y: 0)
    fiveImage!.draw(at: point)
    point = CGPoint(x: w * 2 + 2 * o, y: 0)
    fiveImage!.draw(at: point)
    point = CGPoint(x: w * 3 + 3 * o, y: 0)
    fiveImage!.draw(at: point)
    point = CGPoint(x: w * 4 + 4 * o, y: 0)
    fiveImage!.draw(at: point)
        
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    /*
    if let img = newImage {
        if let data = UIImagePNGRepresentation(img) {
            let filename = getDocumentsDirectory().appendingPathComponent("five.png")
            try? data.write(to: filename)
        }
    }
    */
    return newImage
}

func mergeImagesRatingFourHalf() -> UIImage? {
    
    
    let fourImage = UIImage(named: "14x14_4")
    let halfImage = UIImage(named: "14x14_4-5")
    let w = 14
    let h = 14
    let o = 2
    let size = CGSize(width: (w * 5) + (o * 4), height: h)
    UIGraphicsBeginImageContext(size)
    
    var point = CGPoint(x: w * 0, y: 0)
    fourImage!.draw(at: point)
    point = CGPoint(x: w * 1 + o, y: 0)
    fourImage!.draw(at: point)
    point = CGPoint(x: w * 2 + o * 2, y: 0)
    fourImage!.draw(at: point)
    point = CGPoint(x: w * 3 + o * 3, y: 0)
    fourImage!.draw(at: point)
    point = CGPoint(x: w * 4 + o * 4, y: 0)
    halfImage!.draw(at: point)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    /*
    if let img = newImage {
        if let data = UIImagePNGRepresentation(img) {
            let filename = getDocumentsDirectory().appendingPathComponent("four-five.png")
            try? data.write(to: filename)
        }
    }
    */
    return newImage
}


func mergeImagesRatingFour() -> UIImage? {
    
    
    let fourImage = UIImage(named: "14x14_4")
    let zeroImage = UIImage(named: "14x14_0")
    let w = 14
    let h = 14
    let o = 2
    let size = CGSize(width: (w * 5) + (o * 4), height: h)
    UIGraphicsBeginImageContext(size)
    
    var point = CGPoint(x: w * 0, y: 0)
    fourImage!.draw(at: point)
    point = CGPoint(x: w * 1 + o, y: 0)
    fourImage!.draw(at: point)
    point = CGPoint(x: w * 2 + o * 2, y: 0)
    fourImage!.draw(at: point)
    point = CGPoint(x: w * 3 + o * 3, y: 0)
    fourImage!.draw(at: point)
    point = CGPoint(x: w * 4 + o * 4, y: 0)
    zeroImage!.draw(at: point)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    /*
    if let img = newImage {
        if let data = UIImagePNGRepresentation(img) {
            let filename = getDocumentsDirectory().appendingPathComponent("four.png")
            try? data.write(to: filename)
        }
    }
    */
    return newImage
}


func mergeImagesRatingThreeHalf() -> UIImage? {
    
    
    let threeImage = UIImage(named: "14x14_3")
    let halfImage = UIImage(named: "14x14_3-5")
    let zeroImage = UIImage(named: "14x14_0")
    let w = 14
    let h = 14
    let o = 2
    let size = CGSize(width: (w * 5) + (o * 4), height: h)
    UIGraphicsBeginImageContext(size)
    
    var point = CGPoint(x: w * 0, y: 0)
    threeImage!.draw(at: point)
    point = CGPoint(x: w * 1 + o, y: 0)
    threeImage!.draw(at: point)
    point = CGPoint(x: w * 2 + o * 2, y: 0)
    threeImage!.draw(at: point)
    point = CGPoint(x: w * 3 + o * 3, y: 0)
    halfImage!.draw(at: point)
    point = CGPoint(x: w * 4 + o * 4, y: 0)
    zeroImage!.draw(at: point)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    /*
    if let img = newImage {
        if let data = UIImagePNGRepresentation(img) {
            let filename = getDocumentsDirectory().appendingPathComponent("three-five.png")
            dlog("filename: \(filename)")
            try? data.write(to: filename)
        }
    }
    */
    return newImage
}

func mergeImagesRatingThree() -> UIImage? {
    
    
    let threeImage = UIImage(named: "14x14_3")
    let zeroImage = UIImage(named: "14x14_0")
    let w = 14
    let h = 14
    let o = 2
    let size = CGSize(width: (w * 5) + (o * 4), height: h)
    UIGraphicsBeginImageContext(size)
    
    var point = CGPoint(x: w * 0, y: 0)
    threeImage!.draw(at: point)
    point = CGPoint(x: w * 1 + o, y: 0)
    threeImage!.draw(at: point)
    point = CGPoint(x: w * 2 + o * 2, y: 0)
    threeImage!.draw(at: point)
    point = CGPoint(x: w * 3 + o * 3, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 4 + o * 4, y: 0)
    zeroImage!.draw(at: point)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    /*
    if let img = newImage {
        if let data = UIImagePNGRepresentation(img) {
            let filename = getDocumentsDirectory().appendingPathComponent("three.png")
            dlog("filename: \(filename)")
            try? data.write(to: filename)
        }
    }
    */
    return newImage
}

func mergeImagesRatingTwoHalf() -> UIImage? {
    
    let twoImage = UIImage(named: "14x14_2")
    let halfImage = UIImage(named: "14x14_2-5")
    let zeroImage = UIImage(named: "14x14_0")
    let w = 14
    let h = 14
    let o = 2
    let size = CGSize(width: (w * 5) + (o * 4), height: h)
    UIGraphicsBeginImageContext(size)
    
    var point = CGPoint(x: w * 0, y: 0)
    twoImage!.draw(at: point)
    point = CGPoint(x: w * 1 + o, y: 0)
    twoImage!.draw(at: point)
    point = CGPoint(x: w * 2 + o * 2, y: 0)
    halfImage!.draw(at: point)
    point = CGPoint(x: w * 3 + o * 3, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 4 + o * 4, y: 0)
    zeroImage!.draw(at: point)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    /*
    if let img = newImage {
        if let data = UIImagePNGRepresentation(img) {
            let filename = getDocumentsDirectory().appendingPathComponent("two-five.png")
            dlog("filename: \(filename)")
            try? data.write(to: filename)
        }
    }
    */
    return newImage
}


func mergeImagesRatingTwo() -> UIImage? {
    
    let twoImage = UIImage(named: "14x14_2")
    let zeroImage = UIImage(named: "14x14_0")
    let w = 14
    let h = 14
    let o = 2
    let size = CGSize(width: (w * 5) + (o * 4), height: h)
    UIGraphicsBeginImageContext(size)
    
    var point = CGPoint(x: w * 0, y: 0)
    twoImage!.draw(at: point)
    point = CGPoint(x: w * 1 + o, y: 0)
    twoImage!.draw(at: point)
    point = CGPoint(x: w * 2 + o * 2, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 3 + o * 3, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 4 + o * 4, y: 0)
    zeroImage!.draw(at: point)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    /*
    if let img = newImage {
        if let data = UIImagePNGRepresentation(img) {
            let filename = getDocumentsDirectory().appendingPathComponent("two.png")
            dlog("filename: \(filename)")
            try? data.write(to: filename)
        }
    }
    */
    
    return newImage
}

func mergeImagesRatingOneHalf() -> UIImage? {
    
    let oneImage = UIImage(named: "14x14_1")
    let halfImage = UIImage(named: "14x14_1-5")
    let zeroImage = UIImage(named: "14x14_0")
    let w = 14
    let h = 14
    let o = 2
    let size = CGSize(width: (w * 5) + (o * 4), height: h)
    UIGraphicsBeginImageContext(size)
    
    var point = CGPoint(x: w * 0, y: 0)
    oneImage!.draw(at: point)
    point = CGPoint(x: w * 1 + o, y: 0)
    halfImage!.draw(at: point)
    point = CGPoint(x: w * 2 + o * 2, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 3 + o * 3, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 4 + o * 4, y: 0)
    zeroImage!.draw(at: point)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    /*
    if let img = newImage {
        if let data = UIImagePNGRepresentation(img) {
            let filename = getDocumentsDirectory().appendingPathComponent("one-five.png")
            dlog("filename: \(filename)")
            try? data.write(to: filename)
        }
    }
    */
    
    return newImage
}


func mergeImagesRatingOne() -> UIImage? {
    
    let oneImage = UIImage(named: "14x14_1")
    let zeroImage = UIImage(named: "14x14_0")
    let w = 14
    let h = 14
    let o = 2
    let size = CGSize(width: (w * 5) + (o * 4), height: h)
    UIGraphicsBeginImageContext(size)
    
    var point = CGPoint(x: w * 0, y: 0)
    oneImage!.draw(at: point)
    point = CGPoint(x: w * 1 + o, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 2 + o * 2, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 3 + o * 3, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 4 + o * 4, y: 0)
    zeroImage!.draw(at: point)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    /*
    if let img = newImage {
        if let data = UIImagePNGRepresentation(img) {
            let filename = getDocumentsDirectory().appendingPathComponent("one.png")
            dlog("filename: \(filename)")
            try? data.write(to: filename)
        }
    }
    */
    
    return newImage
}

func mergeImagesRatingZero() -> UIImage? {
    
    let zeroImage = UIImage(named: "14x14_0")
    let w = 14
    let h = 14
    let o = 2
    let size = CGSize(width: (w * 5) + (o * 4), height: h)
    UIGraphicsBeginImageContext(size)
    
    var point = CGPoint(x: w * 0, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 1 + o, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 2 + o * 2, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 3 + o * 3, y: 0)
    zeroImage!.draw(at: point)
    point = CGPoint(x: w * 4 + o * 4, y: 0)
    zeroImage!.draw(at: point)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    /*
    if let img = newImage {
        if let data = UIImagePNGRepresentation(img) {
            let filename = getDocumentsDirectory().appendingPathComponent("zero.png")
            dlog("filename: \(filename)")
            try? data.write(to: filename)
        }
    }
    */
    return newImage
}



let defaultAppearanceKey = "defaultAppearanceKey"


//MARK: - YelpApi

let yelpClientId = "nqpS3O6BlMmugVQrcuPuYA"
let yelpClientSecret = "c8bfR7nWfDUfLL54sPgrORHy5nML3eEvbQdtB8tbtPCfVXPZEwJS0j8jbt1idL7B"

let yelpOauth2Endpoint = "https://api.yelp.com/oauth2/token"
let yelpOauth2PostBody = "grant_type=client_credentials&client_id=\(yelpClientId)&client_secret=\(yelpClientSecret)"

let yelpAuthTokenName = "access_token"
var yelpCurrentAuthToken = ""
var yelpCurrentAuthTokenExpires = 0  //initially 15552000, which is 180 days.

let yelpBusinessSearchEndpoint = "https://api.yelp.com/v3/businesses/search"
var yelpAuthBearerHeaderKey = "Authorization"
var yelpAuthBearerHeaderVal = "Bearer \(yelpCurrentAuthToken)"
let yelpAuthTokenRecievedNotification = "yelpAuthTokenRecievedNotification"


public let yelpFoodCategories: [[String:String]] =
                        [["name" : "Afghan", "code": "afghani"],
                         ["name" : "African", "code": "african"],
                         ["name" : "American, New", "code": "newamerican"],
                         ["name" : "American, Traditional", "code": "tradamerican"],
                         ["name" : "Arabian", "code": "arabian"],
                         ["name" : "Argentine", "code": "argentine"],
                         ["name" : "Armenian", "code": "armenian"],
                         ["name" : "Asian Fusion", "code": "asianfusion"],
                         ["name" : "Asturian", "code": "asturian"],
                         ["name" : "Australian", "code": "australian"],
                         ["name" : "Austrian", "code": "austrian"],
                         ["name" : "Baguettes", "code": "baguettes"],
                         ["name" : "Bangladeshi", "code": "bangladeshi"],
                         ["name" : "Barbeque", "code": "bbq"],
                         ["name" : "Basque", "code": "basque"],
                         ["name" : "Bavarian", "code": "bavarian"],
                         ["name" : "Beer Garden", "code": "beergarden"],
                         ["name" : "Beer Hall", "code": "beerhall"],
                         ["name" : "Beisl", "code": "beisl"],
                         ["name" : "Belgian", "code": "belgian"],
                         ["name" : "Bistros", "code": "bistros"],
                         ["name" : "Black Sea", "code": "blacksea"],
                         ["name" : "Brasseries", "code": "brasseries"],
                         ["name" : "Brazilian", "code": "brazilian"],
                         ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                         ["name" : "British", "code": "british"],
                         ["name" : "Buffets", "code": "buffets"],
                         ["name" : "Bulgarian", "code": "bulgarian"],
                         ["name" : "Burgers", "code": "burgers"],
                         ["name" : "Burmese", "code": "burmese"],
                         ["name" : "Cafes", "code": "cafes"],
                         ["name" : "Cafeteria", "code": "cafeteria"],
                         ["name" : "Cajun/Creole", "code": "cajun"],
                         ["name" : "Cambodian", "code": "cambodian"],
                         ["name" : "Canadian", "code": "New)"],
                         ["name" : "Canteen", "code": "canteen"],
                         ["name" : "Caribbean", "code": "caribbean"],
                         ["name" : "Catalan", "code": "catalan"],
                         ["name" : "Chech", "code": "chech"],
                         ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                         ["name" : "Chicken Shop", "code": "chickenshop"],
                         ["name" : "Chicken Wings", "code": "chicken_wings"],
                         ["name" : "Chilean", "code": "chilean"],
                         ["name" : "Chinese", "code": "chinese"],
                         ["name" : "Comfort Food", "code": "comfortfood"],
                         ["name" : "Corsican", "code": "corsican"],
                         ["name" : "Creperies", "code": "creperies"],
                         ["name" : "Cuban", "code": "cuban"],
                         ["name" : "Curry Sausage", "code": "currysausage"],
                         ["name" : "Cypriot", "code": "cypriot"],
                         ["name" : "Czech", "code": "czech"],
                         ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                         ["name" : "Danish", "code": "danish"],
                         ["name" : "Delis", "code": "delis"],
                         ["name" : "Diners", "code": "diners"],
                         ["name" : "Dumplings", "code": "dumplings"],
                         ["name" : "Eastern European", "code": "eastern_european"],
                         ["name" : "Ethiopian", "code": "ethiopian"],
                         ["name" : "Fast Food", "code": "hotdogs"],
                         ["name" : "Filipino", "code": "filipino"],
                         ["name" : "Fish & Chips", "code": "fishnchips"],
                         ["name" : "Fondue", "code": "fondue"],
                         ["name" : "Food Court", "code": "food_court"],
                         ["name" : "Food Stands", "code": "foodstands"],
                         ["name" : "French", "code": "french"],
                         ["name" : "French Southwest", "code": "sud_ouest"],
                         ["name" : "Galician", "code": "galician"],
                         ["name" : "Gastropubs", "code": "gastropubs"],
                         ["name" : "Georgian", "code": "georgian"],
                         ["name" : "German", "code": "german"],
                         ["name" : "Giblets", "code": "giblets"],
                         ["name" : "Gluten-Free", "code": "gluten_free"],
                         ["name" : "Greek", "code": "greek"],
                         ["name" : "Halal", "code": "halal"],
                         ["name" : "Hawaiian", "code": "hawaiian"],
                         ["name" : "Heuriger", "code": "heuriger"],
                         ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                         ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                         ["name" : "Hot Dogs", "code": "hotdog"],
                         ["name" : "Hot Pot", "code": "hotpot"],
                         ["name" : "Hungarian", "code": "hungarian"],
                         ["name" : "Iberian", "code": "iberian"],
                         ["name" : "Indian", "code": "indpak"],
                         ["name" : "Indonesian", "code": "indonesian"],
                         ["name" : "International", "code": "international"],
                         ["name" : "Irish", "code": "irish"],
                         ["name" : "Island Pub", "code": "island_pub"],
                         ["name" : "Israeli", "code": "israeli"],
                         ["name" : "Italian", "code": "italian"],
                         ["name" : "Japanese", "code": "japanese"],
                         ["name" : "Jewish", "code": "jewish"],
                         ["name" : "Kebab", "code": "kebab"],
                         ["name" : "Korean", "code": "korean"],
                         ["name" : "Kosher", "code": "kosher"],
                         ["name" : "Kurdish", "code": "kurdish"],
                         ["name" : "Laos", "code": "laos"],
                         ["name" : "Laotian", "code": "laotian"],
                         ["name" : "Latin American", "code": "latin"],
                         ["name" : "Live/Raw Food", "code": "raw_food"],
                         ["name" : "Lyonnais", "code": "lyonnais"],
                         ["name" : "Malaysian", "code": "malaysian"],
                         ["name" : "Meatballs", "code": "meatballs"],
                         ["name" : "Mediterranean", "code": "mediterranean"],
                         ["name" : "Mexican", "code": "mexican"],
                         ["name" : "Middle Eastern", "code": "mideastern"],
                         ["name" : "Milk Bars", "code": "milkbars"],
                         ["name" : "Modern Australian", "code": "modern_australian"],
                         ["name" : "Modern European", "code": "modern_european"],
                         ["name" : "Mongolian", "code": "mongolian"],
                         ["name" : "Moroccan", "code": "moroccan"],
                         ["name" : "New Zealand", "code": "newzealand"],
                         ["name" : "Night Food", "code": "nightfood"],
                         ["name" : "Norcinerie", "code": "norcinerie"],
                         ["name" : "Open Sandwiches", "code": "opensandwiches"],
                         ["name" : "Oriental", "code": "oriental"],
                         ["name" : "Pakistani", "code": "pakistani"],
                         ["name" : "Parent Cafes", "code": "eltern_cafes"],
                         ["name" : "Parma", "code": "parma"],
                         ["name" : "Persian/Iranian", "code": "persian"],
                         ["name" : "Peruvian", "code": "peruvian"],
                         ["name" : "Pita", "code": "pita"],
                         ["name" : "Pizza", "code": "pizza"],
                         ["name" : "Polish", "code": "polish"],
                         ["name" : "Portuguese", "code": "portuguese"],
                         ["name" : "Potatoes", "code": "potatoes"],
                         ["name" : "Poutineries", "code": "poutineries"],
                         ["name" : "Pub Food", "code": "pubfood"],
                         ["name" : "Rice", "code": "riceshop"],
                         ["name" : "Romanian", "code": "romanian"],
                         ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                         ["name" : "Rumanian", "code": "rumanian"],
                         ["name" : "Russian", "code": "russian"],
                         ["name" : "Salad", "code": "salad"],
                         ["name" : "Sandwiches", "code": "sandwiches"],
                         ["name" : "Scandinavian", "code": "scandinavian"],
                         ["name" : "Scottish", "code": "scottish"],
                         ["name" : "Seafood", "code": "seafood"],
                         ["name" : "Serbo Croatian", "code": "serbocroatian"],
                         ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                         ["name" : "Singaporean", "code": "singaporean"],
                         ["name" : "Slovakian", "code": "slovakian"],
                         ["name" : "Soul Food", "code": "soulfood"],
                         ["name" : "Soup", "code": "soup"],
                         ["name" : "Southern", "code": "southern"],
                         ["name" : "Spanish", "code": "spanish"],
                         ["name" : "Steakhouses", "code": "steak"],
                         ["name" : "Sushi Bars", "code": "sushi"],
                         ["name" : "Swabian", "code": "swabian"],
                         ["name" : "Swedish", "code": "swedish"],
                         ["name" : "Swiss Food", "code": "swissfood"],
                         ["name" : "Tabernas", "code": "tabernas"],
                         ["name" : "Taiwanese", "code": "taiwanese"],
                         ["name" : "Tapas Bars", "code": "tapas"],
                         ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                         ["name" : "Tex-Mex", "code": "tex-mex"],
                         ["name" : "Thai", "code": "thai"],
                         ["name" : "Traditional Norwegian", "code": "norwegian"],
                         ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                         ["name" : "Trattorie", "code": "trattorie"],
                         ["name" : "Turkish", "code": "turkish"],
                         ["name" : "Ukrainian", "code": "ukrainian"],
                         ["name" : "Uzbek", "code": "uzbek"],
                         ["name" : "Vegan", "code": "vegan"],
                         ["name" : "Vegetarian", "code": "vegetarian"],
                         ["name" : "Venison", "code": "venison"],
                         ["name" : "Vietnamese", "code": "vietnamese"],
                         ["name" : "Wok", "code": "wok"],
                         ["name" : "Wraps", "code": "wraps"],
                         ["name" : "Yugoslav", "code": "yugoslav"]]



func locationFromLocation(loc: CLLocation) -> CLLocation {
    
    var newLoc = CLLocation(coordinate: loc.coordinate, altitude: loc.altitude, horizontalAccuracy: loc.horizontalAccuracy, verticalAccuracy: loc.verticalAccuracy, timestamp: loc.timestamp)
    
    
    return newLoc
    
}
