//
//  Projets.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 18/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation
import Alamofire

class Projets {
    var element : Array<ProjetElement> = Array<ProjetElement>()
    
    init (J : JSON) {
        var i : Int = 0
        while (J[i] != nil) {
            element.append(ProjetElement(J:J[i]))
            i++
        }
    }
    
    func getProjetsElement(i : Int) ->ProjetElement {
        return element[i]
    }
    
    func getMaxProjetsElement() -> Int {
        var i : Int = element.count
        return i
    }
    
}

class ProjetElement {
    var ProjetElementJson : JSON
    var dateFormatter : NSDateFormatter = NSDateFormatter()
    
    var title : String { get { return ProjetElementJson["title"].string! } }
    var timeline_start : String { get { return ProjetElementJson["timeline_start"].string! } }
    var timeline_end : String { get { return ProjetElementJson["timeline_end"].string! } }
    var date_inscription : NSDate { get { return dateFormatter.dateFromString(ProjetElementJson["date_inscription"].string!)! } }
    var soutenance_date : NSDate { get { return dateFormatter.dateFromString(ProjetElementJson["soutenance_date"].string!)! } }
    var soutenance_salle : String { get { return ProjetElementJson["soutenance_salle"].string! } }
    
    
    init(J:JSON) {
        self.ProjetElementJson = J
        dateFormatter.dateFormat = "YYYY/MM/DD"
    }
}