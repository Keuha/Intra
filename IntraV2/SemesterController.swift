//
//  SemesterController.swift
//  IntraTek
//
//  Created by Franck PETRIZ on 26/02/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SemesterViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var semesterTableView: UITableView!
    var activityIndicator = UIActivityIndicatorView()
    var appDel : AppDelegate!
    var context : NSManagedObjectContext!
    var CookieManager : Cookie!
    
    
    override func viewDidLoad() {
        
        CookieManager = CookieState.CookieManager
        appDel = (UIApplication.sharedApplication().delegate as AppDelegate)
        context = appDel!.managedObjectContext
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "Refresh:", name: "SuccessLogin", object: nil)
        self.activityIndicator.frame = CGRectMake(0, 0, 40.0, 40.0);
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.activityIndicator.hidden = true
        self.view.addSubview(self.activityIndicator)

    }
    
    override func viewWillAppear(animated: Bool) {
        self.saveButton.enabled = false
        self.navigationController?.navigationBar.hidden = false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("semesterCell") as CustomSemesterCell
        cell.semesterLabel.text = "Semestre : \(indexPath.row)"
        println("CookieManager.semester \(CookieManager.semester) contains \(indexPath.row)")
        if contains(CookieManager.semester, "\(indexPath.row)") {
            println("YEAH")
            cell.registerLabel.text = "\u{2713}"
        } else {
             cell.registerLabel.text = "+"
        }
        return cell
    }
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as CustomSemesterCell
        if  cell.registerLabel.text == "\u{2713}" {
            cell.registerLabel.text = "+"
            let ind : Int = find(CookieManager.semester, "\(indexPath.row)")!
            CookieManager.semester.removeAtIndex(ind)
        } else {
            cell.registerLabel.text = "\u{2713}"
            CookieManager.semester.insert("\(indexPath.row)", atIndex: CookieManager.semester.count)
        }
        if self.saveButton.enabled == false {
            self.saveButton.enabled = true
        }
    }
    
    @IBAction func SaveButtonCliked(sender: AnyObject) {
        var request = NSFetchRequest(entityName:"SEMESTER")
        var result: NSArray = context.executeFetchRequest(request, error:nil) as [SEMESTER]
        for res in result {
            context.deleteObject(res as NSManagedObject)
        }
        for e in CookieManager.semester {
        var newID = NSEntityDescription.insertNewObjectForEntityForName("SEMESTER", inManagedObjectContext: self.context!) as NSManagedObject
        newID.setValue(e, forKey:"title")
        }
        context.save(nil)
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        self.view.userInteractionEnabled = false
        CookieManager?.refreshWeekPlanning()
        
    }
    
    func Refresh(notification: NSNotification) {
         self.activityIndicator.stopAnimating()
        self.view.userInteractionEnabled = true
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
   
    
}

