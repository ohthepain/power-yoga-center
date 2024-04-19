//
//  Utilities.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/21/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import Foundation

func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
	return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

func GetPoseStartTime(poseNum : Int32) -> Double
{
	let sessionNum = UserPreferences.GetSelectedSessionNum()
	var startTime : Double = 0.0
	for n in 0..<poseNum {
        let seconds = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(n)].seconds
		startTime += Double(seconds)
	}
	return startTime
}

func GetPoseEndTime(poseNum : Int32) -> Double
{
	let sessionNum = UserPreferences.GetSelectedSessionNum()
    let seconds = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses![Int(poseNum)].seconds
	return GetPoseStartTime(poseNum: poseNum) + Double(seconds)
}

func GetSessionLength(sessionNum : Int32) -> Double
{
    let numPoses = ConfigManager.getInstance().data.sessions![Int(sessionNum)].poses!.count
	if numPoses == 0 {
		return 0.0
	}
	return GetPoseEndTime(poseNum: Int32(numPoses-1))
}
