//
//  SessionListTableViewController.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/18/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import UIKit

class SessionListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
//		tableView.register(SessionListTableViewCell.self)
//		tableView.register(SessionListTableViewCell.self, forCellWithReuseIdentifier: "SessionListTableViewCell")
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
		tableView.separatorColor = UIColor.clear;
        return 1
    }
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let number1: Int32 = GetNumSessions()
		return Int(number1)
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "SessionListTableViewCell", for: indexPath) as? SessionListTableViewCell else {
			fatalError("The dequed cell is not an instance of SessionListTableViewCell")
		}
		
		let n = Int32(indexPath.row)
		
		cell.backButton.isHidden = n != UserPreferences.GetSelectedSessionNum()
		cell.sessionNum = n
		cell.backgroundImage.image = UIImage(named: String(cString: GetSessionBackgroundImage(n)))
		cell.sessionNameLabel.text = String(cString: GetSessionLocalizedName(n))
		cell.subtitle.text = String(cString: GetSessionSubtitle(n))
		cell.lockImage.isHidden = true
		cell.comingSoon.isHidden = !GetSessionComingSoon(n)
		cell.durationLabel.text = "30 min"
		var percentComplete = 0.0
		do {
			try percentComplete = UserPreferences.GetSessionPercentComplete(sessionNum: n)
		} catch {
			print(error)
		}
		percentComplete = 0
		var completenessString = String(format: "%2d%% Complete", arguments: [ Int(percentComplete) ])
		if (percentComplete >= 200.0) {
			completenessString = String(format: "Completed %d times", arguments: [ Int(percentComplete/100) ])
		} else if (percentComplete >= 100.0) {
			completenessString = String(format: "Completed once", arguments: [ Int(percentComplete/100) ])
		}
		cell.timesCompletedLabel.text = completenessString
		cell.timesCompletedLabel.isHidden = percentComplete == 0.0;
		let energy = GetSessionEnergyRating(n)
		//cell.bolt2.isHidden = energy < 2;
		//cell.bolt3.isHidden = energy < 3;
		if (energy < 2) {
			cell.bolt2.image = UIImage(named: "icon_lightning_bolt_empty")
		}
		if (energy < 3) {
			cell.bolt3.image = UIImage(named: "icon_lightning_bolt_empty")
		}

		cell.numPoses.text = String(format: "%d poses", GetSessionNumPoses(n))
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if !GetSessionComingSoon(Int32(indexPath.row)) {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let sessionDetailViewController = storyboard.instantiateViewController(withIdentifier: "Session Detail") as! SessionDetailTableViewController
			sessionDetailViewController.sessionNum = Int32(indexPath.row)
			self.present(sessionDetailViewController, animated: true, completion: nil)
		}
		tableView.deselectRow(at: indexPath, animated: false)
	}
	
	@IBAction func handleBackButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: "Main Menu")
		self.present(viewController, animated: true, completion: nil)
	}
}
