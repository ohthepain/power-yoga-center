//
//  FirstViewController.swift
//  Yoga
//
//  Created by Paul Wilkinson on 2017-04-09.
//  Copyright © 2017 Paul Wilkinson. All rights reserved.
//

import UIKit

class 	FirstViewController: UIViewController {

	var sessionNum : Int32 = UserPreferences.GetSelectedSessionNum()

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var sessionDurationLabel: UILabel!
	@IBOutlet weak var bolt1: UIImageView!
	@IBOutlet weak var bolt2: UIImageView!
	@IBOutlet weak var bolt3: UIImageView!
	@IBOutlet weak var soundButton: UIButton!
	@IBOutlet weak var detailedCommentaryButton: UIButton!
	
	@IBOutlet weak var startButton: UIButton!

	var paused : Bool;
	var time: Timer!

	required init?(coder aDecoder: NSCoder) {
		self.paused = false;
		super.init(coder: aDecoder)
		//self.view.translatesAutoresizingMaskIntoConstraints = false
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

//        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
//            if ConfigManager.getInstance().ready {
//                timer.invalidate()
//                self.updateControls()
//            }
//        }
    }
    
    private func updateControls() {
		var duration : Int32 = 0
        let numPoses : Int = ConfigManager.getInstance().data.poses!.count
		for n in 0..<numPoses
		{
            let seconds = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(n)].seconds
			duration += seconds
		}
		
        titleLabel.text = ConfigManager.getInstance().data.sessions![Int(sessionNum)].localizedName
        subtitleLabel.text = ConfigManager.getInstance().data.sessions![Int(sessionNum)].subtitle
		let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int(duration))
		sessionDurationLabel.text = String.localizedStringWithFormat("%d:%02d", h*60 + m, s)
		
        let energy = ConfigManager.getInstance().data.sessions![Int(sessionNum)].energyRating
		//bolt2.isHidden = energy < 2;
		//bolt3.isHidden = energy < 3;
		if (energy < 2) {
			bolt2.image = UIImage(named: "icon_lightning_bolt_empty")
		}
		if (energy < 3) {
			bolt3.image = UIImage(named: "icon_lightning_bolt_empty")
		}

		if (!UserPreferences.GetMedicalWarningStatus())
		{
			DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
				let alert = UIAlertController(title: "Power Yoga Center", message: "Always consult your doctor before beginning a new exercise program", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
					switch action.style{
					case .default:
						print("default")
					case .cancel:
						print("cancel")
					case .destructive:
						print("destructive")
					}}))
				self.present(alert, animated: true, completion: nil)
				UserPreferences.SetMedicalWarningStatus(on: true);
			})
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func handleSettingsButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: "Settings Menu")
		self.present(viewController, animated: true, completion: nil)
		//[self presentViewController:controller animated:YES completion:nil];
	}
	
	@IBAction func handleStartButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let poseViewController : PoseViewController = storyboard.instantiateViewController(withIdentifier: "Pose Menu") as! PoseViewController
		self.present(poseViewController, animated: true, completion: nil)
	}

	@IBAction func onTapSessionList(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: "Session List")
		self.present(viewController, animated: true, completion: nil)
	}

}

