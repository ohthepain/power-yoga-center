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
		ConfigInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		print("init coder style")
		super.init(coder: aDecoder)
		ConfigInit()
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
		let n = GetSessionNumPoses(sessionNum)
		return Int(n + 1)
    }
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.row == 0 {
			// Header
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "SessionDetailHeaderTableViewCell", for: indexPath) as? SessionDetailHeaderTableViewCell else {
				fatalError("The dequed cell is not an instance of SessionDetailHeaderTableViewCell")
			}
			
			cell.sessionBackground.image = UIImage(named: String(cString: GetSessionCardImage(sessionNum)))
			cell.sessionName.text = String(cString: GetSessionLocalizedName(sessionNum))
			cell.subtitle.text = String(cString: GetSessionSubtitle(sessionNum))
			cell.sessionDetail.text = "Get started with Power Yoga! Always consult a doctor before starting a new exercise routine"
			cell.sessionDetail.sizeToFit()
			let classLength = 50 * 60
			let (h,m,s) = secondsToHoursMinutesSeconds(seconds: classLength)
			cell.duration.text = String.localizedStringWithFormat("%d:%02d", h*60 + m, s)
			cell.numPoses.text = String(format: "%d poses", GetSessionNumPoses(sessionNum))
			
			let energy = GetSessionEnergyRating(sessionNum)
			//cell.bolt2.isHidden = energy < 2;
			//cell.bolt3.isHidden = energy < 3;
			if (energy < 2) {
				cell.bolt2.image = UIImage(named: "icon_lightning_bolt_empty")
			}
			if (energy < 3) {
				cell.bolt3.image = UIImage(named: "icon_lightning_bolt_empty")
			}
			return cell
		}
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "PoseEntryTableViewCell", for: indexPath) as? PoseEntryTableViewCell else {
			fatalError("The dequed cell is not an instance of PoseEntryTableViewCell")
		}

		let poseNum : Int32 = Int32(indexPath.row - 1)
		cell.sanskritName.text = String(cString: GetSessionPoseSanskritName(sessionNum, poseNum))
		cell.englishName.text = String(cString: GetSessionPoseEnglishName(sessionNum, poseNum))
		//cell.duration.text = String.localizedStringWithFormat("%d", pose.seconds)
		let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int(GetSessionPoseSeconds(sessionNum, poseNum)))
		cell.duration.text = String.localizedStringWithFormat("%d:%02d", h*60 + m, s)
		let flip : Bool = GetSessionPoseFlipped(sessionNum, poseNum)
		if flip {
			cell.poseImage.image = UIImage(named: String(format: "mini-%s", arguments: [ GetSessionPosePoseFilename(sessionNum, poseNum) ]))?.withHorizontallyFlippedOrientation()
		} else {
			cell.poseImage.image = UIImage(named: String(format: "mini-%s", arguments: [ GetSessionPosePoseFilename(sessionNum, poseNum) ]))
		}

        return cell
    }
}
