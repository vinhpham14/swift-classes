//
//  CustomLock.swift
//  SwiftClasses
//
//  Created by LAP12230 on 3/31/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import Foundation

class CustomLock: NSLocking {
    
    init() {
        if #available(iOS 10.0, *) {
            _lock = os_unfair_lock()
        } else {
            _lock = OS_SPINLOCK_INIT
        }
    }
    
    // (os_unfair_lock || spin_lock)
    private var _lock: Any
    private var normalLock = NSLock()
    

    @available (iOS 10.0, *)
    private var unfairLock: os_unfair_lock {
        get {
            return _lock as! os_unfair_lock
        }
        set {
            _lock = newValue
        }
    }

    private var spinLock: OSSpinLock {
        get {
            return _lock as! OSSpinLock
        }
        set {
            _lock = newValue
        }
    }
    
    // MARK: - NSLocking Protocols
    func lock() {
        
        self.normalLock.lock()
        
        // if #available(iOS 10.0, *) {
        //     // debugPrint(self.unfairLock.self)
        //     os_unfair_lock_lock(&unfairLock)
        // } else {
        //     OSSpinLockLock(&spinLock)
        // }
    }

    func unlock() {
        
        self.normalLock.unlock()
        
        // if #available(iOS 10.0, *) {
        //     os_unfair_lock_unlock(&unfairLock)
        // } else {
        //     OSSpinLockUnlock(&spinLock)
        // }
    }
    
    func locked(excute block: () -> ()) {
        self.lock()
        block()
        self.unlock()
    }
    
    func locked<T>(excute block: () -> T) -> T {
        self.lock()
        defer { self.unlock() }
        return block()
    }
    
}
