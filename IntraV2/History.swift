//
//  History.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 18/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation
import Alamofire

class History {
    
    var element : Array<HistoryElement> = Array<HistoryElement>()
    
    init (J : JSON) {
        var i : Int = 0
        while (J[i] != nil) {
            element.append(HistoryElement(J:J[i]))
            i++
        }
    }
    
    func getHistoryElement(i : Int) ->HistoryElement {
        return element[i]
    }
    
    func getMaxTodayPlanningElement() -> Int {
        var i : Int = element.count
        return i
    }
}

class HistoryElement {
    
    var HistoryJson : JSON
    var dateFormatter : NSDateFormatter = NSDateFormatter()
    
    
    var title : String { get { return HistoryJson["title"].string! } }
    var content : String { get { return HistoryJson["content"].string! } }
    var id : String { get { return HistoryJson["id"].string! } }
    var visible : String { get { return HistoryJson["visible"].string! } }
    var id_activite : String { get { return HistoryJson["id_activite"].string! } }
    var date : NSDate { get { return dateFormatter.dateFromString(HistoryJson["title"].string!)! } }
    var _class : String { get { return HistoryJson["class"].string! } }

    init(J:JSON) {
        self.HistoryJson = J
        self.dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:SS"
    }
}