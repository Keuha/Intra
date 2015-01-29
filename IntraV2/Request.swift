//
//  Request.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 17/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation
import Alamofire

class Cookie {
    
    var url : NSURL
    var jData : JSON?
    var info : Infos!
    var user : User!
    var today : TodayPlanning!
    var history : History!
    var note : Note!
    var projets : Projets!
    var week : WeekPlanning!
    var propertie = [
        NSHTTPCookiePath: "/",
        NSHTTPCookieName: "language",
        NSHTTPCookieValue: "fr",
        NSHTTPCookieDomain: "intra.epitech.eu",
        NSHTTPCookieVersion: "0",
        NSHTTPCookieSecure: true //Indispensable
    ]
    
    let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage()
    
    init ()
    {
        url = NSURL(string: "https://intra.epitech.eu?")!
        self.cookies.setCookie(NSHTTPCookie(properties: self.propertie)!)
        
    }
    
    func requestWithURL(url: String)-> Void {
        Alamofire.request(.POST, url).response{(request, response, J, error)in
            if (response != nil) {
                var data = self.toData(J as String)
                var dataJ = JSON(data: data)
                self.jData = dataJ
            }
        }
    }
    
    func logIn(log: String, pass : String) -> Void {
        NSNotificationCenter.defaultCenter().postNotificationName("Update", object: nil, userInfo:["message" : "identification ..."])
        Alamofire.request(.POST, url, parameters: ["login" : log, "password" : pass]).response{(request, response, J, error) in
            if (response != nil) {
                self.goToURL(NSURL(string : "https:/intra.epitech.eu?format=json")!)
            }
        }
    }
    
    func toData(jString: String)-> NSData{
        var j = jString.substringFromIndex(advance(jString.startIndex,31))
        return j.dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
    func goToURL(url : NSURL)-> Void {
        NSNotificationCenter.defaultCenter().postNotificationName("Update", object: nil, userInfo:["message" : "obtention des informations ..."])
        var URLRequest = NSURLRequest(URL: url)
        Alamofire.request(.POST, url).responseString{(request, response, jString, error) in
            if (jString != "") {
                var jData = self.toData(jString!)
                var flux = JSON(data: jData)
                if let toto = flux["message"].string {
                    NSNotificationCenter.defaultCenter().postNotificationName("FailedLogin", object: nil, userInfo:nil)
                    return
                }
                self.info = Infos(J:flux)
                self.history = History(J:flux["history"])
                self.note = Note(J:flux["board"]["notes"])
                self.projets = Projets(J:flux["board"]["projets"])
                self.loadUserInfo(NSURL(string : "https://intra.epitech.eu/user/?format=json")!)
            }
        }
    }
    
    func loadUserInfo(url : NSURL)->Void {
        NSNotificationCenter.defaultCenter().postNotificationName("Update", object: nil, userInfo:["message" : "recuperation du planning ..."])
        var URLRequest = NSURLRequest(URL: url)
        Alamofire.request(.POST, url).responseString{(request, response, jString, error) in
            if (jString != "") {
                var jData = self.toData(jString!)
                self.user = User(J:JSON(data:jData))
                var today = NSDateFormatter()
                today.dateFormat = "yyyy-MM-dd"
                self.loadTodayPlanning(NSURL(string :"https://intra.epitech.eu/planning/load?format=json&start=\(today.stringFromDate(NSDate()))&end=\(today.stringFromDate(NSDate()))")!)
            }
        }
    }
    
    func loadTodayPlanning(url : NSURL)->Void {
        println("loadTodayPlanning:NSURL() = \(url)")
        var URLRequest = NSURLRequest(URL: url)
        Alamofire.request(.POST, url).responseString{(request, response, jString, error) in
            if (jString != "") {
                var jData = self.toData(jString!)
                self.today = TodayPlanning(J:JSON(data:jData))
                
                var dateFormatter : NSDateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                
                let calendar = NSCalendar.currentCalendar()
                let date = NSDate()
                
                let components = NSDateComponents()
                components.day = 6

                var tmp = calendar.dateByAddingComponents(components, toDate: date, options: nil)
                
                var from : String = dateFormatter.stringFromDate(date)

                println("Date = \(tmp!) String from date = \(dateFormatter.stringFromDate(tmp!))")
                var to : String = dateFormatter.stringFromDate(tmp!)
                self.loadWeekPlanning(from, to: to)
            }
        }
    }
    
    func loadWeekPlanning(from : String, to :String)->Void {
        var url : NSURL = NSURL(string :"https://intra.epitech.eu/planning/load?format=json&start=\(from)&end=\(to)")!
        println("requete pour le planning : \(url)" )
        var URLRequest = NSURLRequest(URL: url)
        Alamofire.request(.POST, url).responseString{(request, response, jString, error) in
            if (jString != "") {
                NSNotificationCenter.defaultCenter().postNotificationName("Update", object: nil, userInfo:["message" : "finalisation ..."])
                var jData = self.toData(jString!)
                self.week = WeekPlanning(J:JSON(data:jData))
                NSNotificationCenter.defaultCenter().postNotificationName("SuccessLogin", object: nil, userInfo:nil)
            }
        }
    }
    
    func registerEvent(scolarYear : String, codeModule :String, codeInstance : String, codeActi : String, codeEvent : String)->Void {
        var url : NSURL = NSURL(string :"https://intra.epitech.eu/module/\(scolarYear)/\(codeModule)/\(codeInstance)/\(codeActi)/\(codeEvent)/register?format=json")!
        println("requete pour suscribe : \(url)" )
        var URLRequest = NSURLRequest(URL: url)
        Alamofire.request(.POST, url).validate().response { (_, _, _, error) in
            self.refreshWeekPlanning()        }
    }

    
    func unregisterEvent(scolarYear : String, codeModule :String, codeInstance : String, codeActi : String, codeEvent : String)->Void {
        var url : NSURL = NSURL(string :"https://intra.epitech.eu/module/\(scolarYear)/\(codeModule)/\(codeInstance)/\(codeActi)/\(codeEvent)/unregister?format=json")!
        println("requete pour unsuscribe : \(url)" )
        var URLRequest = NSURLRequest(URL: url)
        Alamofire.request(.POST, url).validate().response { (_, _, _, error) in
            self.refreshWeekPlanning()        }
    }
    
    func refreshWeekPlanning() {
        var dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate()
        
        let components = NSDateComponents()
        components.day = 6
        
        var tmp = calendar.dateByAddingComponents(components, toDate: date, options: nil)
        
        var from : String = dateFormatter.stringFromDate(date)
        
        println("Date = \(tmp!) String from date = \(dateFormatter.stringFromDate(tmp!))")
        var to : String = dateFormatter.stringFromDate(tmp!)
        self.loadWeekPlanning(from, to: to)
    }
}