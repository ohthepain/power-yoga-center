//
//  RatingControl.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/15/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {

	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	private func setupButtons() {
		let button = UIButton()
		button.backgroundColor = UIColor.red
		button.translatesAutoresizingMaskIntoConstraints = false
		button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
		button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true

	}
	
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
