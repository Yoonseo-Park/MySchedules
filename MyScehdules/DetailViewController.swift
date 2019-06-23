//
//  DetailViewController.swift
//  MyScehdules
//
//  Created by SWUCOMPUTER on 14/06/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet var labelStatus: UILabel!
    @IBOutlet var textTitle: UITextField!
    @IBOutlet var textMemo: UITextField!
    @IBOutlet var startTime: UITextField!
    @IBOutlet var endTime: UITextField!
    
    var detailSchedule: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let schedule = detailSchedule {
            textTitle.text = schedule.value(forKey: "title") as? String
            textMemo.text = schedule.value(forKey: "memo") as? String
            startTime.text = schedule.value(forKey: "startTime") as? String
            endTime.text = schedule.value(forKey: "endTime") as? String
            if schedule.value(forKey: "isImportant") as? Bool == true {
                labelStatus.text = "*** 중요한 일정입니다. ***"
            }
            else {
                labelStatus.text = " "
            }
        }
    }
}

