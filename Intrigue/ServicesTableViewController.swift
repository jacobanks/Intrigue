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

class ServicesTableViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    var array: [NSString] = []
    var descriptionArray: [NSString] = []
    var iconURL: NSString?
    var serviceList = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Services"
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        // A little trick for removing the cell separators
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        let token: NSString = NSUserDefaults.standardUserDefaults().stringForKey("authToken")!
        let url: NSString = "/chats?token=\(token)"
        
        RequestHandler().sendRequest(url, data: nil, postOrGet: false, completionHandler: { err, data in
            let serviceListResult: NSArray = data as! NSArray
            
            self.serviceList = serviceListResult
            self.tableView.reloadData()
        })
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Start chatting to a service!"
        let attributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(18.0), NSForegroundColorAttributeName: UIColor.darkGrayColor()]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "It looks like you haven't been talking to anyone. Don't stay lonely, start a conversation!"
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = NSLineBreakMode.ByWordWrapping
        paragraph.alignment = NSTextAlignment.Center
        
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(14.0), NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSParagraphStyleAttributeName: paragraph]
        
        return NSAttributedString(string: text, attributes: attributes)
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
        return serviceList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:customTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as! customTableViewCell
        // Configure the cell...
        
        let serviceID = serviceList[indexPath.row]["service_id"] as! Int
        let url: NSString = "/service?service_id=\(serviceID)"
        
        RequestHandler().sendRequest(url, data: nil, postOrGet: false, completionHandler: { err, data in
            var serviceInfoResult: NSDictionary = data as! NSDictionary
            
            cell.titleLabel?.text = serviceInfoResult["name"] as? String
            cell.descriptionLabel?.text = serviceInfoResult["description"] as? String
            
            if let url = NSURL(string: (serviceInfoResult["icon_url"] as? String)!) {
                if let data = NSData(contentsOfURL: url){
                    cell.serviceImage.layer.cornerRadius = 10
                    cell.serviceImage.clipsToBounds = true
                    cell.serviceImage.image = UIImage(data: data)
                }
            }
        })
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = MessagesViewController()
        vc.serviceID = serviceList[indexPath.row]["service_id"] as! Int
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}
