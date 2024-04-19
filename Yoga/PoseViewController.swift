//
//  PoseViewController.swift
//  Yoga
//
//  Created by Paul Wilkinson on 2017-04-09.
//  Copyright © 2017 Paul Wilkinson. All rights reserved.
//

import UIKit
import AVFoundation

class PoseViewController: UIViewController, AVAudioPlayerDelegate {
	
	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var poseImage: UIImageView!
	@IBOutlet weak var startButton: UIButton!
	@IBOutlet weak var prevButton: UIButton!
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var timerLabel: UILabel!
	@IBOutlet weak var poseSanskritNameLabel: UILabel!
	@IBOutlet weak var poseEnglishNameLabel: UILabel!
	@IBOutlet weak var matImage: UIImageView!
	@IBOutlet weak var shadowImage: UIImageView!
	@IBOutlet weak var swooshImage: UIImageView!
	@IBOutlet weak var exitButton: UIButton!
	@IBOutlet weak var settingsButton: UIButton!
	
	var lastStartTime:Date! = Date()
	var elapsedAtLastPause:Double = 0.0
	let sessionNum = UserPreferences.GetSelectedSessionNum()
	var sessionLength = 0.0
	var running:Bool = false
	var callbackTimer:Timer!
	var currentPoseNum : Int32 = 0
	var startedPoseNum : Int32 = -1
	var didPlayDetail = false
	var audioPlayer: AVAudioPlayer?
	var detailedAudioTask : DispatchWorkItem?
	var pausedOnAppResignsActive : Bool = false
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		sessionLength = GetSessionLength(sessionNum: UserPreferences.GetSelectedSessionNum())
		
		callbackTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true);
		
		ShowRemainingTime()
		SyncToStartOfPose(poseNum: 0)
		Resume()
		elapsedAtLastPause = 0
		startedPoseNum = -1
	}

	func AppResignsActive() {
		if running {
			pausedOnAppResignsActive = true
			Pause()
		}
	}
	
	func AppResumes() {
		if pausedOnAppResignsActive {
			pausedOnAppResignsActive = false
			Resume()
		}
	}
	
	@objc private func update() {
		if (running)
		{
            let seconds = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(currentPoseNum)].seconds
			let poseEndTime = GetPoseStartTime(poseNum: currentPoseNum) + Double(seconds)
			let now = Date()
			let timeInterval: Double = now.timeIntervalSince(lastStartTime)
			let totalElapsed = elapsedAtLastPause + timeInterval
			if totalElapsed >= poseEndTime
			{
				currentPoseNum += 1
				StartPose(poseNum: currentPoseNum)
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
		scheduleDetailedCommentary()
	}
	
	func scheduleDetailedCommentary()
	{
		if (!didPlayDetail && UserPreferences.IsDetailedCommentaryOn())
		{
			detailedAudioTask?.cancel()
			detailedAudioTask = DispatchWorkItem {
                let detailAudioFilename = ConfigManager.getInstance().data.sessions![Int(UserPreferences.GetSelectedSessionNum())].poses![Int(self.currentPoseNum)].detailAudioFilename
				if self.running && detailAudioFilename != "" {
					self.PlaySound(soundfile: detailAudioFilename)
					self.didPlayDetail = true
				}
			}
			DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.4, execute: detailedAudioTask!)
		}
		else
		{
			self.audioPlayer?.stop()
			do {
				// This is to unduck others, make other playing sounds go back up in volume
				try AVAudioSession.sharedInstance().setActive(false)
			} catch {
			}
		}
	}
	
	func PlaySound(soundfile: String)
	{
		if UserPreferences.IsSoundOn()
		{
			print("PlaySound: ", soundfile)
			guard let url = Bundle.main.url(forResource: soundfile, withExtension: "mp3", subdirectory:"Sound") else
			{
				print("error finding sound: ", soundfile)
				return
			}
			print("PlaySound: url ", url)
			do {
				let audioSession = AVAudioSession.sharedInstance()
                try!audioSession.setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.duckOthers)

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
	}
	
	func StopSound()
	{
		self.audioPlayer?.stop()
	}
	
	func SyncToStartOfPose(poseNum: Int32)
	{
		currentPoseNum = poseNum
		elapsedAtLastPause = GetPoseStartTime(poseNum: poseNum)
		lastStartTime = Date()
		
        let numPoses = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses!.count
		if poseNum >= numPoses
		{
			currentPoseNum = 0
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let viewController = storyboard.instantiateViewController(withIdentifier: "Main Menu")
			self.present(viewController, animated: true, completion: nil)
			StopSound()
			return;
		}
        
        let sanskritName = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].sanskritName
        let englishName = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].englishName
        let poseFilename = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].poseFilename
        let seconds = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].seconds
        let flipped = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].flipped!
        let backgroundFilename = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].backgroundFilename
        let matFilename = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].matFilename
        let swooshFilename = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].swooshFilename
        let shadowFilename = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].shadowFilename
        
		poseEnglishNameLabel.text = sanskritName
		poseSanskritNameLabel.text = englishName
		backgroundImage.image = UIImage(named: backgroundFilename)
		matImage.image = UIImage(named: matFilename)
		swooshImage.image = UIImage(named: swooshFilename)
		shadowImage.image = UIImage(named: shadowFilename)
		
		if flipped {
			poseImage.image = UIImage(named: String(cString: poseFilename))!.withHorizontallyFlippedOrientation()
		} else {
			poseImage.image = UIImage(named: String(cString: poseFilename))
		}
		
		let remaining = sessionLength - GetPoseStartTime(poseNum: poseNum)
		let minutes = (Int)(remaining / 60.0)
		//print("totalElapsed minutes", minutes)
		//print("totalElapsed seconds", seconds)
		let displayString = String.localizedStringWithFormat("%1.0d:%02d", minutes, seconds)
		timerLabel.text = displayString
	}
	
	func StartPose(poseNum: Int32)
	{
		SyncToStartOfPose(poseNum: poseNum)

		didPlayDetail = false
		if running {
			let sessionNum = UserPreferences.GetSelectedSessionNum()
			let shortAudioFilename = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].shortAudioFilename
			if shortAudioFilename != ""
			{
				detailedAudioTask?.cancel()
				detailedAudioTask = DispatchWorkItem {
					if self.running {
						self.PlaySound(soundfile: shortAudioFilename)
					}
				}
				DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: detailedAudioTask!)
			}
			
			startedPoseNum = currentPoseNum
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
		let classLength = GetSessionLength(sessionNum: sessionNum)
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
			Resume()
		}
		else
		{
			Pause()
		}
	}
	
	func Resume() {
		startButton.setImage(UIImage(named: "Button_pause"), for: .normal)
		exitButton.isEnabled = false
		lastStartTime = Date()
		running = true
		if (startedPoseNum != currentPoseNum)
		{
			StartPose(poseNum: currentPoseNum)
		}
		else
		{
			scheduleDetailedCommentary()
		}
	}
	
	func Pause() {
		startButton.setImage(UIImage(named: "Button_play"), for: .normal)
		exitButton.isEnabled = true
		StopSound()
		let end = Date()
		let timeInterval: Double = end.timeIntervalSince(lastStartTime)
		elapsedAtLastPause = elapsedAtLastPause + timeInterval
		running = false
	}
	
	@IBAction func handleNextButton(_ sender: Any) {
		StopSound()
		StartPose(poseNum: currentPoseNum + 1)
	}
	
	@IBAction func handlePrevButton(_ sender: Any) {
		StopSound()
		if (currentPoseNum > 0)
		{
			currentPoseNum -= 1
		}
		StartPose(poseNum: currentPoseNum)
	}
	
	@IBAction func handleExitButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: "Main Menu")
		self.present(viewController, animated: true, completion: nil)
	}

	@IBAction func handleSettingsButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: "Settings Menu") as! SettingsMenu
		if running {
			viewController.callbackFunction = { self.Resume() }
		}
		Pause()
		self.present(viewController, animated: true, completion: nil)
	}
}

