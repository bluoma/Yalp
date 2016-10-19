//
//  FiltersViewController.swift
//  Yalp
//
//  Created by Bill on 10/13/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import UIKit
import CoreLocation

class FiltersViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var filterTableView: UITableView!
    var businessFilter: BusinessFilterQueryDTO?
    var geoCoder = CLGeocoder()
    var currentPlacemark: CLPlacemark?


    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        dlog("businessFilter: \(businessFilter)")
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let filter = businessFilter {
            filter.sortBy = "distance"
            filter.includeDeals = true
            filter.categories = ["thai", "burmese"]
        }
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
    
    //MARK: - Actions
    @IBAction func cancelPressed(_ sender: AnyObject) {
        dlog("")
        dismiss(animated: true, completion:nil)
        businessFilter?.doSearch = false
    }
    
    @IBAction func searchPressed(_ sender: AnyObject) {
        dlog("")
        dismiss(animated: true, completion:nil)
        businessFilter?.doSearch = true
    }
    
    @IBAction func locationTextChanged(_ sender: AnyObject) {
        //dlog("sender: \(sender)")
    }

    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) { // location text        
        dlog("")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let locationText = textField.text {
        
            geoCoder.geocodeAddressString(locationText, completionHandler: { (placemarks: [CLPlacemark]?, error: Error?) -> Void in
                
                if let place = placemarks?.last {
                    
                    dlog("last place: \(place)")
                    
                }
                
            })
            
            
        }
        /*
        geoCoder.reverseGeocodeLocation(currentLocation!, completionHandler: { (placemarks: [CLPlacemark]?, error: Error?) -> Void in
            if let error = error {
                dlog("reverse geocode err: \(error)")
            }
            else if let placemarks = placemarks {
                for place in placemarks {
                    dlog("placeMark: \(place)")
                }
                if let currentMark = placemarks.last {
                    if currentMark != self.currentPlacemark {
                        self.currentPlacemark = currentMark
                    }
                }
            }
            else {
                dlog("both error and placemarks are nil ?")
            }
        })
        */
        dlog("")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44.0
    }
    
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationFilterCell") as! LocationFilterTableViewCell
        
        
        
        return cell
    }


}
