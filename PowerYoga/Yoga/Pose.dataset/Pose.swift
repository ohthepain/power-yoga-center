//
//  Pose.swift
//  Yoga
//
//  Created by Paul Wilkinson on 2017-05-21.
//  Copyright © 2017 Paul Wilkinson. All rights reserved.
//

import Foundation

class Pose
{
	var name:String = ""
	var sanskritName:String = ""
	var seconds:Int = 30
	var poseFilename:String = ""
	var backgroundFilename:String = ""
	var matFilename:String = ""
	var swooshFilename:String = ""
	var shadowFilename:String = ""
	var shortAudioFilename:String = ""
	var detailAudioFilename:String = ""

	init(name:String, sanskritName:String, seconds:Int, poseFilename:String, backgroundFilename:String, matFilename:String, swooshFilename:String, shadowFilename:String, shortAudioFilename:String, detailAudioFilename:String)
	{
		self.name = name
		self.sanskritName = sanskritName
		self.seconds = seconds
		self.poseFilename = poseFilename
		self.backgroundFilename = backgroundFilename
		self.matFilename = matFilename
		self.swooshFilename = swooshFilename
		self.shadowFilename = shadowFilename
		self.shortAudioFilename = shortAudioFilename
		self.detailAudioFilename = detailAudioFilename
		
		print("Pose: background filename is ", self.backgroundFilename)
		print("Pose: pose filename is ", self.poseFilename)
		print("Pose: mat filename is ", self.matFilename)
		print("Pose: swoosh filename is ", self.swooshFilename)
		print("Pose: shadow filename is ", self.shadowFilename)
	}
}

class PoseList
{
	var poses = [Pose]()
	var totalDuration = 0

	init()
	{
		if let filepath = Bundle.main.path(forResource: "poselist", ofType: "txt") {
			print(filepath)
			do {
				let contents = try String(contentsOfFile: filepath)
				let lineArray = contents.components(separatedBy: "\n")
				//print(contents)
				for line in lineArray
				{
					print(line)
					let stringArray = line.components(separatedBy: ",")
					if (stringArray.count >= 4)
					{
						//Lotus,120,1.jpg,BgBlue.jpg,1_Lotus_Blue.jpg,1_Sage_Intro,1_Sage_Detail,,,,0:02:00,1:00:00

						let secondsString = stringArray[2]
						var seconds = 0
						if (secondsString.lengthOfBytes(using: .ascii) > 0)
						{
							seconds = Int(secondsString)!
							let name = stringArray[0]
							let sanskritName = stringArray[1]
							let poseFilename = stringArray[4]
							let backgroundFilename = stringArray[5]
							let matFilename = stringArray[6]
							let swooshFilename = stringArray[7]
							let shadowFilename = stringArray[8]
							let shortAudioFilename = stringArray[9]
							let detailAudioFilename = stringArray[10]
							let pose = Pose(name: name, sanskritName: sanskritName, seconds: seconds, poseFilename: poseFilename, backgroundFilename: backgroundFilename, matFilename: matFilename, swooshFilename: swooshFilename, shadowFilename: shadowFilename, shortAudioFilename: shortAudioFilename, detailAudioFilename: detailAudioFilename)
							poses.append(pose)

							totalDuration = totalDuration + seconds

							print("pose ", poses.count - 1, " ", name, " starts at ", GetPoseStartTime(posenum: poses.count - 1))
						}
					}
				}
			} catch {
				// contents could not be loaded
			}
		} else {
			// example.txt not found!
		}
	}

	func GetPoseStartTime(posenum: Int) -> Double
	{
		var posetime : Double = 0
		for i in 0..<posenum
		{
			let pose = poses[i]
			let poseduration = pose.seconds
			posetime += Double(poseduration)
		}
		return posetime
	}
}
