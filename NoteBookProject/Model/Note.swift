//
//  Note.swift
//  NoteBookProject
//
//  Created by imac on 21/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    
    dynamic private var _value:Float = 0.0
    dynamic private var _comment:String = ""
    dynamic private var _range:Int = 1
    
    convenience init (comment: String, value: Float , range: Int ) {
        self.init()
        _value = value
        _range = range
        _comment = comment
        
    }
    
    var comment:String {
        get {
            return _comment
        }
        set {
            _comment = newValue
        }
    }
    
    var value:Float {
        return _value
    }
    
    public func getCoef() -> Int {
        return _range
    }
    
    public func setCoef(newCoeff:Int) {
        if newCoeff > 0 {
            if let r = realm {
                r.beginWrite()
                self._range = newCoeff
                try! r.commitWrite()
                
            } else {
                self._range = newCoeff
            }
        }
    }
    
    public func setValue (newValue:Float) {
        if newValue >= 0 {
            if let r = realm {
                try! r.write {
                    self._value = newValue
                }
            } else {
                self._value = newValue
            }
        }
        
    }
    
    public func getValue() -> Float {
        return _value
    }
    
    
    var range:Int {
        return _range
    }
    
    
    
}

