//
//  SessionListTableViewCell.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/18/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import UIKit

class SessionListTableViewCell: UITableViewCell {
	
	var sessionNum : Int32 = 0
	
	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var sessionNameLabel: UILabel!
	@IBOutlet weak var subtitle: UILabel!
	@IBOutlet weak var lockImage: UIImageView!
	@IBOutlet weak var durationLabel: UILabel!
	@IBOutlet weak var timesCompletedLabel: UILabel!
	@IBOutlet weak var numPoses: UILabel!
	@IBOutlet weak var bolt1: UIImageView!
	@IBOutlet weak var bolt2: UIImageView!
	@IBOutlet weak var bolt3: UIImageView!
	@IBOutlet weak var comingSoon: UIImageView!
	@IBOutlet weak var backButton: UIButton!
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
