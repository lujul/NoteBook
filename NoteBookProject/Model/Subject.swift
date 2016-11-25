//
//  Subject.swift
//  NoteBookProject
//
//  Created by imac on 21/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

// avant de modifier un object il faut faire des beginn commit dans realm

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
    
    
    
    public func getNoteList() -> List<Note> {
        return _notesList
    }
    
   public func getMark(atIndex index:Int) -> Note?{
        let mark:Note?
        if index >= 0 && index < _notesList.count {
             mark = _notesList[index]
        } else {
            mark = nil
        }
        return mark
         }
    
    public func delete (atIndex index:Int) {
        realm?.beginWrite()
        _notesList.remove(objectAtIndex: index)
        try! realm?.commitWrite()
    }
    
    public func getTitle() -> String{
     return _name
    }
    
    public func getRange() -> Int{
        
        return _range
    }
    
    public func setTitle(newTitle:String) { // je change la valeur d un object dans la base
        if newTitle.characters.count > 0 {
            if let r = self.realm {
                r.beginWrite()
                self._name = newTitle
                try! r.commitWrite()
            } else {
                self._name = newTitle
            }
            
        }
    }
        
    func addNote (comment: String, value: Float , range: Int) {
        if (value >= 0 && range > 0) {
            let note:Note = Note()
            note.setValue(newValue: value)
            note.setCoef(newCoeff: range)
            note.setComment(newValue: comment)
            realm?.beginWrite()
            _notesList.append(note)
            try! realm?.commitWrite()
            
        }
    }
    
    func notesCount () -> Int {
        return _notesList.count
    }
    
    func delete() {
        removeAllNotes()
        if let r = realm {
            try! r.write {
                r.delete(self)
            }
        }
    }
    
    
    func removeAllNotes() {
        if let r = realm { // là il a deja ete ajoute a la base de donnee
            try! r.write {
                r.deleteAll()
            }
        } else {
            _notesList.removeAll()
        }
    }

    
    func average() -> Float? { //le garde en swift
         let average:Float?
        
        if notesCount() > 0 {
            var somme:Float = 0.0
            var totalCoef:Int = 0
            for note:Note in _notesList {
                let range = Float(note.getCoef())
                somme += note.getValue()*range
                totalCoef += note.getCoef()
            }
            average = somme/Float(totalCoef)
            return average
        } else {
            return nil
        }       
        
    }
    
}
