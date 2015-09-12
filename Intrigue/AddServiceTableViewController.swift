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

class AddServiceTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.title = "Add a Service"
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
        return 2
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:customCell = self.tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as! customCell
        // Configure the cell...
        var url1: NSURL = NSURL(string: "https://mhacks.on-aptible.com/api/services")!
        var request1: NSMutableURLRequest = NSMutableURLRequest(URL: url1)
        
        NSURLConnection.sendAsynchronousRequest(request1, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
//            println(NSString(data: data, encoding: NSUTF8StringEncoding)!)
            var serviceInfoResult: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSArray
            
            let titleString = serviceInfoResult[indexPath.row]["name"]
            let descriptionString = serviceInfoResult[indexPath.row]["description"]
            let icon_url = serviceInfoResult[indexPath.row]["icon_url"] as! String

            cell.titleLabel.text = titleString as? String
            cell.descriptionLabel.text = descriptionString as? String

            if let url = NSURL(string: icon_url) {
                if let data = NSData(contentsOfURL: url){
                    cell.serviceImage.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.navigationController?.popViewControllerAnimated(true)
        let vc = MessagesViewController()
        self.presentViewController(vc, animated: true, completion: nil)

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
