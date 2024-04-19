//
//  SessionListTableViewController.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/18/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import UIKit

class SessionListTableViewController: UITableViewController {
    
    private var data: ConfigData?

    override func viewDidLoad() {
        super.viewDidLoad()
        data = ConfigManager.getInstance().data
		
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
        let n: Int = ConfigManager.getInstance().data.sessions!.count
		return n
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "SessionListTableViewCell", for: indexPath) as? SessionListTableViewCell else {
			fatalError("The dequed cell is not an instance of SessionListTableViewCell")
		}
		
		let n = Int(indexPath.row)
        
        let data = self.data!
        let backgroundImage = data.sessions![n].backgroundImage
        let localizedName = data.sessions![n].localizedName
        let subtitle = data.sessions![n].subtitle
        let comingSoon = data.sessions![n].comingSoon
        let energyRating = data.sessions![n].energyRating
        let numPoses = data.sessions![n].poses!.count
		
		cell.backButton.isHidden = n != UserPreferences.GetSelectedSessionNum()
		cell.sessionNum = Int32(n)
		cell.backgroundImage.image = UIImage(named: backgroundImage)
		cell.sessionNameLabel.text = localizedName
		cell.subtitle.text = subtitle
		cell.lockImage.isHidden = true
		cell.comingSoon.isHidden = !comingSoon!
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
		//cell.bolt2.isHidden = energy < 2;
		//cell.bolt3.isHidden = energy < 3;
		if (energyRating < 2) {
			cell.bolt2.image = UIImage(named: "icon_lightning_bolt_empty")
		}
		if (energyRating < 3) {
			cell.bolt3.image = UIImage(named: "icon_lightning_bolt_empty")
		}

		cell.numPoses.text = String(format: "%d poses", numPoses)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comingSoon = data!.sessions![indexPath.row].comingSoon!
		if !comingSoon {
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
