//
//  Profile.swift
//  Telemedicine Assistant
//
//  Created by Foredoomed on 3/3/16.
//  Copyright © 2016 liuxuan. All rights reserved.
//

import Foundation


class Profile: NSObject, NSCoding {
    var firstName: String!
    var lastName: String!
    var age: Int!
    var pregnant: Bool!
    var allergen: String!
    
    
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("profiles")
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(firstName, forKey: "firstName")
        aCoder.encodeObject(lastName, forKey: "lastName")
        aCoder.encodeInteger(age, forKey: "age")
        aCoder.encodeBool(pregnant, forKey: "pregnant")
        aCoder.encodeObject(allergen, forKey: "allergen")

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let firstName = aDecoder.decodeObjectForKey("firstName") as! String
        let lastName = aDecoder.decodeObjectForKey("lastName") as! String
        let age = aDecoder.decodeIntegerForKey("age")
        let pregnant = aDecoder.decodeBoolForKey("pregnant")
        let allergen = aDecoder.decodeObjectForKey("allergen") as? String
        
        self.init(firstName: firstName, lastName: lastName, age: age, pregnant: pregnant, allergen: allergen!)
    }
    
    init?(firstName: String, lastName: String, age: Int, pregnant: Bool, allergen: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.pregnant = pregnant
        self.allergen = allergen
        super.init()
        
        if firstName.isEmpty || lastName.isEmpty {
            return nil
        }
    }
    
    override init() {
        super.init()
    }
}