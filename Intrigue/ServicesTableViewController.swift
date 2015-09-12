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

    var array: [NSString] = []
    var descriptionArray: [NSString] = []
    var iconURL: NSString?
    
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

        if let url = NSURL(string: "\(iconURL!)") {
            if let data = NSData(contentsOfURL: url){
                cell.serviceImage.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = MessagesViewController()
        self.presentViewController(vc, animated: true, completion: nil)
//        let vc = messagesTVC()
//        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func addService(sender: AnyObject) {
    
        let urlPath: String = "https://mhacks.on-aptible.com/api/chat"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        var stringPost = "token=WMNER5gyaCYVZkDghy1DwovaETRo2rZY&service_id=1"
        
        let data = stringPost.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.timeoutInterval = 60
        request.HTTPBody = data
        request.HTTPShouldHandleCookies = false
        
        let queue: NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
            
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            println("\(jsonResult)")
        })

        
        //https://mhacks.on-aptible.com/api/service?service_id=1
        
        var url1: NSURL = NSURL(string: "https://mhacks.on-aptible.com/api/service?service_id=1")!
        var request1: NSMutableURLRequest = NSMutableURLRequest(URL: url1)
        
        NSURLConnection.sendAsynchronousRequest(request1, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding)!)
            var serviceInfoResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            var nameString = serviceInfoResult["name"] as! String
            var descriptionString = serviceInfoResult["description"] as! String
            var icon_url = serviceInfoResult["icon_url"] as! String

            self.array.append(nameString)
            self.descriptionArray.append(descriptionString)
            self.iconURL = icon_url
            self.tableView.reloadData()

        }
    }
    
}
