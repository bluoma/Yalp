//
//  BusinessListViewController.swift
//  Yalp
//
//  Created by Bill on 10/12/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import UIKit
import CoreLocation
import AFNetworking

class BusinessListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, JsonDownloaderDelegate {
    
    @IBOutlet weak var businessTableView: UITableView!

    var downloader = JsonDownloader()
    var businessArray: [BusinessSummaryDTO] = [] {
        
        didSet {
            dlog("didSet array")
            
            updateLocations()
        }
    }
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        dlog("in")
        
        locationManager.distanceFilter = 100 //meters
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let notificationCenter = NotificationCenter.default
        let notifName = NSNotification.Name(yelpAuthTokenRecievedNotification)
        notificationCenter.addObserver(self, selector: #selector(BusinessListViewController.authTokenReceived(notification:)), name: notifName, object: nil)

        downloader.delegate = self
        
        dlog("out")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let locAuthStatus = CLLocationManager.authorizationStatus()
        
        if locAuthStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let locAuthStatus = CLLocationManager.authorizationStatus()
        
        if locAuthStatus == .authorizedWhenInUse {
            locationManager.stopUpdatingLocation()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        dlog("segue: \(segue.identifier)")
    }
    

    
    func authTokenReceived(notification: NSNotification) {
        dlog("got auth token, let's download: \(notification)")
        doDownload()

    }
    
    func doDownload() {
        let urlString = "\(yelpBusinessSearchEndpoint)?term=thai&location=San%20Francisco&radius=30000&limit=50&sort_by=distance"
        
        let task: URLSessionDataTask? = downloader.doDownload(urlString: urlString)
        dlog("out task \(task)")
    }
    
    func jsonDownloaderDidFinish(downloader: JsonDownloader, json: [String:AnyObject]?, response: HTTPURLResponse, error: NSError?)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        if error != nil {
            dlog("err: \(error)")
           
        }
        else {
            
            if let jsonObj: [String:AnyObject]  = json,
                let results: [AnyObject] = jsonObj["businesses"] as? [AnyObject] {
                dlog("got json")

                var resultsArray: [BusinessSummaryDTO] = []
                
                for businessObj in results {
                    let businessDict = businessObj as! NSDictionary
                    let businessDto = BusinessSummaryDTO(jsonDict: businessDict)
                    resultsArray.append(businessDto)
                    dlog("businessDTO: \(businessDto)")

                }
                businessArray = resultsArray
                dlog("businessDTO count: \(resultsArray.count)")
                //table view is refreshed by property observer on businessArray
            }
            else {
                dlog("no json")
              
            }
        }
        if let urlString = response.url?.absoluteString {
            dlog("url from response: \(urlString)")
           
        }
    }

    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 88.0
    }
    
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return businessArray.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell") as! BusinessTableViewCell
        
        let businessSummary = businessArray[indexPath.row]
        
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
                                                  success: { (request: URLRequest, response:HTTPURLResponse?, image: UIImage) -> Void in
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
                                                    dlog("image fetch failed: \(error) for indexPath: \(indexPath)")
                                                    cell.businessImageView.image = nil})

        }
        else {
            dlog("no imageurl: \(businessSummary.name)")
            cell.businessImageView.image = nil
        }

        
        return cell
    }
    
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        dlog("status: \(status.rawValue)")
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dlog("error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        dlog("locations: \(locations)")
        
        if let currentLoc = locations.last {
            currentLocation = currentLoc
            updateLocations()
        }
        dlog("hopefully this is the main thread: \(Thread.current)")
    }

    
    func updateLocations() {
        
        for business in businessArray {
            
            let loc = CLLocation(latitude: business.latitude, longitude: business.longitude)
            if (currentLocation != nil) {
                let distance = loc.distance(from: currentLocation!)
                dlog("distance: \(distance) m for address: \(business.fullAddress)")
                business.distance = Int(distance)
            }
            else {
                dlog("currentLocation is unknown")
            }
        }
        businessTableView.reloadData()
    }
}
