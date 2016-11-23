//
//  Subject.swift
//  NoteBookProject
//
//  Created by imac on 21/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import Foundation
import RealmSwift

class Subject:Object {
    
    dynamic private var  _name:String = ""
    dynamic private var  _range:Int = 1
    private let _notesList = List<Note>()
    
    convenience init (name:String , range:Int) {
        self.init()
        _name = name
        _range = range
    }
    
    var name:String {
        return _name
    }
    
    var range:Int {
        return _range
    }
    
    func addNote (value: Float , range: Int) {
        let note:Note = Note(value:value, range:range)
        _notesList.append(note)
    }
    
    func notesCount () -> Int {
        return _notesList.count
    }
    
    func average() -> Float? {
        let total:Int = notesCount()
        var average:Float = 0.0
        for note: Note in _notesList {
            average += note.value*Float(note.range)
        }
        average = average/Float(total)
        return average
        
    }
    
}
