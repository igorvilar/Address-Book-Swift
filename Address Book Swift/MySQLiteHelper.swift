//
//  MySQLiteHelper.swift
//  Address Book Swift
//
//  Created by Igor Vilar on 07/07/16.
//  Copyright © 2016 Igor. All rights reserved.
//

import UIKit

let sharedInstance = MySQLiteHelper()
var pathDocuments = FilesOperations.DocsDirectoryPath().stringByAppendingString(
    "addressbook.db")

class MySQLiteHelper: NSObject {
    var database: FMDatabase? = nil
    
    class func getInstance() -> MySQLiteHelper
    {
        if(sharedInstance.database == nil)
        {
            let filemgr = NSFileManager.defaultManager()

            if !filemgr.fileExistsAtPath(pathDocuments as String) {
                sharedInstance.database = sharedInstance.createdDatabase()
            }else{
                sharedInstance.database = FMDatabase(path: pathDocuments)
            }
        }
        return sharedInstance
    }
    
    
    func createdDatabase() ->FMDatabase{
        var contactDB: FMDatabase? = nil
        print("databasePath: ", pathDocuments)
        contactDB = FMDatabase(path: pathDocuments as String)
        if contactDB == nil {
            print("Error: \(contactDB!.lastErrorMessage())")
        }
            
        if contactDB!.open() {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)"
            if !contactDB!.executeStatements(sql_stmt) {
                print("Error: \(contactDB!.lastErrorMessage())")
            }
            contactDB!.close()
        } else {
            print("Error: \(contactDB!.lastErrorMessage())")
        }
        return contactDB!
    }
    
    func addAddressBookData(contactBook: ContactBook) -> Bool {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO CONTACTS (NAME, ADDRESS, PHONE) VALUES (?, ?, ?)", withArgumentsInArray: [contactBook.Name, contactBook.Address, contactBook.Phone])
        sharedInstance.database!.close()
        return isInserted
    }
    func updateAddressBookData(contactBook: ContactBook) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE CONTACTS SET NAME=?, ADDRESS=?, PHONE=? WHERE ID=?", withArgumentsInArray: [contactBook.Name, contactBook.Address, contactBook.Phone, Int(contactBook.IdContact)])
        sharedInstance.database!.close()
        return isUpdated
    }
    func deleteAddressBookData(idContactBook: Int) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM CONTACTS WHERE ID=?", withArgumentsInArray: [idContactBook])
        sharedInstance.database!.close()
        return isDeleted
    }
    func getAllAddressBookData() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM CONTACTS", withArgumentsInArray: nil)
        let marrContactBook : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let contactBook : ContactBook = ContactBook()
                contactBook.IdContact = resultSet.intForColumn("ID")
                contactBook.Name = resultSet.stringForColumn("NAME")
                contactBook.Address = resultSet.stringForColumn("ADDRESS")
                contactBook.Phone = resultSet.stringForColumn("PHONE")
                marrContactBook.addObject(contactBook)
            }
        }
        sharedInstance.database!.close()
        return marrContactBook
    }
    func retrieveSelectContact(idContactBook: Int) -> ContactBook {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM CONTACTS WHERE ID=?", withArgumentsInArray:[idContactBook])
        let contactBook : ContactBook = ContactBook()

        if (resultSet != nil) {
            while resultSet.next() {
                contactBook.IdContact = resultSet.intForColumn("ID")
                contactBook.Name = resultSet.stringForColumn("NAME")
                contactBook.Address = resultSet.stringForColumn("ADDRESS")
                contactBook.Phone = resultSet.stringForColumn("PHONE")
            }
        }
        sharedInstance.database!.close()
        return contactBook
    }

}
