//
//  Alert.swift
//  Address Book Swift
//
//  Created by Igor Vilar on 13/06/16.
//  Copyright © 2016 Igor. All rights reserved.
//

import UIKit

class Alert: NSObject {
    
    static func AlertView(titleAlert:String, MessageAlert:String) -> UIAlertController {
        let alert = UIAlertController(title: titleAlert, message: MessageAlert, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        return alert;
    }

}
