//
//  SessionDetailHeaderTableViewCell.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/15/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import UIKit

class SessionDetailHeaderTableViewCell: UITableViewCell {
	
	@IBOutlet weak var sessionName: UILabel!
	@IBOutlet weak var subtitle: UILabel!
	@IBOutlet weak var duration: UILabel!
	@IBOutlet weak var sessionBackground: UIImageView!
	@IBOutlet weak var sessionDetail: UILabel!
	@IBOutlet weak var numPoses: UILabel!
	@IBOutlet weak var bolt1: UIImageView!
	@IBOutlet weak var bolt2: UIImageView!
	@IBOutlet weak var bolt3: UIImageView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
