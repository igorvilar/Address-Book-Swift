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
    var idContactSelect: Int32!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        getContactBookData()
    }
    
    func getContactBookData()
    {
    var contactBook : ContactBook = ContactBook()
        contactBook = MySQLiteHelper.getInstance().retrieveSelectContact(Int(idContactSelect!))
        nameLabel.text = contactBook.Name
        phoneLabel.text = contactBook.Phone
        addressLabel.text = contactBook.Address
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
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "OpenEditContactSegue"
        {
            if let controller = segue.destinationViewController as? EditViewController {
                controller.idContactSelect = idContactSelect
                
            }
        }
        
    }


}
