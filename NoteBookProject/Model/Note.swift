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
    
    convenience init (value: Float , range: Int ) {
        self.init(value:value , range:range)
        _value = value
        _range = range
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
    
    var range:Int {
        return _range
    }
    
    
    
}

