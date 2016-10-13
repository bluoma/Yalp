//
//  BusinessListViewController.swift
//  Yalp
//
//  Created by Bill on 10/12/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import UIKit

class BusinessListViewController: UIViewController, JsonDownloaderDelegate {

    var downloader = JsonDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dlog("in")

        downloader.delegate = self
        let urlString = "\(yelpBusinessSearchEndpoint)?term=thai&latitude=37.785771&longitude=-122.406165&radius=30000"
        
        let task: URLSessionDataTask? = downloader.doDownload(urlString: urlString)
        //dlog("task \(task)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
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
                    //dlog("businessDTO: \(businessDto)")

                }
                //businessArray = resultsArray
                dlog("businessDTO count: \(resultsArray.count)")
                

            }
            else {
                dlog("no json")
              
            }
        }
        if let urlString = response.url?.absoluteString {
            dlog("url from response: \(urlString)")
           
        }
    }

    
}
