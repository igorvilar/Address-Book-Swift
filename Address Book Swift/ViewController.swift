//
//  ViewController.swift
//  Address Book Swift
//
//  Created by Igor Vilar on 5/4/16.
//  Copyright © 2016 Igor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var listViewContacts: UITableView!
    let textCellIdentifier = "TextCell"
    var marrContactBook : NSMutableArray!

    var databasePath = NSString()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listViewContacts.delegate = self
        listViewContacts.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        getContactBookData()
    }
    
    
    func getContactBookData()
    {
        marrContactBook = NSMutableArray()
        marrContactBook = MySQLiteHelper.getInstance().getAllAddressBookData()
        listViewContacts.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marrContactBook.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
        let row = indexPath.row
        let contactBook:ContactBook = marrContactBook.objectAtIndex(row) as! ContactBook
        cell.textLabel?.text = contactBook.Name
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
       
    }
   /*
    -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSInteger IdTag = [sender tag];
    DetailsContactViewController *transferViewController = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"OpenDetailsContactSegue"])
    {
    transferViewController.idContactSelect = [[contactsArray objectAtIndex:IdTag] IdContact];
    }
    
    }*/
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "OpenDetailsContactSegue"
        {
                let indexPath = listViewContacts.indexPathForSelectedRow
                let contactBook:ContactBook = marrContactBook.objectAtIndex(indexPath!.row) as! ContactBook
                if let controller = segue.destinationViewController as? DetailsContactViewController {
                   // controller.name = name
                    controller.idContactSelect = contactBook.IdContact
                    controller.nameContactSelect = contactBook.Name
                    controller.addressContactSelect = contactBook.Address
                    controller.phoneContactSelect = contactBook.Phone

                }
            }
        
    }

}

