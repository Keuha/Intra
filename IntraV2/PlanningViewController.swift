//
//  PlanningViewController.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 18/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PlanningViewController : UIViewController {
    
    
    @IBOutlet var planningTableView: UITableView!
    var CookieManager = CookieState.CookieManager
    var activityIndicator = UIActivityIndicatorView()
    var dayOfTheWeek = ["", "Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
    var dateFormatter : NSDateFormatter = NSDateFormatter()
    var row : Dictionary<String, Int> = Dictionary<String, Int>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        self.activityIndicator.stopAnimating()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "Refresh:", name: "SuccessLogin", object: nil)
       
    }
    
    override func viewWillAppear(animated: Bool) {
        self.activityIndicator.frame = CGRectMake(0, 0, 40.0, 40.0);
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.activityIndicator.hidden = true
        self.view.addSubview(self.activityIndicator)
        planningTableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (CookieManager.week == nil) {
            return 0
        }
        switch(section)
        {
        case 0:
            if let res = CookieManager.week.element[0].count as Int?  {
                return res
            } else {
                return 0
            }
        case 1:
            if let res = CookieManager.week.element[1].count as Int? {
                return res
            } else {
                return 0
            }
        case 2:
            if let res = CookieManager.week.element[2].count as Int? {
                return res
            } else {
                return 0
            }
        case 3:
            if let res = CookieManager.week.element[3].count as Int? {
                return res
            } else {
                return 0
            }
        case 4:
            if let res = CookieManager.week.element[4].count as Int? {
                return res
            } else {
                return 0
            }
        case 5:
            if let res = CookieManager.week.element[5].count as Int? {
                return res
            } else {
                return 0
            }
        case 6:
            if let res = CookieManager.week.element[6].count as Int? {
                return res
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var start = dateFormatter.stringFromDate(CookieManager.week.element[indexPath.section][indexPath.row].start)
        var end  = dateFormatter.stringFromDate(CookieManager.week.element[indexPath.section][indexPath.row].end)
        var room : String = CookieManager.week.element[indexPath.section][indexPath.row].roomCode
        let cell = tableView.dequeueReusableCellWithIdentifier("TodayCell") as CustomTodayCell
        cell.row = indexPath.row
        cell.section = indexPath.section
        cell.delegate = self
        cell.titleTextField?.text = CookieManager.week.element[indexPath.section][indexPath.row].acti_title
        cell.hourTextField?.text = "De \(start.substringFromIndex(advance(start.startIndex, 11))) à \(end.substringFromIndex(advance(end.startIndex, 11)))"
        if (!room.isEmpty) {
            var index = room.rangeOfString("/", options:NSStringCompareOptions.BackwardsSearch)?.startIndex
            var substring: String = room.substringFromIndex(advance(index!, 1))
            cell.roomTextField.text = substring
        }
        
        if (CookieManager.week.element[indexPath.section][indexPath.row].event_registered == "registered" ) {
            cell.registerButton.setTitle("\u{2713}", forState: nil)
        } else {
            cell.registerButton.setTitle("x", forState: nil)
        }
        cell.registerButton.addTarget(cell, action: "pressedAction:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.contentView.bounds.size.width = UIScreen.mainScreen().bounds.width
        cell.layoutIfNeeded()
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as CustomHeaderCell
        headerCell.backgroundColor = UIColor(red: 0/255.0, green: 96/255.0, blue: 172/255.0, alpha: 1.0)
        headerCell.textLabel?.textColor = UIColor.whiteColor()
        let myCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        switch(section) {
        case 0:
            var day : Int =  myCalendar!.components(.WeekdayCalendarUnit, fromDate: NSDate()).weekday
            var date : String = dateFormatter.stringFromDate(NSDate())
            headerCell.textLabel?.text = "\(self.dayOfTheWeek[day]) - \(date)"
            return headerCell
        case 1:
            var day : Int =  myCalendar!.components(.WeekdayCalendarUnit, fromDate: NSDate().dateByAddingTimeInterval(60*60*24*1)).weekday
            var date : String = dateFormatter.stringFromDate(NSDate().dateByAddingTimeInterval(60*60*24*1))
            headerCell.textLabel?.text = "\(self.dayOfTheWeek[day]) - \(date)"
            return headerCell
        case 2:
            var day : Int =  myCalendar!.components(.WeekdayCalendarUnit, fromDate: NSDate().dateByAddingTimeInterval(60*60*24*2)).weekday
            var date : String = dateFormatter.stringFromDate(NSDate().dateByAddingTimeInterval(60*60*24*2))
            headerCell.textLabel?.text = "\(self.dayOfTheWeek[day]) - \(date)"
            return headerCell
        case 3:
            var day : Int =  myCalendar!.components(.WeekdayCalendarUnit, fromDate: NSDate().dateByAddingTimeInterval(60*60*24*3)).weekday
            var date : String = dateFormatter.stringFromDate(NSDate().dateByAddingTimeInterval(60*60*24*3))
            headerCell.textLabel?.text = "\(self.dayOfTheWeek[day]) - \(date)"
            return headerCell
        case 4:
            var day : Int =  myCalendar!.components(.WeekdayCalendarUnit, fromDate: NSDate().dateByAddingTimeInterval(60*60*24*4)).weekday
            var date : String = dateFormatter.stringFromDate(NSDate().dateByAddingTimeInterval(60*60*24*4))
            headerCell.textLabel?.text = "\(self.dayOfTheWeek[day]) - \(date)"
            return headerCell
        case 5:
            var day : Int =  myCalendar!.components(.WeekdayCalendarUnit, fromDate: NSDate().dateByAddingTimeInterval(60*60*24*5)).weekday
            var date : String = dateFormatter.stringFromDate(NSDate().dateByAddingTimeInterval(60*60*24*5))
            headerCell.textLabel?.text = "\(self.dayOfTheWeek[day]) - \(date)"
            return headerCell
        case 6:
            var day : Int =  myCalendar!.components(.WeekdayCalendarUnit, fromDate: NSDate().dateByAddingTimeInterval(60*60*24*6)).weekday
            var date : String = dateFormatter.stringFromDate(NSDate().dateByAddingTimeInterval(60*60*24*6))
            headerCell.textLabel?.text = "\(self.dayOfTheWeek[day]) - \(date)"
            return headerCell
        case 7:
            var day : Int =  myCalendar!.components(.WeekdayCalendarUnit, fromDate: NSDate().dateByAddingTimeInterval(60*60*24*7)).weekday
            var date : String = dateFormatter.stringFromDate(NSDate().dateByAddingTimeInterval(60*60*24*7))
            headerCell.textLabel?.text = "\(self.dayOfTheWeek[day]) - \(date)"
            return headerCell

        default:
            return headerCell
        }
       
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var imageView : UIImageView = UIImageView(frame:  CGRectMake(0, 0, tableView.frame.size.width, 0.5))
        imageView.backgroundColor = UIColor.blackColor()
        return imageView
    }
    
    func Refresh(notification: NSNotification) {
        self.activityIndicator.stopAnimating()
        self.planningTableView.scrollEnabled = true;
        CookieManager.week.exludeSemester(CookieManager.semester)
        self.planningTableView.reloadData()
    }


}