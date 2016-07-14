//
//  EditViewController.swift
//  Address Book Swift
//
//  Created by Igor Vilar on 13/06/16.
//  Copyright © 2016 Igor. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var saveContact: UIBarButtonItem!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var addressInput: UITextField!
    @IBOutlet weak var phoneInput: UITextField!
    var idContactSelect: Int32!
    var nameContactSelect: String!
    var addressContactSelect: String!
    var phoneContactSelect: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameInput.text = nameContactSelect
        addressInput.text = addressContactSelect
        phoneInput.text = phoneContactSelect

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
        var contactBook : ContactBook = ContactBook()
        contactBook = MySQLiteHelper.getInstance().retrieveSelectContact(Int(idContactSelect!))
        nameInput.text = contactBook.Name
        phoneInput.text = contactBook.Phone
        addressInput.text = contactBook.Address
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func SaveContact(sender: AnyObject) {
        
        let contactBook : ContactBook = ContactBook()
        contactBook.Name = nameInput.text!
        contactBook.Address = addressInput.text!
        contactBook.Phone = phoneInput.text!
        contactBook.IdContact = idContactSelect
        
        let isSuccess =  MySQLiteHelper.getInstance().updateAddressBookData(contactBook)
        
        if (isSuccess) {
            print("contato salvo")
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            let alert = Alert.AlertView("Alerta", MessageAlert: "Erro ao tentar salvar, tente novamente")
            self.presentViewController(alert, animated: true, completion: nil)
        }

        
    }
    @IBAction func Cancell(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func DeleteContact(sender: AnyObject) {
        MySQLiteHelper.getInstance().deleteAddressBookData(Int(idContactSelect!))
        self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nameInput .resignFirstResponder()
        phoneInput .resignFirstResponder()
        addressInput .resignFirstResponder()
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        if (textField == nameInput) {
            addressInput .becomeFirstResponder();
            return true
        }else if (textField == addressInput) {
            phoneInput .becomeFirstResponder()
            return true
        }else if (textField == phoneInput) {
            phoneInput .resignFirstResponder()
            return true
        }
        return false;
    }
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        if textField == nameInput {
            var checkString:NSString = self.nameInput.text! as NSString
            checkString = checkString.stringByReplacingCharactersInRange(range, withString: string)
            checkString = checkString.stringByTrimmingCharactersInSet(
                NSCharacterSet.whitespaceAndNewlineCharacterSet()
            )
            if (checkString.length==0){
                saveContact.enabled = false
            }
            else{
                saveContact.enabled = true
            }
            print("checkString: ", checkString)
            print("checkString.length: ", checkString.length)
            
        }
        return true
    }
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("clear name")
        if textField == nameInput {
            saveContact.enabled = false
        }
        return true
    }
}
