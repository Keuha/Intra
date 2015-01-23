//
//  User.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 17/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation
import Alamofire

class User {
    var userJson : JSON
    
    var login   : String    { get { return userJson["login"].string! } }
    var GPA     : String    { get { return userJson["gpa"][0]["gpa"].string! } }
    var credits : Int       { get { return userJson["credits"].int! } }
    var log     : Int       { get { return userJson["nsstat"]["active"].int! } }
    
    init (J: JSON!) {
        self.userJson = J
    }
}
