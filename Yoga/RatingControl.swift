//
//  RatingControl.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/15/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {
	
	private var ratingButtons = [UIButton]()
	
	@IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
		didSet { setupButtons() }
	}
	@IBInspectable var starCount: Int = 3 {
		didSet { setupButtons() }
	}
	
	@IBInspectable var rating = 3 {
		didSet { setupButtons() }
	}
	
	// Init from code
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupButtons()
	}
	
	// Init from storyboard
	required init(coder: NSCoder) {
		super.init(coder: coder)
		setupButtons()
	}
	
	private func setupButtons() {
		
		let bundle = Bundle(for: type(of: self))
		let filledStar = UIImage(named: "Icon_lightning_bolt", in: bundle, compatibleWith: self.traitCollection)
		let emptyStar = UIImage(named: "icon_lightning_bolt_empty", in: bundle, compatibleWith: self.traitCollection)

		for button in ratingButtons {
			removeArrangedSubview(button)
			button.removeFromSuperview()
		}
		ratingButtons.removeAll()
		
		for n in 0..<starCount {
			let button = UIButton()
			button.setImage(filledStar, for: .normal)
			button.setImage(emptyStar, for: .disabled)

			button.isEnabled = n < rating - 1
			
			// Add constraints
			//button.translatesAutoresizingMaskIntoConstraints = false
			//button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
			//button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
			
			button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
			
			addArrangedSubview(button)
			
			ratingButtons.append(button)
		}
	}
	
    @objc func ratingButtonTapped(button: UIButton) {
		print("Tapped rating button 👍")
	}
}
