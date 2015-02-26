//
//  SemesterCell.swift
//  IntraTek
//
//  Created by Franck PETRIZ on 26/02/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import UIKit

class CustomSemesterCell: UITableViewCell {
    
    @IBOutlet var semesterLabel: UILabel!
    @IBOutlet var registerLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
