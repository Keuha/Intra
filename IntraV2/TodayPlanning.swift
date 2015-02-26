//
//  TodayPlanning.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 17/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation
import Alamofire

class TodayPlanning {
    
    var element : Array<TodayPlanningElement> = Array<TodayPlanningElement>()
    
    init (J : JSON) {
        var i : Int = 0
        while (J[i] != nil) {
            element.append(TodayPlanningElement(J:J[i]))
            i++
        }
    }
    
    func sorterForFileIDASC(this:TodayPlanningElement, that:TodayPlanningElement) -> Bool {
        return this.allowed_planning_start.timeIntervalSince1970 < that.allowed_planning_start.timeIntervalSince1970
    }
    
    func getTodayPlanningElement(i : Int) ->TodayPlanningElement {
        return element[i]
    }
    
    func getMaxTodayPlanningElement() -> Int {
        var i : Int = element.count
        return i
    }
    
    func exludeSemester(_semester : Array<String>) {
        var i : Int = 0
        while ( i < element.count) {
            if (!contains(_semester, "\(element[i].semester)") || element[i].acti_title.isEmpty || element[i].roomCode.isEmpty) {
                element.removeAtIndex(i)
            } else {
                i++
            }
        }
        element.sort({$0.start.timeIntervalSince1970 < $1.start.timeIntervalSince1970})
    }
    
    func onlyRegister() {
        
        var i : Int = 0
        while ( i < element.count)  {
            if (element[i].event_registered != "registered" || element[i].acti_title.isEmpty || element[i].roomCode.isEmpty || element[i].start.isEqual(nil))  {
                element.removeAtIndex(i)
            } else {
                i++
            }
        }
        element.sort({$0.start.timeIntervalSince1970 < $1.start.timeIntervalSince1970})
    }
}

class TodayPlanningElement  {
    
    var todayPlanningElementJson : JSON
    var dateFormatter : NSDateFormatter = NSDateFormatter()
    var dateFormatterHour : NSDateFormatter = NSDateFormatter()
    
    var title : String { get { return todayPlanningElementJson["title"].string! } }
    var rdv_indiv_registered : String { get { return todayPlanningElementJson["rdv_indiv_registered"].string! } }
    var allowed_planning_end : NSDate { get { return dateFormatter.dateFromString(todayPlanningElementJson["allowed_planning_end"].string!)! } }
    var nb_group : Int { get { return todayPlanningElementJson["nb_group"].int! } }
    var start : NSDate { get { return dateFormatter.dateFromString(todayPlanningElementJson["start"].string!)! } }
    var register_month : String { get { return todayPlanningElementJson["register_month"].string! } }
    var allowed_planning_start : NSDate { get { return dateFormatter.dateFromString(todayPlanningElementJson["allowed_planning_start"].string!)! } }
    var project : String { get { return todayPlanningElementJson["project"].string! } }
    var event_registered : String { get { if let res : String = todayPlanningElementJson["event_registered"].string? { return res } else { return "" } } }
    var total_students_registered : Int { get { return todayPlanningElementJson["total_students_registered"].int! } }
    var allow_register : Bool { get { return todayPlanningElementJson["allow_register"].bool! } }
    var codemodule : String { get { return todayPlanningElementJson["codemodule"].string! } }
    var rdv_group_registered : String { get { return todayPlanningElementJson["rdv_group_registeredle"].string! } }
    var semester : Int { get { if let i = todayPlanningElementJson["semester"].int  { return i } else { return 0 } } }
    var type_code : String { get { return todayPlanningElementJson["type_code"].string! } }
    var is_rdv : Int { get { return todayPlanningElementJson["is_rdv"].int! } }
    var allow_token : Int { get { return todayPlanningElementJson["allow_token"].int! } }
    var titlemodule : String { get { return todayPlanningElementJson["titlemodule"].string! } }
    var in_more_than_one_mounth : Bool { get { return todayPlanningElementJson["in_more_than_one_mounth"].bool! } }
    var acti_title : String { get { if let str =  todayPlanningElementJson["acti_title"].string { return str } else { return "" } } }
    var instance_location : String { get { return todayPlanningElementJson["instance_location"].string! } }
    var nb_hours : NSDate { get { return dateFormatterHour.dateFromString(todayPlanningElementJson["nb_hours"].string!)! } }
    var register_prof : String { get { return todayPlanningElementJson["register_prof"].string! } }
    var nb_max_students_projet : Int { get { return todayPlanningElementJson["nb_max_students_projet"].int! } }
    var roomCode : String { get { if let str = todayPlanningElementJson["room"]["code"].string { return str } else { return "" } } }
    var codeacti : String { get { return todayPlanningElementJson["codeacti"].string! } }
    var codeevent :String { get { return todayPlanningElementJson["codeevent"].string! } }
    var codeinstance : String { get { return todayPlanningElementJson["codeinstance"].string! } }
    var dates : NSDate { get { return dateFormatter.dateFromString(todayPlanningElementJson["dates"].string!)! } }
    var register_student : Bool { get { return todayPlanningElementJson["title"].bool! } }
    var type_title : String { get { return todayPlanningElementJson["register_student"].string! } }
    var num_event : Int { get { return todayPlanningElementJson["num_event"].int! } }
    var end : NSDate { get { return dateFormatter.dateFromString(todayPlanningElementJson["end"].string!)! } }
    var scolaryear : Int { get { return todayPlanningElementJson["scolaryear"].int! } }
    var module_registered : Bool { get { return todayPlanningElementJson["module_registered"].bool! } }
    var past : Bool { get { return todayPlanningElementJson["past"].bool! } }
    var module_available : Bool { get { return todayPlanningElementJson["module_available"].bool! } }
    var status_manager : String { get { return todayPlanningElementJson["status_manager"].string! } }
        
    init(J : JSON) {
        self.todayPlanningElementJson = J
        dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:SS"
        dateFormatterHour.dateFormat = "HH:mm:SS"
    }
}