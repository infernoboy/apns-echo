//
//  AppDelegate.swift
//  iMac
//
//  Created by Travis Roman on 12/31/17.
//  Copyright © 2017 Toggleable. All rights reserved.
//

import UIKit
import UserNotifications
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
	var window: UIWindow?
	var deviceToken: String?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		//create the notificationCenter
		let center  = UNUserNotificationCenter.current()
		
		center.delegate = self
		// set the type as sound or badge
		center.requestAuthorization(options: [.sound,.alert,.badge]) { (granted, error) in
			// Enable or disable features based on authorization
			
		}
		
		application.registerForRemoteNotifications()

		return true
	}

	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		self.deviceToken = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
		
//		let alert = UIAlertController(title: "Token", message: deviceTokenString, preferredStyle: .alert)
//
//		alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
//		alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: {(action) in
//			UIPasteboard.general.string = deviceTokenString
//		}))
		
//		self.window?.rootViewController?.present(alert, animated: true)
		
		
		
		print("DEVICE TOKEN = \(self.deviceToken!)")
	}
	
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		print(error)
	}
	
	func userNotificationCenter(_ center: UNUserNotificationCenter,  willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (_ options:   UNNotificationPresentationOptions) -> Void) {
		print("Handle push from foreground")
		
		let alert = UIAlertController(title: "Echo", message: notification.request.content.body, preferredStyle: .alert)
		
		alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
	}
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		print("Handle push from background or closed")
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	
}

