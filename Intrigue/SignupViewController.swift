//
//  SignupViewController.swift
//  
//
//  Created by Jacob Banks on 9/12/15.
//
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField?
    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createUser(sender: AnyObject) {
        let urlPath: String = "/auth/register"
        let stringPost = "email=\(emailTextField!.text)&password=\(passwordTextField!.text)"
        
        RequestHandler().sendRequest(urlPath, data: stringPost, postOrGet: true, completionHandler: { err, data in
            if(!err) {
                let urlPath2: String = "/auth/token"
                
                RequestHandler().sendRequest(urlPath2, data: stringPost, postOrGet: false, completionHandler: { err, data in
                    var jsonResult: NSDictionary = data as! NSDictionary
                    
                    var success: AnyObject? = jsonResult.objectForKey("success")
                    if (err) {
                        var alert = UIAlertController(title: "Alert", message: "Your email or password is incorrect!", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    } else {
                        NSUserDefaults.standardUserDefaults().setValue(jsonResult.objectForKey("token") as! String, forKey: "authToken")
                        dispatch_async(dispatch_get_main_queue()) {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewControllerWithIdentifier("serviceTable") as! UIViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                })
            }
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
