//
//  AccueilCell.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 18/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation
import UIKit

class CustomHeaderCell : UITableViewCell {
    
    @IBOutlet var headerTextField: UILabel!
    
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class CustomTodayCell : UITableViewCell {
    
    var section : Int!
    var row : Int!
    var delegate : PlanningViewController!
    @IBOutlet var roomTextField: UILabel!
    @IBOutlet var hourTextField: UILabel!
    @IBOutlet var titleTextField: UILabel!
    @IBOutlet var registerButton: UIButton!
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.frame = self.bounds;
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func pressedAction(sender: UIButton!) {
        var data = CookieState.CookieManager.week.element[section][row]
        if (data.event_registered == "") {
            var alert = UIAlertController(title: "Inscription", message: "Voulez-vous vous inscrire à l'activité \(data.acti_title) ?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler:nil))
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ _ in self.regist()
            }))
            self.delegate.presentViewController(alert, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Désinscription", message: "Voulez-vous vous désinscrire de l'activité \(data.acti_title) ?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler:nil))
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{
                _ in self.unregist()
                
            }))
            self.delegate.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func regist() {
        self.delegate.activityIndicator.hidden = false
        self.delegate.activityIndicator.startAnimating()
        var data = CookieState.CookieManager.week.element[section][row]
        CookieState.CookieManager.registerEvent(data.scolaryear, codeModule: data.codemodule, codeInstance: data.codeinstance, codeActi: data.codeacti, codeEvent: data.codeevent)
    }
    
    private func unregist() {
        self.delegate.activityIndicator.hidden = false
        self.delegate.activityIndicator.startAnimating()
        var data = CookieState.CookieManager.week.element[section][row]
        CookieState.CookieManager.unregisterEvent(data.scolaryear, codeModule: data.codemodule, codeInstance: data.codeinstance, codeActi: data.codeacti, codeEvent: data.codeevent)
    }
    
}

class CustomNoteCell : UITableViewCell {
    @IBOutlet var titleTextField: UILabel!
    @IBOutlet var teacherTextField: UILabel!
    @IBOutlet var markTextField: UILabel!
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

class CustomProjetsCell : UITableViewCell {
    
    @IBOutlet var dateTextField: UILabel!
    @IBOutlet var titleTextField: UILabel!
    
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
         self.contentView.frame = self.bounds;
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

class CustomHistoryCell : UITableViewCell {
    
    @IBOutlet var titleTextField: UILabel!
    @IBOutlet var contentTextField: UILabel!
    
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}