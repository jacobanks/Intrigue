//
//  loginViewController.swift
//  Intrigue
//
//  Created by Jacob Banks on 9/12/15.
//  Copyright (c) 2015 Jacob Banks. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?

    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Just some UI stuff
        
        self.signInButton.backgroundColor = UIColor.clearColor()
        self.signInButton.layer.cornerRadius = 5
        self.signInButton.layer.borderWidth = 1
        self.signInButton.layer.borderColor = UIColor.whiteColor().CGColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        let urlPath: String = "https://mhacks.on-aptible.com/api/auth/token"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        var stringPost = "email=\(emailTextField!.text)&password=\(passwordTextField!.text)"

        let data = stringPost.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.timeoutInterval = 60
        request.HTTPBody = data
        request.HTTPShouldHandleCookies = false
        
        let queue: NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError?
//            println(NSString(data: data, encoding: NSUTF8StringEncoding))

            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSDictionary
            
            var success: AnyObject? = jsonResult.objectForKey("success")
            if (err != nil || success?.stringValue == "0") {
                
                var alert = UIAlertController(title: "Alert", message: "Your email or password is incorrect!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            println("AsSynchronous\(jsonResult)")
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
