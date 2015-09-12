//
//  servicesTVC.swift
//  Intrigue
//
//  Created by Jacob Banks on 9/12/15.
//  Copyright (c) 2015 Jacob Banks. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var serviceImage: UIImageView!

}

class ServicesTableViewController: UITableViewController {

    var array: NSArray = ["Uber", "Something"]
    var descriptionArray: NSArray = ["hello", "Hi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Services"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return array.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:customTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as! customTableViewCell
        // Configure the cell...
        cell.titleLabel?.text = array[indexPath.row] as? String
        cell.descriptionLabel?.text = descriptionArray[indexPath.row] as? String

        cell.serviceImage.image = UIImage(named: "uber.png")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let vc = messagesTVC()
//        self.presentViewController(vc, animated: true, completion: nil)
    }
}
