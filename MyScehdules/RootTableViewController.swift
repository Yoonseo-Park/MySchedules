//
//  RootTableViewController.swift
//  MyScehdules
//
//  Created by SWUCOMPUTER on 14/06/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class RootTableViewController: UITableViewController {

    var schedules: [NSManagedObject] = []
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // View가 보여질 때 자료를 DB에서 가져오도록 한다
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Schedules")
        let sortDescriptor = NSSortDescriptor (key: "startTime", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            schedules = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let name = appDelegate.userName {
            self.title = name + "'s Schedule"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Schedules Cell", for: indexPath)
        // Configure the cell...
        let schedule = schedules[indexPath.row]
        cell.textLabel?.text = schedule.value(forKey: "startTime") as? String
        cell.detailTextLabel?.text = schedule.value(forKey: "title") as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath)
        -> Bool {
            return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Core Data 내의 해당 자료 삭제
            let context = getContext()
            context.delete(schedules[indexPath.row])
            
            do {
                try context.save()
                print("deleted!")
            } catch let error as NSError {
                print("Could not delete \(error), \(error.userInfo)")
            }
            // 배열에서 해당 자료 삭제
            schedules.remove(at: indexPath.row)
            // 테이블뷰 Cell 삭제
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            if let destination = segue.destination as? DetailViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    destination.detailSchedule = schedules[selectedIndex]
                }
            }
        }
    }
    
}

