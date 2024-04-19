//
//  SessionListTableViewController.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/15/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import UIKit

class SessionListTableViewController: UITableViewController {

	var poseList:PoseList = PoseList()
	
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
			return 190	//UITableViewAutomaticDimension
		} else {
			return 90
		}
	}
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return poseList.poses.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.row == 0 {
			// Header
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "SessionHeaderTableViewCell", for: indexPath) as? SessionHeaderTableViewCell else {
				fatalError("The dequed cell is not an instance of SessionHeaderTableViewCell")
			}
			cell.sessionBackground.image = UIImage(named: "Cell Backgrounds/Banner_orange.png")
			cell.sessionName.text = "Power Yoga"
			cell.sessionDetail.text = "Get started with Power Yoga! Always consult a doctor before starting a new exercise routine"
			cell.duration.text = "61:00"
			cell.numPoses.text = "42 poses"
			//cell.backButton: UIButton!
			//cell.editButton: UIButton!
			return cell
		}
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "PoseEntryTableViewCell", for: indexPath) as? PoseEntryTableViewCell else {
			fatalError("The dequed cell is not an instance of PoseEntryTableViewCell")
		}

		let pose:Pose = poseList.poses[indexPath.row + 1]
		
		cell.sanskritName.text = pose.sanskritName
		cell.englishName.text = pose.name
		cell.duration.text = String.localizedStringWithFormat("%d", pose.seconds)
		let posePath = String.localizedStringWithFormat("%@", pose.poseFilename)
		let path = posePath.replacingOccurrences(of: "Silhouettes/", with: "Silhouettes-Mini/mini-")
		print("StartPose: pose path is ", path)
		cell.poseImage.image = UIImage(named: path)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
