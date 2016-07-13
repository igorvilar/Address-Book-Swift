//
//  AddContactViewController.swift
//  Address Book Swift
//
//  Created by Igor Vilar on 13/06/16.
//  Copyright © 2016 Igor. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var NameInput: UITextField!
    @IBOutlet weak var PhoneInput: UITextField!
    @IBOutlet weak var AddressInput: UITextField!
    @IBOutlet weak var SaveContact: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SaveContact.enabled = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func CancelAdd(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func SaveContact(sender: AnyObject) {
        
        let contactBook : ContactBook = ContactBook()
        contactBook.Name = NameInput.text!
        contactBook.Address = AddressInput.text!
        contactBook.Phone = PhoneInput.text!
        
        let isSuccess =  MySQLiteHelper.getInstance().addAddressBookData(contactBook)
        
        if (isSuccess) {
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            Alert.AlertView("Alerta", MessageAlert: "Erro ao tentar salvar, tente novamente")
        }

        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NameInput .resignFirstResponder()
        PhoneInput .resignFirstResponder()
        AddressInput .resignFirstResponder()
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        if (textField == NameInput) {
            AddressInput .becomeFirstResponder();
            return true
        }else if (textField == AddressInput) {
            PhoneInput .becomeFirstResponder()
            return true
        }else if (textField == PhoneInput) {
            PhoneInput .resignFirstResponder()
            return true
        }
        return false;
    }
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        if textField == NameInput {
            var checkString:NSString = self.NameInput.text! as NSString
            checkString = checkString.stringByReplacingCharactersInRange(range, withString: string)
            checkString = checkString.stringByTrimmingCharactersInSet(
                NSCharacterSet.whitespaceAndNewlineCharacterSet()
            )
            if (checkString.length==0){
                SaveContact.enabled = false
            }
            else{
                SaveContact.enabled = true
            }
            print("checkString: ", checkString)
            print("checkString.length: ", checkString.length)

        }
        return true
    }
    func textFieldShouldClear(textField: UITextField) -> Bool {
        if textField == NameInput {
            SaveContact.enabled = false
        }
        return true
    }

}
