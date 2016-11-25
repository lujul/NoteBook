//
//  UserTest.swift
//  NoteBookProject
//
//  Created by imac on 25/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import XCTest
import RealmSwift
@testable import NoteBookProject

class UserTest: XCTestCase {
    var _user:User!
        
    override func setUp() {
        super.setUp()
        
        
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        _user = User()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateSubject() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(_user.getSubjectCount(), 0)
        _user.addSubject(withTitle: "matiere 1")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
