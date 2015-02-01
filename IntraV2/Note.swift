//
//  Note.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 18/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation
import Alamofire

class Note {
    var element : Array<NoteElement> = Array<NoteElement>()
    
    init (J : JSON) {
        
        var i : Int = 0
        while (J[i] != nil) {
            element.append(NoteElement(J:J[i]))
            i++
        }
    }
    
    func getNoteElement(i : Int) ->NoteElement {
        return element[i]
    }
    
    func getMaxNoteElement() -> Int {
        var i : Int = element.count
        return i
    }

}

class NoteElement {
    var NoteElementJson : JSON
    
    
    var title : String { get { return NoteElementJson["title"].string! } }
    var note : String { get { return NoteElementJson["note"].string! } }
    var noteur : String { get { return NoteElementJson["noteur"].string! } }
    init(J:JSON) {
        self.NoteElementJson = J
    }
}