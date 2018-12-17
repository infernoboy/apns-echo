//
//  ViewController.swift
//  APNS Echo
//
//  Created by Travis Roman on 12/12/18.
//  Copyright © 2018 Toggleable. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
	@IBOutlet var collapseID: UITextField!
	@IBOutlet var message: UITextField!
	@IBOutlet var pushBack: UIButton!
	
	let actionURL:String = "https://surveillance.toggleable.com:8443/node/alarm/pushBack"
	
	var alert:UIAlertController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	@IBAction func performPushBack(_ sender: AnyObject) -> Void {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		
		let params:Parameters = [
			"deviceToken": appDelegate.deviceToken!,
			"collapseID": self.collapseID.text!,
			"message": self.message.text!
		]
		
		Alamofire.request(actionURL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { res in
			switch res.result {
			case .failure(let error):
				let message:String
				
				switch res.response?.statusCode {
				case 429:
					message = "You're doing that too much."
				default:
					message = error.localizedDescription
				}
				
				self.alert = UIAlertController(title: "Failed", message: message, preferredStyle: .alert)
				
			case .success(let json):
				let result = json as! NSDictionary
				
				if let error = result["error"] {
					self.alert = UIAlertController(title: "Failed", message: error as? String, preferredStyle: .alert)
				}
				
				if let actionType = result["type"] {
					switch actionType as? String {
					case "PushBack":
						self.alert = UIAlertController(title: "Success", message: "Please exit the app within 10 seconds so the notification will be handled correctly in the background.", preferredStyle: .alert)
					default:
						self.alert = UIAlertController(title: "Unknown", message: actionType as? String, preferredStyle: .alert)
					}
				}
			}
			
			self.alert!.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
			
			self.present(self.alert!, animated: true, completion: nil)
		})
	}
	
	
}

