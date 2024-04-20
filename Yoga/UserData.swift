//
//  UserData.swift
//  Yoga
//
//  Created by Paul Wilkinson on 1/21/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

import Foundation

class UserPreferences
{
	static func IsSoundOn() -> Bool
	{
		let defaults = UserDefaults.standard
		let soundon = defaults.string(forKey: "opt:sound")
		return soundon == nil || soundon == ""
	}

	static func SetSoundOn(on : Bool)
	{
		var s : String = ""
		if !on {
			s = "off"
		}
		let defaults = UserDefaults.standard
		defaults.set(s, forKey: "opt:sound")
	}

	static func IsDetailedCommentaryOn() -> Bool
	{
		let defaults = UserDefaults.standard
		let soundon = defaults.string(forKey: "opt:detail")
		return soundon == nil || soundon == ""
	}
	
	static func SetDetailedCommentaryOn(on : Bool)
	{
		var s : String = ""
		if !on {
			s = "off"
		}
		let defaults = UserDefaults.standard
		defaults.set(s, forKey: "opt:detail")
	}
	
	static func SetMedicalWarningStatus(on : Bool)
	{
		var s : String = ""
		if on {
			s = "on"
		}
		let defaults = UserDefaults.standard
		defaults.set(s, forKey: "medwarn")
	}
	
	static func GetMedicalWarningStatus() -> Bool {
		let defaults = UserDefaults.standard
		let soundon = defaults.string(forKey: "medwarn")
		return soundon == "on"
	}

	static func GetSelectedSessionNum() -> Int32 {
		let defaults = UserDefaults.standard
		let optionalString: String? = defaults.string(forKey: "selectedSessionNum")
		// this works but it's too complicated
		if let string = optionalString, let myInt = Int32(string) {
			return myInt
		}
		return 0
	}
	
	static func SetSelectedSessionNum(n : Int32) {
		let nString : String = String(n)
		let defaults = UserDefaults.standard
		defaults.set(nString, forKey: "selectedSessionNum")
	}

	static func SetSessionPercentComplete(sessionNum : Int, completeness : Double) throws {
        let sessionId : String = ConfigManager.getInstance().data.sessions![sessionNum].sessionId
		let key = String(format: "completeness_%s", sessionId)
		let val = String(completeness)
		UserDefaults.standard.set(val, forKey: key)
	}
	
	static func GetSessionPercentComplete(sessionNum : Int) throws -> Double {
        let sessionId : String = ConfigManager.getInstance().data.sessions![sessionNum].sessionId
        let key = "completeness_\(sessionId)"
		if let sval = UserDefaults.standard.string(forKey: key) {
			if let dval = Double(sval) {
				return dval
			}
		}
		return 0.0
	}
}

