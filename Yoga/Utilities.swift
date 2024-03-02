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
		startTime += Double(GetSessionPoseSeconds(sessionNum, n))
	}
	return startTime
}

func GetPoseEndTime(poseNum : Int32) -> Double
{
	let sessionNum = UserPreferences.GetSelectedSessionNum()
	return GetPoseStartTime(poseNum: poseNum) + Double(GetSessionPoseSeconds(sessionNum, poseNum))
}

func GetSessionLength(sessionNum : Int32) -> Double
{
	let numPoses = GetSessionNumPoses(sessionNum)
	if numPoses == 0 {
		return 0.0
	}
	return GetPoseEndTime(poseNum: numPoses-1)
}
