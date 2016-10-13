//
//  BusinessListViewController.swift
//  Yalp
//
//  Created by Bill on 10/12/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import UIKit
import CoreLocation

class BusinessListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, JsonDownloaderDelegate {
    
    @IBOutlet weak var businessTableView: UITableView!

    var downloader = JsonDownloader()
    var businessArray: [BusinessSummaryDTO] = [] {
        
        didSet {
            dlog("didSet array")
            
            for business in businessArray {
                
                let loc = CLLocation(latitude: business.latitude, longitude: business.longitude)
                if (currentLocation != nil) {
                    let distance = loc.distance(from: currentLocation!)
                    dlog("distance: \(distance) m for address: \(business.fullAddress)")
                }
                else {
                    dlog("currentLocation is unknown")
                }
            }
        }
    }
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        dlog("in")
        //37.87159, -122.27275 berkeley
        locationManager.distanceFilter = 100
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let notificationCenter = NotificationCenter.default
        let notifName = NSNotification.Name.init(rawValue: yelpAuthTokenRecievedNotification)
        notificationCenter.addObserver(self, selector: #selector(BusinessListViewController.authTokenReceived(notification:)), name: notifName, object: nil)

        downloader.delegate = self
        
        dlog("out")
        
        

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
        let urlString = "\(yelpBusinessSearchEndpoint)?term=thai&latitude=37.785771&longitude=-122.406165&radius=30000"
        
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
                businessTableView.reloadData()

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
        cell.distanceLabel.text = businessSummary.distance
        cell.dollarLabel.text = businessSummary.price
        
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
        
        let currentLoc = locations.last
        currentLocation = currentLoc
    }

}
