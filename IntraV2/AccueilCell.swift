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