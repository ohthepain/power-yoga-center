//
//  PoseEntryTableViewCell.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/15/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import UIKit

class PoseEntryTableViewCell: UITableViewCell {
	
	@IBOutlet weak var poseImage: UIImageView!
	@IBOutlet weak var sanskritName: UILabel!
	@IBOutlet weak var englishName: UILabel!
	@IBOutlet weak var duration: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
