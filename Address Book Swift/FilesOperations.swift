//
//  FilesOperations.swift
//  Address Book Swift
//
//  Created by Igor Vilar on 07/07/16.
//  Copyright © 2016 Igor. All rights reserved.
//

import UIKit

class FilesOperations: NSObject {
    static func DocsDirectoryPath() -> String {
        let dirPaths =
            NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
                                                .UserDomainMask, true)
        let docsDir = dirPaths[0]
        return docsDir;
    }
}
