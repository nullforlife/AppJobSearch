//
//  JobCellTableViewCell.swift
//  IT JobSearch
//
//  Created by ITHS on 2016-04-12.
//  Copyright © 2016 Oskar Jönsson. All rights reserved.
//

import UIKit

class JobCellTableViewCell: UITableViewCell {

    @IBOutlet weak var advertisementHeadline: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var datePublished: UILabel!
    
    var id :String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
