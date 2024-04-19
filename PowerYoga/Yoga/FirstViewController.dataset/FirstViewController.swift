//
//  FirstViewController.swift
//  Yoga
//
//  Created by Paul Wilkinson on 2017-04-09.
//  Copyright © 2017 Paul Wilkinson. All rights reserved.
//

import UIKit

class 	FirstViewController: UIViewController {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var backgroundImage: UIImageView!

	@IBOutlet weak var startButton: UIButton!
	@IBOutlet weak var prevButton: UIButton!
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var exitButton: UIButton!

	var paused : Bool;
	var time: Timer!

	required init?(coder aDecoder: NSCoder) {
		self.paused = false;
		super.init(coder: aDecoder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		backgroundImage.image = UIImage(named: "Art/Splashpage.jpg")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func handleStartButton(_ sender: Any) {
		let secondViewController:SecondViewController = SecondViewController()
		self.present(secondViewController, animated: true, completion: nil)
	}
	@IBAction func handlePrevButton(_ sender: Any) {
	}
	@IBAction func handleNextButton(_ sender: Any) {
	}
	@IBAction func handleExitButton(_ sender: Any) {
	}
	
	@IBAction func buttonTapped(_ sender: UIButton) {
		if sender.title(for: .normal) == "X" {
			sender.setTitle("A very long title for this button", for: .normal)
		} else {
			sender.setTitle("X", for: .normal)
		}
	}  
}

