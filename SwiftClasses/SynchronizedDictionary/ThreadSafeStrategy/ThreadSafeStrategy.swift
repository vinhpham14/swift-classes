//
//  SynchronizedStrategy.swift
//  SwiftClasses
//
//  Created by LAP12230 on 4/1/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import Foundation

protocol ThreadSafeStrategy {
    func safeWrite<T>(_ closure: () -> T) -> T
    func safeWrite(_ closure: @escaping () -> ())
    func safeRead<T>(_ closure: () -> T) -> T
}
