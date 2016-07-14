//
//  DetailsContactViewController.swift
//  Address Book Swift
//
//  Created by Igor Vilar on 13/06/16.
//  Copyright © 2016 Igor. All rights reserved.
//

import UIKit


class DetailsContactViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var idContactSelect: String!
    var nameContactSelect: String!
    var addressContactSelect: String!
    var phoneContactSelect: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = nameContactSelect
        addressLabel.text = addressContactSelect
        phoneLabel.text = phoneContactSelect

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func EditButton(sender: AnyObject) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
