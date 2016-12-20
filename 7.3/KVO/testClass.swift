//
//  testClass.swift
//  testSingle
//
//  Created by SHUN on 2016/6/14.
//  Copyright © 2016年 SHUN. All rights reserved.
//
import UIKit
import Foundation

class Person: NSObject {
    
    dynamic var firstName: String
    dynamic var lastName: String
    
    init(firstName: String, lastName: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        
    }
    
}
