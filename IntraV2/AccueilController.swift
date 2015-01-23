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

class AccueilController :UIViewController,  UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var pictureAccueil: UIImageView!
    @IBOutlet var firstNameAcceuil: UILabel!
    @IBOutlet var lastNameAccueil: UILabel!
    @IBOutlet var gpaAccueil: UILabel!
    @IBOutlet var logTableView: UITableView!
    var CookieManager = CookieState.CookieManager
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CookieManager.today.exludeSemester(self.CookieManager.info.semester)
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
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        logTableView.reloadData()
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
            return self.CookieManager.today.element.count
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
                dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss"
                var start = dateFormatter.stringFromDate(self.CookieManager.today.element[indexPath.row].start)
                var end  = dateFormatter.stringFromDate(self.CookieManager.today.element[indexPath.row].end)
                var room : String = self.CookieManager.today.element[indexPath.row].roomCode
                let cell = tableView.dequeueReusableCellWithIdentifier("TodayCell") as CustomTodayCell
                cell.titleTextField?.text = self.CookieManager.today.element[indexPath.row].acti_title
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
   

}