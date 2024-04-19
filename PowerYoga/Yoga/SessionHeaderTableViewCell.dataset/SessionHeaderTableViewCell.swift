//
//  SessionHeaderTableViewCell.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/15/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import UIKit

class SessionHeaderTableViewCell: UITableViewCell {
	
	@IBOutlet weak var sessionName: UILabel!
	@IBOutlet weak var duration: UILabel!
	@IBOutlet weak var sessionBackground: UIImageView!
	@IBOutlet weak var sessionDetail: UILabel!
	@IBOutlet weak var numPoses: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
