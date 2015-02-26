//
//  AccueilController.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 17/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreData

class AccueilController :UIViewController,  UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate {
    
    @IBOutlet var DisconnectButton: UIButton!
    @IBOutlet var pictureAccueil: UIImageView!
    @IBOutlet var firstNameAcceuil: UILabel!
    @IBOutlet var lastNameAccueil: UILabel!
    @IBOutlet var gpaAccueil: UILabel!
    @IBOutlet var logTableView: UITableView!
    
    var appDel : AppDelegate!
    var context : NSManagedObjectContext!
    
    var CookieManager = CookieState.CookieManager
    var semester : Array<String>! = Array<String>()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        appDel = (UIApplication.sharedApplication().delegate as AppDelegate)
        context = appDel!.managedObjectContext
        
        var req = NSFetchRequest(entityName:"SEMESTER")
        var result: NSArray = context.executeFetchRequest(req, error:nil) as [SEMESTER]
        if result.count == 0 {
            var newID = NSEntityDescription.insertNewObjectForEntityForName("SEMESTER", inManagedObjectContext: self.context!) as NSManagedObject
            newID.setValue("\(self.CookieManager.info.semester)", forKey:"title")
            println(self.CookieManager.info.semester)
            self.semester.append("\(self.CookieManager.info.semester)")
        } else {
            for res in result {
                let str = res.title!
                self.semester.append(str!)
            }
        }
        CookieManager.semester = self.semester
        DisconnectButton.setTitle("", forState: UIControlState.Normal)
        DisconnectButton.setImage(UIImage(named: "settings.png"), forState: UIControlState.Normal)
        self.CookieManager.today.exludeSemester(self.semester)
        self.CookieManager.today.onlyRegister()
        var request = NSURLRequest(URL: NSURL(string: "https://cdn.local.epitech.eu/userprofil/profilview/\(self.CookieManager.user.login).jpg")!)
        pictureAccueil.backgroundColor = UIColor.grayColor()
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if (data != nil) {
                self.pictureAccueil.image = self.downloadPics(data)
            }
        })

        firstNameAcceuil.text = self.CookieManager.info.firstname
        lastNameAccueil.text = self.CookieManager.info.lastname
        gpaAccueil.text = "GPA : \(self.CookieManager.user.GPA)"
        logTableView.rowHeight = UITableViewAutomaticDimension
        logTableView.estimatedRowHeight = 220.0
        CookieManager.week.exludeSemester(self.semester)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        var req = NSFetchRequest(entityName:"SEMESTER")
        var result: NSArray = context.executeFetchRequest(req, error:nil) as [SEMESTER]
        for e in result {
            let str = e.title??
            if !contains(self.semester,str!) {
                logTableView.reloadData()
            }
        }
        self.navigationController?.navigationBar.hidden = true
        
    }
    
    func downloadPics(data : NSData) ->UIImage {
        var pics  = UIImage(data: data)!
        var newSize:CGSize = CGSize(width: 80,height: 95)
        let rect = CGRectMake(0,0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        pics.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch(section)
        {
        case 0:
            return self.CookieManager.week.countRegisterToday
        case 1:
            return self.CookieManager.note.element.count
        case 2:
            return self.CookieManager.projets.element.count
        case 3:
            return self.CookieManager.history.element.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var dateFormatter : NSDateFormatter = NSDateFormatter()
        switch (indexPath.section) {
            case 0:
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var data : WeekPlanningElement = self.CookieManager.week.getNextRegister(indexPath.row)
                var start = dateFormatter.stringFromDate(data.start)
                var end  = dateFormatter.stringFromDate(data.end)
                var room : String = data.roomCode
                let cell = tableView.dequeueReusableCellWithIdentifier("TodayCell") as CustomTodayCell
                cell.titleTextField?.text = data.acti_title
                cell.hourTextField?.text = "De \(start.substringFromIndex(advance(start.startIndex, 11))) à \(end.substringFromIndex(advance(end.startIndex, 11)))"
                var index = room.rangeOfString("/", options:NSStringCompareOptions.BackwardsSearch)?.startIndex
                var substring: String = room.substringFromIndex(advance(index!, 1))
                cell.roomTextField.text = substring
                cell.contentView.bounds.size.width = UIScreen.mainScreen().bounds.width
                cell.layoutIfNeeded()
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath) as CustomNoteCell
                cell.titleTextField.text = self.CookieManager.note.element[indexPath.row].title
                cell.markTextField.text = "Note : \(self.CookieManager.note.element[indexPath.row].note)"
                cell.teacherTextField.text = "Correcteur : \(self.CookieManager.note.element[indexPath.row].noteur)"
                cell.layoutIfNeeded()
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                return cell
            case 2:
                var start = self.CookieManager.projets.element[indexPath.row].timeline_start
                var end  = self.CookieManager.projets.element[indexPath.row].timeline_end
                let cell = tableView.dequeueReusableCellWithIdentifier("ProjetsCell", forIndexPath: indexPath) as CustomProjetsCell
                cell.titleTextField.text = self.CookieManager.projets.element[indexPath.row].title
                cell.dateTextField.text = "Du \(start.substringToIndex(advance(start.startIndex, 10))) au \(end.substringToIndex(advance(end.startIndex, 10)))"
                cell.layoutIfNeeded()
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                return cell
            case 3:
                let cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell", forIndexPath: indexPath) as CustomHistoryCell
                
                let regex:NSRegularExpression  = NSRegularExpression(
                    pattern: "<.*?>",
                    options: NSRegularExpressionOptions.CaseInsensitive,
                    error: nil)!
                
                let rangeTitle = NSMakeRange(0, countElements(self.CookieManager.history.element[indexPath.row].title))
                let titleHtmlLessString :String = regex.stringByReplacingMatchesInString(self.CookieManager.history.element[indexPath.row].title,
                    options: NSMatchingOptions.allZeros,
                    range:rangeTitle ,
                    withTemplate: "")
                
                let rangeContent = NSMakeRange(0, countElements(self.CookieManager.history.element[indexPath.row].content))
                let contentHtmlLessString :String = regex.stringByReplacingMatchesInString(self.CookieManager.history.element[indexPath.row].content,
                    options: NSMatchingOptions.allZeros,
                    range:rangeContent ,
                    withTemplate: "")

                
                
                cell.titleTextField.text = titleHtmlLessString
                cell.contentTextField.text = contentHtmlLessString
                cell.layoutIfNeeded()
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()

                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("TodayCell", forIndexPath: indexPath) as CustomTodayCell
                return cell
            
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as CustomHeaderCell
        headerCell.backgroundColor = UIColor(red: 0/255.0, green: 96/255.0, blue: 172/255.0, alpha: 1.0)
        headerCell.textLabel?.textColor = UIColor.whiteColor()
            switch (section) {
            case 0:
                headerCell.textLabel?.text = "Aujourd'hui"
                break
            case 1:
                headerCell.textLabel?.text = "Note"
                break
            case 2:
                headerCell.textLabel?.text = "Projet"
                break
            case 3:
                headerCell.textLabel?.text = "Historique"
                break
            default:
                headerCell.textLabel?.text = "Other"
        }
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var imageView : UIImageView = UIImageView(frame:  CGRectMake(0, 0, tableView.frame.size.width, 0.5))
        imageView.backgroundColor = UIColor.blackColor()
        return imageView
    }
   
    
    @IBAction func optionShow(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: "Options", delegate: self, cancelButtonTitle: "Annuler", destructiveButtonTitle: nil, otherButtonTitles: "Choix semestre", "Déconnexion")
        actionSheet.actionSheetStyle = .Default
        actionSheet.showInView(self.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            performSegueWithIdentifier("semesterSegue", sender: self)
        }
        if buttonIndex == 2 {
         dismissViewControllerAnimated(true, completion: nil)
        }
    }

}