//
//  FiltersViewController.swift
//  Yalp
//
//  Created by Bill on 10/13/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import UIKit
import CoreLocation

class FiltersViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, SwitchCellChangedDelegate {

    
    @IBOutlet weak var filterTableView: UITableView!
    var businessFilter: BusinessFilterQueryDTO?
    var geoCoder = CLGeocoder()
    //var currentPlacemark: CLPlacemark?
    
    var useCurrentLocationOn = true
    var dealsOn = false
    var newOn = false
    var distanceSectionExpanded = false
    var distanceSelectionIdx = 0
    var sortSectionExpanded = false
    var sortSelectionIdx = 0
    var categorySectionExpanded = false
    var yelpCategorySelections: [Bool] = Array(repeating: false, count:yelpFoodCategories.count)

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if let businessFilter = businessFilter {
            useCurrentLocationOn = businessFilter.useCustomLocationString
        }
       
        
        dlog("businessFilter: \(businessFilter)")
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
        updateFilterQuery()
        dismiss(animated: true, completion:nil)
    }
    
    private func updateFilterQuery() -> Void {
        if dealsOn {
            businessFilter?.includeDeals = true
        }
        if newOn {
            businessFilter?.includeHotAndNew = true
        }
        
        //Any, 0.3 miles, 1 mile, 5 miles, 20 miles
        switch distanceSelectionIdx {
            
        case 0:
            businessFilter?.searchRadius = 40000
            
        case 1:
            businessFilter?.searchRadius = 483
            
        case 2:
            businessFilter?.searchRadius = 1609
            
        case 3:
            businessFilter?.searchRadius = 8047
            
        case 4:
            businessFilter?.searchRadius = 32187
            
        default:
            businessFilter?.searchRadius = 40000
        }
        
        
        //best_match, rating, review_count or distance
        switch sortSelectionIdx {
            
        case 0:
            businessFilter?.sortBy = "best_match"
            
        case 1:
            businessFilter?.sortBy = "rating"
            
        case 2:
            businessFilter?.sortBy = "review_count"
            
        case 3:
            businessFilter?.sortBy = "distance"
            
            
        default:
            businessFilter?.sortBy = "best_match"
        }
        
        businessFilter?.categories.removeAll()
        for (i, boolVal) in yelpCategorySelections.enumerated() {
            if boolVal {
                if let catCode = yelpFoodCategories[i]["code"] {
                    businessFilter?.categories.append(catCode)
                }
            }
        }
        
        dlog("qString: \(businessFilter?.yelpQueryString())")
        
        businessFilter?.doSearch = true
    }
    
    @IBAction func locationTextChanged(_ sender: AnyObject) {
        //dlog("sender: \(sender)")
        let textField = sender as! UITextField
        if let locationText = textField.text {
            if locationText.characters.count == 0 {
                self.businessFilter?.useCustomLocationString = false
                dlog("loctext empty")
            }
        }
        else {
            self.businessFilter?.useCustomLocationString = false
            dlog("loctext empty")
        }
    }

    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) { // location text        
        dlog("")
        textField.textColor = UIColor.black
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let locationText = textField.text,
            locationText.characters.count > 0 {
            dlog("forward geocoding loctext: \(locationText)")
            forwardGeocode(textField: textField, locationText: locationText)
        }
        else {
            dlog("loctext empty")
            self.businessFilter?.useCustomLocationString = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.businessFilter?.useCustomLocationString = false
        textField.textColor = UIColor.black
        return true
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        dlog("indexPath: \(indexPath)")
        
        if indexPath.section == 2 {
            if distanceSectionExpanded {
                distanceSelectionIdx = indexPath.row
            }
            distanceSectionExpanded = !distanceSectionExpanded
            tableView.reloadSections(IndexSet(integer:2), with: UITableViewRowAnimation.fade)
        }
        else if indexPath.section == 3 {
            if sortSectionExpanded {
                sortSelectionIdx = indexPath.row
            }
            sortSectionExpanded = !sortSectionExpanded
            tableView.reloadSections(IndexSet(integer:3), with: UITableViewRowAnimation.fade)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44.0
    }
    
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            
        case 0:
            if useCurrentLocationOn {
                return 1
            }
            else {
                return 2 //Location current switch / free form text entry
            }
        case 1:
            return 2 //Deals, Hot and New

        case 2:
            if distanceSectionExpanded {
                return 5 //Any, 0.3 miles, 1 mile, 5 miles, 20 miles
            }
            else {
                return 1
            }
            
        case 3:
            if sortSectionExpanded {
                return 4 //best_match, rating, review_count or distance
            }
            else {
                return 1
            }
        
        case 4:
            if categorySectionExpanded {
                return yelpFoodCategories.count //list of categories
            }
            else {
                return 3
            }
        default:
            dlog("unexpected section: \(section)")
            return 0
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 4) {
            return 28.0
        }
        return 0.0
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        var header: UITableViewHeaderFooterView? = nil
        
        switch section {
        
        case 0:
            header = UITableViewHeaderFooterView()
            header!.textLabel?.text = "Location"
            
        case 1:
            header = UITableViewHeaderFooterView()
            header!.textLabel?.text = "Cool"
    
        case 2:
            header = UITableViewHeaderFooterView()
            header!.textLabel?.text = "Distance"

        case 3:
            header = UITableViewHeaderFooterView()
            header!.textLabel?.text = "Sort By"

        case 4:
            header = UITableViewHeaderFooterView()
            header!.textLabel?.text = "Category"
            
        default:
            header = nil

        }
        //dlog("returning header: \(header) for section: \(section))")
        return header;
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        //header.textLabel?.frame.origin.x = 4
        //header.textLabel?.frame.size.width -= 8
        header.contentView.backgroundColor = UIColor(red: 204/255, green: 47/255, blue: 40/255, alpha: 0.80) //make the background color red
        header.textLabel?.textColor = UIColor.white //make the text white
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        var footer: UITableViewHeaderFooterView? = nil
        
        if section == 4 {
            footer = UITableViewHeaderFooterView()
            let grec = UITapGestureRecognizer(target: self, action: #selector(FiltersViewController.footerViewPressed))
            grec.numberOfTapsRequired = 1
            grec.numberOfTouchesRequired = 1
            footer?.addGestureRecognizer(grec)
            if categorySectionExpanded {
                footer?.textLabel?.text = "See Less"
            }
            else {
                footer?.textLabel?.text = "See All"
            }
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if section == 4 {
            let footer = view as! UITableViewHeaderFooterView
            footer.textLabel?.textAlignment = .center
            footer.textLabel?.textColor = UIColor.cyan
            footer.contentView.backgroundColor = UIColor(white: 0.5, alpha: 1.0)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = nil
        
        if indexPath.section == 0 {
            cell = handleLocationEntrySection(tableView: tableView, indexPath: indexPath)
        }
        else if indexPath.section == 1 {
            cell = handleSwitchSection(tableView: tableView, indexPath: indexPath)
        }
        else if indexPath.section == 2 {
            cell = handleSimpleLabelSection(tableView: tableView, indexPath: indexPath)
        }
        else if indexPath.section == 3 {
            cell = handleSimpleLabelSection(tableView: tableView, indexPath: indexPath)
        }
        else if indexPath.section == 4 {
            cell = handleSwitchSection(tableView: tableView, indexPath: indexPath)
        }
        else {
            dlog("unexpected indexPath: \(indexPath), crash")
        }
        return cell!
    }


    func handleLocationEntrySection(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.row == 0 {
            return handleLocationSwitch(tableView: tableView, indexPath: indexPath)
        }
        else {
            return handleLocationText(tableView: tableView, indexPath: indexPath)
        }
        
    }
    
    func handleLocationText(tableView: UITableView, indexPath: IndexPath) -> LocationFilterTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationFilterCell") as! LocationFilterTableViewCell
        cell.locationTextField.textColor = UIColor.black
        
        if let place = businessFilter?.placemark {
            if let city = place.locality,
                let state = place.administrativeArea {
                let switchLabelText = "\(city), \(state)"
                cell.locationTextField.placeholder = switchLabelText
            }
        }
        return cell
    }
    
    func handleLocationSwitch(tableView: UITableView, indexPath: IndexPath) -> SwitchFilterTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchFilterCell") as! SwitchFilterTableViewCell
        cell.changedDelegate = self
        cell.sortSwitchLabel.isEnabled = true
        var switchLabelText = "Search from "
        if let place = businessFilter?.placemark {
            if let city = place.locality,
                let state = place.administrativeArea {
                switchLabelText += "\(city), \(state)"
            }
        }
        else {
            switchLabelText += "Current Location"
        }
        cell.sortSwitchLabel.text = switchLabelText
        if useCurrentLocationOn {
            cell.sortSwitchLabel.isEnabled = true
        }
        else {
            cell.sortSwitchLabel.isEnabled = false
        }
        cell.sortSwitch.isOn = useCurrentLocationOn
       
        return cell
    }


    
    func handleSwitchSection(tableView: UITableView, indexPath: IndexPath) -> SwitchFilterTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchFilterCell") as! SwitchFilterTableViewCell
        cell.changedDelegate = self
        cell.sortSwitchLabel.isEnabled = true
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.sortSwitchLabel.text = "Offering Deals"
                cell.sortSwitch.isOn = dealsOn
            }
            else if indexPath.row == 1 {
                cell.sortSwitchLabel.text = "Hot and New"
                cell.sortSwitch.isOn = newOn
            }
        }
        else {
            
            let cat: [String:String] = yelpFoodCategories[indexPath.row]
            cell.sortSwitchLabel.text = cat["name"]
            cell.sortSwitch.isOn = self.yelpCategorySelections[indexPath.row]
        }
        
        
        return cell
    }
    
    func handleSimpleLabelSection(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 2:
            return handleDistanceFilterSection(tableView: tableView, indexPath: indexPath)
            
        case 3:
            return handleSortFilterSection(tableView: tableView, indexPath: indexPath)

        default:
            dlog("unexpected section: \(indexPath.section)")
            return handleSortFilterSection(tableView: tableView, indexPath: indexPath)
        }
        
    }

    func handleDistanceFilterSection(tableView: UITableView, indexPath: IndexPath) -> SortFilterTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortFilterCell")as! SortFilterTableViewCell
        
        if !distanceSectionExpanded {
            
            dlog("distance is contracted for indexPath: \(indexPath), selectedIdx: \(distanceSelectionIdx)")
            
            //there's only one row and it's selected and collapsed, use grey dropdown
            cell.sortIconImageView.image = UIImage(named: "arrow_drop_down_grey")
            
            switch distanceSelectionIdx {
                
            case 0:
                cell.sortLabel?.text = "Any"
               
            case 1:
                cell.sortLabel?.text = "0.3 miles"
                
            case 2:
                cell.sortLabel?.text = "1 mile"

            case 3:
                cell.sortLabel?.text = "5 miles"
                
            case 4:
                cell.sortLabel?.text = "25 miles"
            
            default:
                dlog("unexpected row: \(indexPath)")
                cell.sortLabel?.text = "Any"
            }
        }
        else {
            
            dlog("distance is contracted for indexPath: \(indexPath), selectedIdx: \(distanceSelectionIdx)")

            if distanceSelectionIdx == indexPath.row {
                cell.sortIconImageView.image = UIImage(named: "blue-circle-check")
            }
            else {
                cell.sortIconImageView.image = UIImage(named: "grey-circle-uncheck")
            }

            switch indexPath.row {
                
            case 0:
                cell.sortLabel?.text = "Any"
                
            case 1:
                cell.sortLabel?.text = "0.3 miles"
                
            case 2:
                cell.sortLabel?.text = "1 mile"
            
            case 3:
                cell.sortLabel?.text = "5 miles"
                
            case 4:
                cell.sortLabel?.text = "25 miles"
            
            default:
                dlog("unexpected row: \(indexPath)")
                cell.sortLabel?.text = "Any"
            }
        }
        return cell
    }
    
    func handleSortFilterSection(tableView: UITableView, indexPath: IndexPath) -> SortFilterTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortFilterCell")as! SortFilterTableViewCell
        
        if !sortSectionExpanded {
            dlog("sort is contracted for indexPath: \(indexPath), selectedIdx: \(distanceSelectionIdx)")
            
            //there's only one row and it's selected and collapsed, use grey dropdown
            cell.sortIconImageView.image = UIImage(named: "arrow_drop_down_grey")
            
            switch sortSelectionIdx {
                
            case 0:
                cell.sortLabel?.text = "Best Match"
                
            case 1:
                cell.sortLabel?.text = "Ratings"
                
            case 2:
                cell.sortLabel?.text = "Reviews"
                
            case 3:
                cell.sortLabel?.text = "Distance"
                
            default:
                dlog("unexpected row: \(indexPath)")
                cell.sortLabel?.text = "Best Match"
            }
        }
        else {
            
            if sortSelectionIdx == indexPath.row {
                cell.sortIconImageView.image = UIImage(named: "blue-circle-check")
            }
            else {
                cell.sortIconImageView.image = UIImage(named: "grey-circle-uncheck")
            }
            
            switch indexPath.row {
                
            case 0:
                cell.sortLabel?.text = "Best Match"
                
            case 1:
                cell.sortLabel?.text = "Ratings"
                
            case 2:
                cell.sortLabel?.text = "Reviews"
                
            case 3:
                cell.sortLabel?.text = "Distance"
                
            default:
                dlog("unexpected row: \(indexPath)")
                cell.sortLabel?.text = "Best Match"
                
            }
        }
        return cell
    }
    
    func switchCell(switchCell: SwitchFilterTableViewCell, didChangeValue value: Bool) -> Void {
        
        if let indexPath = filterTableView.indexPath(for: switchCell) {
        
            if indexPath.section == 0 {
                useCurrentLocationOn = value
                dlog("loc useCurrent: \(value)")
                filterTableView.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.fade)
            }
            else if indexPath.section == 1 {
                if indexPath.row == 0 {
                    dealsOn = value
                }
                else if indexPath.row == 1 {
                    newOn = value
                }
            }
            else if indexPath.section == 4 {
                yelpCategorySelections[indexPath.row] = value
            }
        }
    }
    
    func footerViewPressed() -> Void {
        
        dlog("categoriesExpanded: \(categorySectionExpanded)")
        categorySectionExpanded = !categorySectionExpanded
        filterTableView.reloadSections(IndexSet(integer: 4), with: UITableViewRowAnimation.fade)

    }
    
    //MARK: - CoreLocation
    
    func forwardGeocode(textField: UITextField, locationText: String) -> Void {
        
        geoCoder.geocodeAddressString(locationText, completionHandler: { (placemarks: [CLPlacemark]?, error: Error?) -> Void in
            
            if let place = placemarks?.last {
                
                dlog("last place: \(place)")
                
                dlog("name: \(place.name)")
                dlog("administrativeArea: \(place.administrativeArea)")
                dlog("subAdministrativeArea: \(place.subAdministrativeArea)")
                dlog("locality: \(place.locality)")
                dlog("subLocality: \(place.subLocality)")
                dlog("postalCode: \(place.postalCode)")

                dlog("placeCoord: \(place.location)")
                
                self.businessFilter?.placemark = place
                self.businessFilter?.useCustomLocationString = true
                
                textField.textColor = UIColor.black
                if let city = place.locality,
                    let state = place.administrativeArea {
                    let cityStateText = "\(city), \(state)"
                    textField.placeholder = cityStateText
                    textField.text = cityStateText
                }

        
            }
            else if error != nil {
                dlog("geocode error for: \(locationText), err: \(error)")
                self.businessFilter?.useCustomLocationString = false
                textField.textColor = UIColor.red
            }
        })

        
    }
    
}
