//
//  SynchronizedDictionary.swift
//  SwiftClasses
//
//  Created by LAP12230 on 3/30/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import Foundation

class SynchronizedDictionary: NSMutableDictionary {
    
    private let _dictionary: NSMutableDictionary!
    private var _strategy: ThreadSafeStrategy! = GCDStrategy()
    
    public func setSafeThreadStrategy(_ strategy: ThreadSafeStrategy) {
        let temp = self._strategy
        temp?.safeWrite {
            self._strategy = strategy
        }
    }
    
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
        self._strategy.safeWrite {
            self._dictionary.setObject(anObject, forKey: aKey)
        }
    }
    
    override func removeObject(forKey aKey: Any) {
        self._strategy.safeWrite {
            self._dictionary.removeObject(forKey: aKey)
        }
    }
    
    override func object(forKey aKey: Any) -> Any? {
        return self._strategy.safeRead {
            self._dictionary.object(forKey: aKey)
        }
    }
    
    override func addEntries(from otherDictionary: [AnyHashable : Any]) {
        self._strategy.safeWrite {
            self._dictionary.addEntries(from: otherDictionary)
        }
    }
    
    override var count: Int {
        return self._strategy.safeRead {
            return self._dictionary.count
        }
    }
    
    override func keyEnumerator() -> NSEnumerator {
        return self._strategy.safeRead {
            return self._dictionary.keyEnumerator()
        }
    }
    
    override func setDictionary(_ otherDictionary: [AnyHashable : Any]) {
        self._strategy.safeWrite {
            self._dictionary.setDictionary(otherDictionary)
        }
    }
    
    override func removeAllObjects() {
        self._strategy.safeWrite {
            self._dictionary.removeAllObjects()
        }
    }
    
    override var allKeys: [Any] {
        return self._strategy.safeRead {
            return self._dictionary.allKeys
        }
    }
    
    override var allValues: [Any] {
        return self._strategy.safeRead {
            return self._dictionary.allValues
        }
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        return self._strategy.safeRead {
            return self._dictionary.copy(with: zone)
        }
    }
    
    override func mutableCopy(with zone: NSZone? = nil) -> Any {
        return self._strategy.safeRead {
            return self._dictionary.mutableCopy(with: zone)
        }
    }
    
    override func countByEnumerating(with state: UnsafeMutablePointer<NSFastEnumerationState>, objects buffer: AutoreleasingUnsafeMutablePointer<AnyObject?>, count len: Int) -> Int {
        return self._strategy.safeRead {
            // let copyDict = self._dictionary.mutableCopy() as! NSMutableDictionary
            return self._dictionary.countByEnumerating(with: state, objects: buffer, count: len)
        }
    }
    
    override func isEqual(to otherDictionary: [AnyHashable : Any]) -> Bool {
        return self._strategy.safeRead {
            return self._dictionary.isEqual(to: otherDictionary)
        }
    }
    
    override func enumerateKeysAndObjects(options opts: NSEnumerationOptions = [], using block: (Any, Any, UnsafeMutablePointer<ObjCBool>) -> Void) {
        self._strategy.safeRead {
            self._dictionary.enumerateKeysAndObjects(options: opts, using: block)
        }
    }
    
    override func enumerateKeysAndObjects(_ block: (Any, Any, UnsafeMutablePointer<ObjCBool>) -> Void) {
        self._strategy.safeRead {
            self._dictionary.enumerateKeysAndObjects(block)
        }
    }
    
}
