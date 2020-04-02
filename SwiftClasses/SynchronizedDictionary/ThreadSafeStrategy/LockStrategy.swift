//
//  LockStrategy.swift
//  SwiftClasses
//
//  Created by LAP12230 on 4/1/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import Foundation

class LockStrategy: ThreadSafeStrategy {
    
    private let _lock: CustomLock = CustomLock()
    
    private func synchronize<T>(_ closure: () -> T) -> T {
        _lock.lock()
        defer { _lock.unlock() }
        return closure()
    }
    
    func safeWrite<T>(_ closure: () -> T) -> T {
        return self.synchronize(closure)
    }
    
    func safeWrite(_ closure: () -> ()) {
        self.synchronize(closure)
    }
    
    func safeRead<T>(_ closure: () -> T) -> T {
        return self.synchronize(closure)
    }
    
}
