//
//  UsingGCDStrategy.swift
//  SwiftClasses
//
//  Created by LAP12230 on 4/1/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import Foundation

class GCDStrategy: ThreadSafeStrategy {
    
    private let _concurrencyQueue = DispatchQueue(label: "queue.concurrency.UsingGCDStrategy", attributes: .concurrent)
    
    func safeWrite<T>(_ closure: () -> T) -> T {
        return self._concurrencyQueue.sync(flags: .barrier) {
            return closure()
        }
    }
    
    func safeWrite(_ closure: @escaping () -> ()) {
        self._concurrencyQueue.async(flags: .barrier) {
            closure()
        }
    }
    
    
    func safeRead<T>(_ closure: () -> T) -> T {
        return self._concurrencyQueue.sync {
            return closure()
        }
    }
    
}
