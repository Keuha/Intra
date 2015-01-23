
//
//  Infos.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 17/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation
import Alamofire


class Infos {
    
    var infoJson : JSON
    var dateFromatter = NSDateFormatter()
    
    
    var id : Int64              { get { return infoJson["infos"]["id"].int64! } }
    var login :String           { get { return infoJson["infos"]["login"].string! } }
    var title  :String          { get { return infoJson["infos"]["title"].string! } }
    var email :String           { get { return infoJson["infos"]["email"].string! } }
    var internal_emailn : String{ get { return infoJson["infos"]["internal_emailn"].string! } }
    var lastname : String       { get { return infoJson["infos"]["lastname"].string! } }
    var firstname : String      { get { return infoJson["infos"]["firstname"].string! } }
    var referent_used : Bool    { get { return infoJson["infos"]["referent_used"].bool! } }
    var picture : String        { get { return infoJson["infos"]["picture"].string! } }
    var email_referent : String { get { return infoJson["infos"]["email_referent"].string! } }
    var pass_referent : String  { get { return infoJson["infos"]["pass_referent"].string! } }
    var promo : Int             { get { return infoJson["infos"]["promo"].int! } }
    var semester : Int          { get { return infoJson["infos"]["semester"].int! } }
    var uid : Int               { get { return infoJson["infos"]["uid"].int! } }
    var gid : Int               { get { return infoJson["infos"]["gid"].int! } }
    var location : String       { get { return infoJson["infos"]["location"].string! } }
    var netsoul :Bool           { get { return infoJson["infos"]["netsoul"].bool! } }
    var close : Bool            { get { return infoJson["infos"]["close"].bool! } }
    var close_reason : String   { get { return infoJson["infos"]["close_reason"].string! } }
    var comment : String        { get { return infoJson["infos"]["comment"].string! } }
    var id_promo : Int          { get { return infoJson["infos"]["id_promo"].int! } }
    var id_history : Int        { get { return infoJson["infos"]["id_history"].int! } }
    var course_code : String    { get { return infoJson["infos"]["course_code"].string! } }
    var school_code : String    { get { return infoJson["infos"]["school_code"].string! } }
    var school_title : String   { get { return infoJson["infos"]["school_title"].string! } }
    var invited : Bool          { get { return infoJson["infos"]["invited"].bool! } }
    var studentyear : Int       { get { return infoJson["infos"]["studentyear"].int! } }
    var admin : Bool            { get { return infoJson["infos"]["admin"].bool! } }
    var ctime : NSDate          { get { return dateFromatter.dateFromString(infoJson["infos"]["ctime"].string!)! } }
    var mtime : NSDate          { get { return dateFromatter.dateFromString(infoJson["infos"]["mtime"].string!)! } }

     
    init (J : JSON!) {
        
        dateFromatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        println(J["infos"]["id"])
        self.infoJson = J

    }
}