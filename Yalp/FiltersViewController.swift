//
//  FiltersViewController.swift
//  Yalp
//
//  Created by Bill on 10/13/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {

    var businessFilter: BusinessFilterQueryDTO?

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        dlog("")
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

    @IBAction func cancelPressed(_ sender: AnyObject) {
        dlog("")
        dismiss(animated: true, completion:nil)
        businessFilter?.doSearch = false
    }
    
    //MARK: - Actions
    @IBAction func searchPressed(_ sender: AnyObject) {
        dlog("")
        dismiss(animated: true, completion:nil)
        businessFilter?.doSearch = true
    }
}
