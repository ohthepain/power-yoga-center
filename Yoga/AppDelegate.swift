//
//  AppDelegate.swift
//  Yoga
//
//  Created by Paul Wilkinson on 2017-04-09.
//  Copyright © 2017 Paul Wilkinson. All rights reserved.
//

import UIKit

extension UIApplication {
	class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
		if let nav = base as? UINavigationController {
			return topViewController(base: nav.visibleViewController)
		}
		if let tab = base as? UITabBarController {
			if let selected = tab.selectedViewController {
				return topViewController(base: selected)
			}
		}
		if let presented = base?.presentedViewController {
			return topViewController(base: presented)
		}
		return base
	}
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		UIApplication.shared.isIdleTimerDisabled = true
		// Override point for customization after application launch.
//		var config : Config = Config()
//		config.initConfig();
		
		ConfigInit()
		
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		let viewController : UIViewController = UIApplication.topViewController()!
		if let poseViewController : PoseViewController = viewController as? PoseViewController {
			poseViewController.AppResignsActive()
		}
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		let viewController : UIViewController = UIApplication.topViewController()!
		if let poseViewController : PoseViewController = viewController as? PoseViewController {
			poseViewController.AppResumes()
		}
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		
		ConfigShutdown()
	}


}

