//
//  User.swift
//  NoteBookProject
//
//  Created by imac on 21/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import Foundation
import RealmSwift
class User {
    
    private let _subjectsRealmList:Results<Subject>
    private let _realm:Realm
    
    init () {
        _realm = try! Realm()
        _subjectsRealmList = _realm.objects(Subject.self)
    }
    
    func getSubjectCount() -> Int {
        return _subjectsRealmList.count
    }
    func getSubject ( atIndex index:Int ) -> Subject?{
        var subject:Subject?
        if index >= 0 && index < getSubjectCount() {
            subject = _subjectsRealmList[index]
        }
        return subject
    }
   
    
    func deleteSubject(atIndex index:Int) {
        
    }
    
}
