//
//  ImpDetailViewController.swift
//  MyScehdules
//
//  Created by SWUCOMPUTER on 23/06/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class ImpDetailViewController: UIViewController {
    
    @IBOutlet var textTitle: UITextField!
    @IBOutlet var textMemo: UITextField!
    @IBOutlet var startTime: UITextField!
    @IBOutlet var endTime: UITextField!
    
    var impSchedule: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let schedule = impSchedule {
            textTitle.text = schedule.value(forKey: "title") as? String
            textMemo.text = schedule.value(forKey: "memo") as? String
            startTime.text = schedule.value(forKey: "startTime") as? String
            endTime.text = schedule.value(forKey: "endTime") as? String
        }
    }
}
