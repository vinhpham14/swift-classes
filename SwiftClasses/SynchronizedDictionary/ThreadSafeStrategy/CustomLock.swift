//
//  CustomLock.swift
//  SwiftClasses
//
//  Created by LAP12230 on 3/31/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import Foundation

class CustomLock: NSLocking {
    
    @available(iOS, deprecated: 10.0)
    private final class _OSSpinLock: NSLocking {
        private var _lock = OS_SPINLOCK_INIT
        func lock() {
            OSSpinLockLock(&_lock)
        }
        func unlock() {
            OSSpinLockUnlock(&_lock)
        }
    }
    
    @available(iOS 10.0, *)
    private final class _OSUnfairLock: NSLocking {
        private var _lock = os_unfair_lock()
        func lock() {
            os_unfair_lock_lock(&_lock)
        }
        func unlock() {
            os_unfair_lock_unlock(&_lock)
        }
    }
    
    private let _lock: NSLocking = {
        if #available(iOS 10.0, *) {
            return _OSUnfairLock()
        } else {
            return _OSSpinLock()
        }
    }()
    
    public func lock() {
        _lock.lock()
    }
    
    public func unlock() {
        _lock.unlock()
    }
    
}
