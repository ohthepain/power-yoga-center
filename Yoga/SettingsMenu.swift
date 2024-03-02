//
//  SettingsMenu.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/23/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import UIKit

class SettingsMenu : UIViewController
{
	@IBOutlet weak var soundButton: UIButton!
	@IBOutlet weak var commentaryButton: UIButton!
	var callbackFunction : ()->Void = {}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		UpdateButtons()
	}
	
	func setCallback(closure : @escaping ()->Void) {
		callbackFunction = closure
	}
	
	@IBAction func handleBackButton(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
		callbackFunction()
 	}
	
	@IBAction func handleSoundButton(_ sender: Any) {
		let on : Bool = UserPreferences.IsSoundOn()
		UserPreferences.SetSoundOn(on: !on)
		UpdateButtons()
	}
	
	@IBAction func handleCommentaryButton(_ sender: Any) {
		let on : Bool = UserPreferences.IsDetailedCommentaryOn()
		UserPreferences.SetDetailedCommentaryOn(on: !on)
		UpdateButtons()
	}
	
	@IBAction func handleResetAlertsButton(_ sender: Any) {
		UserPreferences.SetMedicalWarningStatus(on: false)
	}
	
	@IBAction func handleRestorePurchasesButton(_ sender: Any) {
		let alert = UIAlertController(title: "", message: "Purchases are not yet available, but please come back soon!", preferredStyle: .alert)
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
	}
	
	func UpdateButtons() {
		if UserPreferences.IsSoundOn() {
			soundButton.setImage(UIImage(named: "Button_sound_on"), for: .normal)
		}
		else {
			soundButton.setImage(UIImage(named:"Button_sound_off"), for: .normal)
		}
		
		if UserPreferences.IsDetailedCommentaryOn() {
			commentaryButton.setImage(UIImage(named: "Button_special_commentary_on"), for: .normal)
		}
		else {
			commentaryButton.setImage(UIImage(named:"Button_special_commentary_off"), for: .normal)
		}
	}

}
