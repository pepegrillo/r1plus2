//
//  Utilities.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//

import Foundation
import Reachability
import RealmSwift


class Utilities: NSObject {
    
    static func hasInternet() -> Bool {
        let reachability = try! Reachability()
        guard reachability.connection != .unavailable else {
            return false
        }
        return true
    }
    
    static var bundleRealmConfig = Realm.Configuration(
        fileURL:URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0], isDirectory: true).appendingPathComponent("bundle.realm"),
        schemaVersion: UInt64(Constants.App.bdVersion),
        // Set the block which will be called automatically when opening a Realm with
        // a schema version lower than the one set above
        migrationBlock: { migration, oldSchemaVersion in
            // We haven’t migrated anything yet, so oldSchemaVersion == 0
            if (oldSchemaVersion < Constants.App.bdVersion) {
                // Nothing to do!
                // Realm will automatically detect new properties and removed properties
                // And will update the schema on disk automatically
            }
    }
    )
    
}

