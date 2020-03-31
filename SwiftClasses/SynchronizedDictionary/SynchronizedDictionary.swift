//
//  SynchronizedDictionary.swift
//  SwiftClasses
//
//  Created by LAP12230 on 3/30/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import Foundation

class SynchronizedDictionary: NSMutableDictionary {
    
    private let customLock: CustomLock! = CustomLock()
    private let _dictionary: NSMutableDictionary!
    
    override convenience init() {
        self.init(capacity: 0)
    }
    
    override init(capacity numItems: Int) {
        self._dictionary = NSMutableDictionary(capacity: numItems)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        self._dictionary = NSMutableDictionary()
        super.init(coder: coder)
    }
    
    override func setObject(_ anObject: Any, forKey aKey: NSCopying) {
        self.customLock.locked {
            self._dictionary.setObject(anObject, forKey: aKey)
        }
    }
    
    override func removeObject(forKey aKey: Any) {
        self.customLock.locked {
            self._dictionary.removeObject(forKey: aKey)
        }
    }
    
    override func object(forKey aKey: Any) -> Any? {
        return self.customLock.locked {
            return self._dictionary.object(forKey: aKey)
        }
    }
    
    override func addEntries(from otherDictionary: [AnyHashable : Any]) {
        self.customLock.locked {
            self._dictionary.addEntries(from: otherDictionary)
        }
    }
    
    override var count: Int {
        return self._dictionary.count
    }
    
    override func keyEnumerator() -> NSEnumerator {
        return self.customLock.locked {
            return self._dictionary.keyEnumerator()
        }
    }
    
    override func setDictionary(_ otherDictionary: [AnyHashable : Any]) {
        self.customLock.locked {
            self._dictionary.setDictionary(otherDictionary)
        }
    }
    
    override func removeAllObjects() {
        self.customLock.locked {
            self._dictionary.removeAllObjects()
        }
    }
    
    override var allKeys: [Any] {
        self.customLock.locked {
            return self._dictionary.allKeys
        }
    }
    
    override var allValues: [Any] {
        self.customLock.locked {
            return self._dictionary.allValues
        }
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        return self.customLock.locked {
            return self._dictionary.copy(with: zone)
        }
    }
    
    override func mutableCopy(with zone: NSZone? = nil) -> Any {
        return self.customLock.locked {
            return self._dictionary.mutableCopy(with: zone)
        }
    }
    
    override func countByEnumerating(with state: UnsafeMutablePointer<NSFastEnumerationState>, objects buffer: AutoreleasingUnsafeMutablePointer<AnyObject?>, count len: Int) -> Int {
        return self.customLock.locked {
            // let copyDict = self._dictionary.mutableCopy() as! NSMutableDictionary
            return self._dictionary.countByEnumerating(with: state, objects: buffer, count: len)
        }
    }
    
    override func isEqual(to otherDictionary: [AnyHashable : Any]) -> Bool {
        return self.customLock.locked {
            return self._dictionary.isEqual(to: otherDictionary)
        }
    }
    
    override func enumerateKeysAndObjects(options opts: NSEnumerationOptions = [], using block: (Any, Any, UnsafeMutablePointer<ObjCBool>) -> Void) {
        self.customLock.locked {
            self._dictionary.enumerateKeysAndObjects(options: opts, using: block)
        }
    }
    
    override func enumerateKeysAndObjects(_ block: (Any, Any, UnsafeMutablePointer<ObjCBool>) -> Void) {
        self.customLock.locked {
            self._dictionary.enumerateKeysAndObjects(block)
        }
    }
    
}
