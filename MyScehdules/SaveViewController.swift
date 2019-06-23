//
//  SaveViewController.swift
//  MyScehdules
//
//  Created by SWUCOMPUTER on 14/06/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class SaveViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textTitle: UITextField!
    @IBOutlet var textMemo: UITextField!
    @IBOutlet var toggleImportant: UISwitch!
    @IBOutlet var startPicker: UIDatePicker!
    @IBOutlet var endPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Schedules", in: context)
        
        // schedule record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(textTitle.text, forKey: "title")
        object.setValue(textMemo.text, forKey: "memo")
        object.setValue(toggleImportant.isOn, forKey: "isImportant")
        
        let date = DateFormatter()
        date.dateStyle = .long
        date.timeStyle = .short
        let start = date.string(from: startPicker.date)
        let end = date.string(from: endPicker.date)
        object.setValue(start, forKey: "startTime")
        object.setValue(end, forKey: "endTime")
        
        if object.value(forKey: "isImportant") as? Bool == true {
            let context = getContext()
            let entity = NSEntityDescription.entity(forEntityName: "Imp", in: context)
            
            // schedule record를 새로 생성함
            let object = NSManagedObject(entity: entity!, insertInto: context)
            object.setValue(textTitle.text, forKey: "title")
            object.setValue(textMemo.text, forKey: "memo")
            object.setValue(start, forKey: "startTime")
            object.setValue(end, forKey: "endTime")
        }
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }
    
}
