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
        if (data.type_title == "Soutenance" || data.type_title == "Suivis") {
            var alert = UIAlertController(title: "Action impossible", message: "Impossible de s'incrire aux événement de type Suivis ou Soutenance", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler:nil))
            self.delegate.presentViewController(alert, animated: true, completion: nil)
        } else if (data.event_registered == "") {
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
        self.delegate.planningTableView.scrollEnabled = false;
        self.delegate.activityIndicator.hidden = false
        self.delegate.activityIndicator.startAnimating()
        var data = CookieState.CookieManager.week.element[section][row]
        CookieState.CookieManager.registerEvent(data.scolaryear, codeModule: data.codemodule, codeInstance: data.codeinstance, codeActi: data.codeacti, codeEvent: data.codeevent)
    }
    
    private func unregist() {
        self.delegate.planningTableView.scrollEnabled = false;
        self.delegate.activityIndicator.hidden = false
        self.delegate.activityIndicator.startAnimating()
        var data = CookieState.CookieManager.week.element[section][row]
        CookieState.CookieManager.unregisterEvent(data.scolaryear, codeModule: data.codemodule, codeInstance: data.codeinstance, codeActi: data.codeacti, codeEvent: data.codeevent)
    }
    
    private func setOverlay() -> UIImage {
        var rect : CGRect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        UIGraphicsBeginImageContext(rect.size);
        var context :CGContextRef  = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextFillRect(context, rect)
        
        var img : UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img
    }
    
}

class CustomNoteCell : UITableViewCell {
    @IBOutlet var titleTextField: UILabel!
    @IBOutlet var teacherTextField: UILabel!
    @IBOutlet var markTextField: UILabel!
    
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