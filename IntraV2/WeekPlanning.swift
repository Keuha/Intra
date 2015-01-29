//
//  WeekPlanning.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 17/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation


class WeekPlanning {
    
    var element : Array<Array<WeekPlanningElement>> = Array<Array<WeekPlanningElement>>()
    var dateFormatter : NSDateFormatter = NSDateFormatter()
    
    init (J : JSON) {
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:SS"
        for (var y : Int = 0; y < 7; y++) {
            element.append(Array<WeekPlanningElement>())
        }
        var i : Int = 0
        while (J[i] != nil) {
            var subDate = dateSubString(dateFormatter.dateFromString(J[i]["start"].string!)!)
            element[arrayPosition(subDate)].append(WeekPlanningElement(J: J[i]))
            i++
        }
    }
    
    
    func dateSubString (date :NSDate) ->String {
        var str : String = dateFormatter.stringFromDate(date)
        return str.substringToIndex(advance(str.startIndex, 10))
    }
    
    func arrayPosition(str : String) ->Int {
        switch(str)
        {
        case dateSubString(NSDate().dateByAddingTimeInterval(60*60*24*0)):
            return 0
        case dateSubString(NSDate().dateByAddingTimeInterval(60*60*24*1)):
            return 1
        case dateSubString(NSDate().dateByAddingTimeInterval(60*60*24*2)):
            return 2
        case dateSubString(NSDate().dateByAddingTimeInterval(60*60*24*3)):
            return 3
        case dateSubString(NSDate().dateByAddingTimeInterval(60*60*24*4)):
            return 4
        case dateSubString(NSDate().dateByAddingTimeInterval(60*60*24*5)):
            return 5
        case dateSubString(NSDate().dateByAddingTimeInterval(60*60*24*6)):
            return 6
        default:
            return 0
        }
        
    }
    
    
    func getMaxWeekPlanningElement() -> Int {
        var i : Int = element.count
        return i
    }
    
    func exludeSemester(_semester : Int) {
        var i : Int = 0
        var y : Int = 0
        for (; i < 7; i++) {
            y = 0
            while (y < element[i].count) {
                if (element[i][y].semester != _semester || element[i][y].acti_title.isEmpty || element[i][y].roomCode.isEmpty
                || element[i][y].start.isEqual(nil) ) {
                        element[i].removeAtIndex(y)
                } else {
                    y++
                }
            }
            element[i].sort({$0.start.timeIntervalSince1970 < $1.start.timeIntervalSince1970})
        }
    }
}

class WeekPlanningElement  {
    
    var WeekPlanningElementJson : JSON
    var dateFormatter : NSDateFormatter = NSDateFormatter()
    var dateFormatterHour : NSDateFormatter = NSDateFormatter()
    
    var title : String { get { return WeekPlanningElementJson["title"].string! } }
    var rdv_indiv_registered : String { get { return WeekPlanningElementJson["rdv_indiv_registered"].string! } }
    var allowed_planning_end : NSDate { get { return dateFormatter.dateFromString(WeekPlanningElementJson["allowed_planning_end"].string!)! } }
    var nb_group : Int { get { return WeekPlanningElementJson["nb_group"].int! } }
    var start : NSDate { get {
        if let str = WeekPlanningElementJson["start"].string {
            if let date = dateFormatter.dateFromString(str) {
                return date
            } else {
            return NSDate()
            }
        } else {
            return NSDate()
        } } }
    var register_month : String { get { return WeekPlanningElementJson["register_month"].string! } }
    var allowed_planning_start : NSDate { get { return dateFormatter.dateFromString(WeekPlanningElementJson["allowed_planning_start"].string!)! } }
    var project : String { get { return WeekPlanningElementJson["project"].string! } }
    var event_registered : String { get { if let str = WeekPlanningElementJson["event_registered"].string { return str } else { return "" } } }
    var total_students_registered : Int { get { return WeekPlanningElementJson["total_students_registered"].int! } }
    var allow_register : Bool { get { return WeekPlanningElementJson["allow_register"].bool! } }
    var codemodule : String { get { return WeekPlanningElementJson["codemodule"].string! } }
    var rdv_group_registered : String { get { return WeekPlanningElementJson["rdv_group_registeredle"].string! } }
    var semester : Int { get { if let sem = WeekPlanningElementJson["semester"].int { return sem } else { return 0 } } }
    var type_code : String { get { return WeekPlanningElementJson["type_code"].string! } }
    var is_rdv : Int { get { return WeekPlanningElementJson["is_rdv"].int! } }
    var allow_token : Int { get { return WeekPlanningElementJson["allow_token"].int! } }
    var titlemodule : String { get { return WeekPlanningElementJson["titlemodule"].string! } }
    var in_more_than_one_mounth : Bool { get { return WeekPlanningElementJson["in_more_than_one_mounth"].bool! } }
    var acti_title : String { get { if let str = WeekPlanningElementJson["acti_title"].string { return str } else { return "Unknown" } } }
    var instance_location : String { get { return WeekPlanningElementJson["instance_location"].string! } }
    var nb_hours : NSDate { get { return dateFormatterHour.dateFromString(WeekPlanningElementJson["nb_hours"].string!)! } }
    var register_prof : String { get { return WeekPlanningElementJson["register_prof"].string! } }
    var nb_max_students_projet : Int { get { return WeekPlanningElementJson["nb_max_students_projet"].int! } }
    var roomCode : String { get { if let str = WeekPlanningElementJson["room"]["code"].string { return str } else { return "" } } }
    var codeacti : String { get { return WeekPlanningElementJson["codeacti"].string! } }
    var codeevent :String { get { return WeekPlanningElementJson["codeevent"].string! } }
    var codeinstance : String { get { return WeekPlanningElementJson["codeinstance"].string! } }
    var dates : NSDate { get { return dateFormatter.dateFromString(WeekPlanningElementJson["dates"].string!)! } }
    var register_student : Bool { get { return WeekPlanningElementJson["title"].bool! } }
    var type_title : String { get { return WeekPlanningElementJson["register_student"].string! } }
    var num_event : Int { get { return WeekPlanningElementJson["num_event"].int! } }
    var end : NSDate { get { return dateFormatter.dateFromString(WeekPlanningElementJson["end"].string!)! } }
    var scolaryear : String { get { return WeekPlanningElementJson["scolaryear"].string! } }
    var module_registered : Bool { get { return WeekPlanningElementJson["module_registered"].bool! } }
    var past : Bool { get { return WeekPlanningElementJson["past"].bool! } }
    var module_available : Bool { get { return WeekPlanningElementJson["module_available"].bool! } }
    var status_manager : String { get { return WeekPlanningElementJson["status_manager"].string! } }
    
    init(J : JSON) {
        self.WeekPlanningElementJson = J
        dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss"
        dateFormatterHour.dateFormat = "HH:mm:ss"
    }
}