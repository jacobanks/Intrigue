//
//  AddServiceTableViewController.swift
//  
//
//  Created by Jacob Banks on 9/12/15.
//
//

import UIKit

class customCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var serviceImage: UIImageView!
    
}

var serviceList = []
var chatList = []

class AddServiceTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var url1: NSURL = NSURL(string: "https://mhacks.on-aptible.com/api/services")!
        var request1: NSMutableURLRequest = NSMutableURLRequest(URL: url1)
        
        NSURLConnection.sendAsynchronousRequest(request1, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            var serviceInfoResult: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSArray
            
            serviceList = serviceInfoResult
            
            let token: NSString = NSUserDefaults.standardUserDefaults().stringForKey("authToken")!
            var url2: NSURL = NSURL(string: "https://mhacks.on-aptible.com/api/chats?token=\(token)")!
            var request2: NSMutableURLRequest = NSMutableURLRequest(URL: url2)
            
            NSURLConnection.sendAsynchronousRequest(request1, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
                var chatListResult: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSArray
                
                chatList = chatListResult
                self.tableView.reloadData()
            }
        }
        
        self.title = "Add a Service"
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return serviceList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:customCell = self.tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as! customCell
        // Configure the cell...
        let titleString = serviceList[indexPath.row]["name"]
        let descriptionString = serviceList[indexPath.row]["description"]
        let icon_url = serviceList[indexPath.row]["icon_url"] as! String
        
        cell.titleLabel.text = titleString as? String
        cell.descriptionLabel.text = descriptionString as? String
        
        if let url = NSURL(string: icon_url) {
            if let data = NSData(contentsOfURL: url){
                cell.serviceImage.layer.cornerRadius = 10
                cell.serviceImage.clipsToBounds = true
                cell.serviceImage.image = UIImage(data: data)
            }
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.popViewControllerAnimated(true)
        
        let vc = MessagesViewController()
        vc.serviceID = serviceList[indexPath.row]["id"] as! Int
        self.navigationController?.pushViewController(vc, animated: true)
        
//        var amountOfDupes = 0;
//        for obj in chatList {
//            if((serviceList[indexPath.row]["id"] as! Int) == (obj["id"] as! Int)) {
//                amountOfDupes++;
//                if(amountOfDupes > 1) {
//                    return;
//                }
//            }
//        }
        
        //Create a Chat
        let urlPath: String = "https://mhacks.on-aptible.com/api/chat"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        let token: NSString = NSUserDefaults.standardUserDefaults().stringForKey("authToken")!
        var stringPost = "token=\(token)&service_id=\(vc.serviceID)"
        
        let data = stringPost.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.timeoutInterval = 60
        request.HTTPBody = data
        request.HTTPShouldHandleCookies = false
        
        let queue: NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
            
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
