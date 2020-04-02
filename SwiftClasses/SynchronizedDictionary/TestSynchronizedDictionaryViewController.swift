//
//  TestSynchronizedDictionaryViewController.swift
//  SwiftClasses
//
//  Created by LAP12230 on 4/2/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import UIKit

class TestSynchronizedDictionaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.writerAndReader()
        // self.multipleWriters()
        self.multipleReaders()
    }
    
    func multipleWriters() {
        NSLog("=== Multiple writers at the same time ===")
        
        let dict = SynchronizedDictionary(dictionary: [:])
        dict.setSafeThreadStrategy(GCDStrategy())
        
        // Begin test
        let date = Date()
        let semaphore = DispatchSemaphore(value: 0)
        
        // Reader 1
        DispatchQueue.global().async {
            NSLog("Begin writing 1")
            for i in 0...10000 {
                dict[i] = i
            }
            NSLog("Finish writing 1")
            semaphore.signal()
        }
        
        // Reader 2
        DispatchQueue.global().async {
            NSLog("Begin writing 2")
            for i in 0...10000 {
                dict[i] = i
            }
            NSLog("Finish writing 2")
            semaphore.signal()
        }
        
        // Reader 3
        DispatchQueue.global().async {
            NSLog("Begin writing 3")
            for i in 0...10000 {
                dict[i] = i
            }
            NSLog("Finish writing 3")
            semaphore.signal()
        }
        
        semaphore.wait()
        semaphore.wait()
        semaphore.wait()
        NSLog("Finished time: \(Date().timeIntervalSince(date))")
        NSLog("=====================")
    }
    
    func multipleReaders() {
        NSLog("=== Multiple readers at the same time ===")
        
        let dict = SynchronizedDictionary(dictionary: [:])
        dict.setSafeThreadStrategy(LockStrategy())
        
        // Init value for reading
        for i in 0...100000 {
            dict[i] = i
        }
        
        // Begin test
        let date = Date()
        let semaphore = DispatchSemaphore(value: 0)
        
        // Reader 1
        DispatchQueue.global().async {
            NSLog("Begin reading 1")
            for (_, _) in dict {
                usleep(1)
            }
            NSLog("Finish reading 1")
            semaphore.signal()
        }
        
        // Reader 2
        DispatchQueue.global().async {
            NSLog("Begin reading 2")
            for (_, _) in dict {
                usleep(1)
            }
            NSLog("Finish reading 2")
            semaphore.signal()
        }
        
        // Reader 3
        DispatchQueue.global().async {
            NSLog("Begin reading 3")
            for (_, _) in dict {
                usleep(1)
            }
            NSLog("Finish reading 3")
            semaphore.signal()
        }
        
        semaphore.wait()
        semaphore.wait()
        semaphore.wait()
        NSLog("Finished time: \(Date().timeIntervalSince(date))")
        NSLog("=====================")
    }
    
    func writerAndReader() {
        let dict = SynchronizedDictionary(dictionary: [:])
        dict.setSafeThreadStrategy(LockStrategy())
        
        // Init value for reading
        for i in 0...100000 {
            dict[i] = i
        }
        
        // Begin test
        DispatchQueue.global().async {
            NSLog("Begin writing")
            for i in 0...100000 {
                dict[i] = 0
            }
            NSLog("End writing")
        }
        
        DispatchQueue.global().async {
            NSLog("Begin reading")
            for (_, _) in dict {
                
            }
            NSLog("End reading")
        }
    }
    
}

