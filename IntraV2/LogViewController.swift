//
//  ViewController.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 17/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import UIKit
import CoreData

struct CookieState {
    static var CookieManager = Cookie()
}

class LogViewController: UIViewController {
    
    @IBOutlet var connectButton: UIButton!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var stateLabel: UILabel!
    
    var activityIndicator = UIActivityIndicatorView()
    var appDel : AppDelegate!
    var context : NSManagedObjectContext!
    var CookieManager : Cookie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        CookieManager = CookieState.CookieManager
        appDel = (UIApplication.sharedApplication().delegate as AppDelegate)
        context = appDel!.managedObjectContext
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
        
       
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.activityIndicator.frame = CGRectMake(0, 0, 40.0, 40.0);
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.activityIndicator.hidden = true
        
        self.view.addSubview(self.activityIndicator)
        
        var backGround = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backGround.image = UIImage(named: "background.png")
        self.view.sendSubviewToBack(backGround)
        
        var request = NSFetchRequest(entityName:"ID")
        var result: NSArray = context.executeFetchRequest(request, error:nil) as [ID]
        if (result.count > 0) {
            loginTextField.text = result[result.count  - 1].valueForKey("log") as String
            passTextField.text = result[result.count  - 1].valueForKey("pass") as String
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "FailedToLogin:", name: "FailedLogin", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "SuccesToLogin:", name: "SuccessLogin", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "UpdateState:", name: "Update", object: nil)
    }
    
    ///Hide keyboard when click somewhere out the keyboard
    ///:return: true to hide it
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    ///try to get user informartion after click on button
    @IBAction func pressed(sender :AnyObject) {
        if (!loginTextField.text.isEmpty && !passTextField.text.isEmpty)
        {
            activityIndicator.startAnimating()
            self.activityIndicator.hidden = false
            CookieManager?.logIn(loginTextField.text, pass: passTextField.text)
        }
    }
    
    ///while received a NSNotification, display logError()
    func FailedToLogin(notification: NSNotification) {
        self.activityIndicator.stopAnimating()
        self.stateLabel.text = ""
        self.logError()
    }
    
    func UpdateState(notification: NSNotification) {
        if let info = notification.userInfo as? Dictionary<String,String> {
            stateLabel.text = info["message"]
        }
    }
    ///delete old value in coreData, replace them by the new one
    ///perform segue to other view
    func SuccesToLogin(notification: NSNotification) {
        self.activityIndicator.stopAnimating()
        self.stateLabel.text = ""
        delOldData()
        var newID = NSEntityDescription.insertNewObjectForEntityForName("ID", inManagedObjectContext: self.context!) as NSManagedObject
        newID.setValue(passTextField.text, forKey:"pass")
        newID.setValue(loginTextField.text, forKey:"log")
        context.save(nil)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        performSegueWithIdentifier("Log", sender: nil)
    }
    
    ///get ID entity, delete all data
    func delOldData()->Void {
        var request = NSFetchRequest(entityName:"ID")
        var result: NSArray = context.executeFetchRequest(request, error:nil) as [ID]
        for res in result {
            context.deleteObject(res as NSManagedObject)
        }
    }
    
    ///display alert when log or pass are false
    func logError() {
        var alert = UIAlertController(title: "Alert", message: "Mauvaise combinaison Login Password", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }


}

