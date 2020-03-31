//
//  ViewController.swift
//  SwiftClasses
//
//  Created by LAP12230 on 3/30/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.testMultipleWriteAndRead()
    }
    
    func testMultipleWriteAndRead() {
        let date = Date()
        let dict = SynchronizedDictionary(dictionary: [:])
        
        DispatchQueue.global().async {
            NSLog("begin 1")
            for i in 0..<100000 {
                dict[i] = i
            }
            NSLog("end 1")
        }
        
        DispatchQueue.global().async {
            NSLog("begin 2")
            for i in 100000..<200000 {
                dict[i] = i
            }
            NSLog("end 2")
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            var total = 0
            for (_, v) in dict {
                if let v = v as? Int {
                    total += v
                }
            }
            
            NSLog("Time: \(Date().timeIntervalSince(date)), TOTAL: \(total)")
        }
    }

}

