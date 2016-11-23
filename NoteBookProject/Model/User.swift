//
//  User.swift
//  NoteBookProject
//
//  Created by imac on 21/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import Foundation
class User {
    
    private var _name:String
    private var _subjectList: [Subject] = [Subject]()
    
    init ( name: String ) {
        _name = name
    }
    
    var subjectsList:[Subject] {
        get {
            return _subjectList
        }
        set {
            _subjectList = newValue
        }
    }
    
    func addSubject (subject:Subject) {
        _subjectList.append(subject)
    }
    
    func average () -> Float {
        return 0.0
    }
    
}
