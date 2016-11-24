//
//  NoteBookProjectTests.swift
//  NoteBookProjectTests
//
//  Created by imac on 21/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import XCTest
import RealmSwift
@testable import NoteBookProject

class NoteBookProjectTests: XCTestCase {
    var subject:Subject!
    var realm:Realm!
    
    
    
    override func setUp() {
        super.setUp()
        subject = Subject()
        realm = try! Realm(configuration:Realm.Configuration(inMemoryIdentifier: self.name))
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try! realm.write {
            realm.add(subject)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDeleteSubject(){
          XCTAssertEqual(1, realm.objects(Subject.self).count)
        XCTAssertEqual(0, realm.objects(Note.self).count)
        subject.addNote(comment: "", value: 10, range: 1)
        XCTAssertEqual(1, realm.objects(Note.self).count)
        subject.delete()
        XCTAssertEqual(0, realm.objects(Subject.self).count)

        
    }
    
    func testSubjectTitle() {
        let subject = Subject()
        XCTAssertEqual(subject.getTitle(), "")
        subject.setTitle(newTitle: "Maths")
        XCTAssertEqual(subject.getTitle(), "Maths")
        subject.setTitle(newTitle: "")
        XCTAssertEqual(subject.getTitle(), "Maths")
        
    }
    
    func testEmptyNoteList() {
        XCTAssertNil(subject.average())
    }
    
    func testGetMark() {
        XCTAssertNil(subject.getMark(atIndex: 0))
        subject.addNote(comment: "", value: 10, range: 1)
        let firstNote = subject.getMark(atIndex: 0)
        XCTAssertNotNil(firstNote)
        XCTAssertEqual(firstNote!.getValue(), 10)
         XCTAssertNil(subject.getMark(atIndex: -1))
        
    }
    
    func testNoteManagement() {
        let s = Subject()
        XCTAssertEqual(0, s.notesCount())
        s.addNote(comment: "", value: 20.0, range: 1)
        XCTAssertEqual(s.notesCount(), 1)
        s.addNote(comment: "", value: 1.0, range: -1)
        XCTAssertEqual(s.notesCount(), 1)
        s.addNote(comment: "", value: -2, range: 1)
        XCTAssertEqual(s.notesCount(), 1)
        s.addNote(comment: "", value: 10.0, range: 1)
        XCTAssertEqual(s.notesCount(), 2)
        XCTAssertEqual(s.average(), 15)

    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
