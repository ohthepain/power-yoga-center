//
//  SessionDetailTableViewController.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/15/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import UIKit

class SessionDetailTableViewController: UITableViewController {

	var sessionNum : Int32 = 0
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
		print("init nibName style")
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//		ConfigInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		print("init coder style")
		super.init(coder: aDecoder)
//		ConfigInit()
	}
	
	@IBAction func onBackButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: "Session List")
		self.present(viewController, animated: true, completion: nil)
	}
	
	@IBAction func onSelectButton(_ sender: Any) {
		UserPreferences.SetSelectedSessionNum(n: sessionNum)
		assert(UserPreferences.GetSelectedSessionNum() == sessionNum)
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: "Pose Menu")
		self.present(viewController, animated: true, completion: nil)
	}

	override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
	
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return 174	//UITableViewAutomaticDimension
		} else {
			return 90
		}
	}
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numPoses : Int = 0
        if ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses != nil {
            numPoses = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses!.count
        }
		return Int(numPoses + 1)
    }
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.row == 0 {
			// Header
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "SessionDetailHeaderTableViewCell", for: indexPath) as? SessionDetailHeaderTableViewCell else {
				fatalError("The dequed cell is not an instance of SessionDetailHeaderTableViewCell")
			}
		
            let cardImage = ConfigManager.getInstance().data.sessions![Int(sessionNum)].cardImage
			cell.sessionBackground.image = UIImage(named: cardImage)
            let localizedName = ConfigManager.getInstance().data.sessions![Int(sessionNum)].localizedName
            cell.sessionName.text = localizedName
            let subtitle = ConfigManager.getInstance().data.sessions![Int(sessionNum)].subtitle
            cell.subtitle.text = subtitle
			cell.sessionDetail.text = "Get started with Power Yoga! Always consult a doctor before starting a new exercise routine"
			cell.sessionDetail.sizeToFit()
			let classLength = 50 * 60
			let (h,m,s) = secondsToHoursMinutesSeconds(seconds: classLength)
			cell.duration.text = String.localizedStringWithFormat("%d:%02d", h*60 + m, s)
            let numPoses = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses!.count
			cell.numPoses.text = String(format: "%d poses", numPoses)

            let energyRating = ConfigManager.getInstance().data.sessions![Int(sessionNum)].energyRating
			//cell.bolt2.isHidden = energy < 2;
			//cell.bolt3.isHidden = energy < 3;
			if (energyRating < 2) {
				cell.bolt2.image = UIImage(named: "icon_lightning_bolt_empty")
			}
			if (energyRating < 3) {
				cell.bolt3.image = UIImage(named: "icon_lightning_bolt_empty")
			}
			return cell
		}
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "PoseEntryTableViewCell", for: indexPath) as? PoseEntryTableViewCell else {
			fatalError("The dequed cell is not an instance of PoseEntryTableViewCell")
		}

		let poseNum : Int32 = Int32(indexPath.row - 1)
        let sanskritName = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].sanskritName
        let englishName = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].englishName
        let poseFilename = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].poseFilename
        let seconds = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].seconds
        let poses = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses
        let flipped = poses != nil && poses![Int(poseNum)].flipped != nil && poses![Int(poseNum)].flipped!
		cell.sanskritName.text = sanskritName
		cell.englishName.text = englishName
		//cell.duration.text = String.localizedStringWithFormat("%d", pose.seconds)
		let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int(seconds))
		cell.duration.text = String.localizedStringWithFormat("%d:%02d", h*60 + m, s)
        //    return mData->sessions[sessionNum].poses[poseNum].flipped;
		if flipped {
            cell.poseImage.image = UIImage(named: "mini-\(poseFilename)")?.withHorizontallyFlippedOrientation()
		} else {
            cell.poseImage.image = UIImage(named: "mini-\(poseFilename)")
		}

        return cell
    }
}
