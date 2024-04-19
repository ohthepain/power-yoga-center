//
//  SecondViewController.swift
//  Yoga
//
//  Created by Paul Wilkinson on 2017-04-09.
//  Copyright © 2017 Paul Wilkinson. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController, AVAudioPlayerDelegate {

	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var poseImage: UIImageView!
	@IBOutlet weak var startButton: UIButton!
	@IBOutlet weak var prevButton: UIButton!
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var timerLabel: UILabel!
	@IBOutlet weak var timerLabel2: UILabel!
	@IBOutlet weak var poseSanskritNameLabel: UILabel!
	@IBOutlet weak var poseEnglishNameLabel: UILabel!
	@IBOutlet weak var matImage: UIImageView!
	@IBOutlet weak var shadowImage: UIImageView!
	@IBOutlet weak var swooshImage: UIImageView!
	
	var lastStartTime:Date!
	var elapsedAtLastPause:Double = 0.0
	var running:Bool = false
	var callbackTimer:Timer!
	var poseList:PoseList = PoseList()
	var currentPoseNum = 0
	var didPlayDetail = false
	var audioPlayer: AVAudioPlayer?

	override func viewDidLoad() {
		backgroundImage.image = UIImage(named: "Art/1_Lotus_Blue.jpg")

		callbackTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true);

		ShowRemainingTime()

		super.viewDidLoad()
	}

	@objc private func update() {
		if (running)
		{
			var currentPoseStartTime = 0
			var nextPoseStartTime = 0
			var n = 0
			for pose in poseList.poses
			{
				nextPoseStartTime += pose.seconds
				if n < currentPoseNum
				{
					currentPoseStartTime += poseList.poses[currentPoseNum].seconds
				}
				else
				{
					break
				}
				n += 1
			}

			let now = Date()
			let timeInterval: Double = now.timeIntervalSince(lastStartTime)
			let totalElapsed = elapsedAtLastPause + timeInterval
			if totalElapsed >= Double(nextPoseStartTime)
			{
				currentPoseNum += 1
				StartPose(posenum: currentPoseNum)
			}

			ShowRemainingTime()
		}
	}
    
	func delay(bySeconds seconds: Double, closure: @escaping () -> Void)
	{
		let dispatchTime = DispatchTime.now() + seconds
		DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: closure)
	}

	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
	{
		print("Sound finished playing")
		if (!didPlayDetail)
		{
			didPlayDetail = true
			delay(bySeconds:2.4) {
				self.PlaySound(soundfile:self.poseList.poses[self.currentPoseNum].detailAudioFilename)
			}
		}
	}

	func PlaySound(soundfile: String)
	{
		print("PlaySound: ", soundfile)
		guard let url = Bundle.main.url(forResource: soundfile, withExtension: "mp3", subdirectory:"Sound") else
		{
			print("error finding sound: ", soundfile)
			return
		}
print("PlaySound: url ", url)
		do {
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
			try AVAudioSession.sharedInstance().setActive(true)

			audioPlayer = try AVAudioPlayer(contentsOf: url)
			guard let audioPlayer = audioPlayer else
			{
				return
			}

			audioPlayer.delegate = self
			audioPlayer.play()
		} catch let error {
			print(error.localizedDescription)
		}
	}

	func StopSound()
	{
		do {
			self.audioPlayer?.stop()
		} catch let error {
			print(error.localizedDescription)
		}
	}

	func SyncToStartOfPose(posenum: Int)
	{
		elapsedAtLastPause = poseList.GetPoseStartTime(posenum: posenum)
		lastStartTime = Date()

		let classLength = poseList.totalDuration
		//print("totalElapsed ", totalElapsed)
		let remaining = Double(classLength) - elapsedAtLastPause
		let minutes = (Int)(remaining / 60.0)
		//print("totalElapsed minutes", minutes)
		let seconds = Int(remaining.truncatingRemainder(dividingBy: 60))
		//print("totalElapsed seconds", seconds)
		let displayString = String.localizedStringWithFormat("%1.0d:%02d", minutes, seconds)
		timerLabel2.text = displayString
	}

	func StartPose(posenum: Int)
	{
		print("StartPose", posenum)
		let pose = poseList.poses[posenum]
		print("StartPose", posenum, pose.poseFilename, pose.backgroundFilename)

		var path = String.localizedStringWithFormat("%@", pose.backgroundFilename)
		print("StartPose: background path is ", path)
		backgroundImage.image = UIImage(named: path)

		path = String.localizedStringWithFormat("%@", pose.matFilename)
		print("StartPose: mat path is ", path)
		matImage.image = UIImage(named: path)

		path = String.localizedStringWithFormat("%@", pose.swooshFilename)
		print("StartPose: swoosh path is ", path)
		swooshImage.image = UIImage(named: path)

		path = String.localizedStringWithFormat("%@", pose.shadowFilename)
		print("StartPose: shadow path is ", path)
		shadowImage.image = UIImage(named: path)
		
		path = String.localizedStringWithFormat("%@", pose.poseFilename)
		print("StartPose: pose path is ", path)
		poseImage.image = UIImage(named: path)
		
		poseEnglishNameLabel.text = pose.name
		poseSanskritNameLabel.text = pose.sanskritName

		didPlayDetail = false
		let shortAudioFilename = pose.shortAudioFilename
		print("shortAudioFilename ", shortAudioFilename)
		if shortAudioFilename != "" {
			delay(bySeconds:0.1) {
				self.PlaySound(soundfile: shortAudioFilename)
			}
		}
	}

	func ShowRemainingTime() {
		let end = Date()
		var totalElapsed = elapsedAtLastPause
		if (running)
		{
			let timeInterval: Double = end.timeIntervalSince(lastStartTime)
			totalElapsed = totalElapsed + timeInterval
		}
		let classLength = poseList.totalDuration
		let remaining = Double(classLength) - totalElapsed
		let minutes = (Int)(remaining / 60.0)
		let seconds = Int(remaining.truncatingRemainder(dividingBy: 60))
		let displayString = String.localizedStringWithFormat("%1.0d:%02d", minutes, seconds)
		timerLabel.text = displayString
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func handleStartButton(_ sender: Any) {
		if (running == false)
		{
			startButton.setTitle("Pause", for: .normal)
			lastStartTime = Date()
			running = true
			if (elapsedAtLastPause == 0)
			{
				StartPose(posenum: 0)
			}
		}
		else
		{
			StopSound()
			startButton.setTitle("Start", for: .normal)
			let end = Date()
			let timeInterval: Double = end.timeIntervalSince(lastStartTime)
			elapsedAtLastPause = elapsedAtLastPause + timeInterval
			//timerLabel.text = String(elapsedAtLastPause)
			running = false
		}
	}

	@IBAction func handleNextButton(_ sender: Any) {
		currentPoseNum += 1
		StartPose(posenum: currentPoseNum)
		SyncToStartOfPose(posenum: currentPoseNum)
		StopSound()
	}

	@IBAction func handlePrevButton(_ sender: Any) {
		if (currentPoseNum > 0)
		{
			currentPoseNum -= 1
		}
		StartPose(posenum: currentPoseNum)
		SyncToStartOfPose(posenum: currentPoseNum)
		StopSound()
	}
}

