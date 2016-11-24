//
//  NoteTests.swift
//  NoteBookProject
//
//  Created by imac on 24/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import XCTest
import RealmSwift

@testable import NoteBookProject
class NoteTests: XCTestCase {
    var note:Note!
    var realm:Realm!

    override func setUp() {
        super.setUp()
        note = Note()
        realm = try! Realm(configuration:Realm.Configuration(inMemoryIdentifier: self.name))
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try! realm.write {
            realm.add(note)
        }

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetValue() {
      XCTAssertEqual(0, note.getValue())
        note.setValue(newValue: 10.5)
        XCTAssertEqual(10.5, note.getValue())
        note.setValue(newValue: -10)
        XCTAssertEqual(10.5, note.getValue())
         note.setValue(newValue: 0)
        XCTAssertEqual(0, note.getValue())
        
    }
    
    func testSetCoef() {
        XCTAssertEqual(1, note.getCoef())
        note.setCoef(newCoeff: 10)
        XCTAssertEqual(10, note.getCoef())
        note.setCoef(newCoeff: -10)
        XCTAssertEqual(10, note.getCoef())
        note.setCoef(newCoeff: 0)
        XCTAssertEqual(10, note.getCoef())
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
