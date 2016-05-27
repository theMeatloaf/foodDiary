//
//  ViewController.swift
//  foodDiary
//
//  Created by Ryan Wedig on 5/26/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//

import UIKit
import CoreData

public class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    static let dateFormater : NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }()
    
    static let timeFormater : NSDateFormatter = {
       let format = NSDateFormatter()
        format.dateStyle = .NoStyle
        format.timeStyle = .ShortStyle
        return format
    }()
    
    var sections : [TableSection] = []
    @IBOutlet var tableView: UITableView!
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadData()
    }
    
    public func loadData() {
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let mealFetch = NSFetchRequest(entityName: "Meal")
        
        do {
            let meals = try managedContext.executeFetchRequest(mealFetch) as! [Meal]
            self.buildOutAndReloadTable(meals)
        } catch {
            fatalError("Failed to fetch meals: \(error)")
        }
    }
    
    public func buildOutAndReloadTable(meals:[Meal]) {
        
        self.sections = []
        
        for meal in meals {
            let header = ListViewController.dateFormater.stringFromDate(meal.dateTime!)
            let contains = self.sections.contains({ (section:TableSection) -> Bool in
                return section.name == header
            })
            
            if contains {
               self.sections[self.sections.count-1].addMeal(meal)
            } else {
                self.sections.append(TableSection(withHeadername: header, meal: meal))
            }
        }
        self.tableView.reloadData()
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count > 0 ?  sections[section].values.count : 0
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let thisMeal = sections[indexPath.section].values[indexPath.row]
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Meal")
        
        cell.textLabel?.text = "\(thisMeal.type!) - \(ListViewController.timeFormater.stringFromDate(thisMeal.dateTime!))"
        cell.detailTextLabel?.text = thisMeal.whatYouAte
        
        return cell
    }
    @IBAction func addMeal(sender: AnyObject) {
        
        let newVc = AddMealViewController()
        //get context...
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //get entity and insert it
        let entity =  NSEntityDescription.entityForName("Meal", inManagedObjectContext:managedContext)
        let meal = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Meal
        
        //save that ish
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        newVc.inputMeal = meal
        self.navigationController?.pushViewController(newVc, animated: true)
        
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisMeal = sections[indexPath.section].values[indexPath.row]
        let editVC = AddMealViewController()
        
        editVC.inputMeal = thisMeal
        
        self.navigationController?.pushViewController(editVC, animated: true)
        
    }
    
    
    //MARK: Editing
    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisMeal = sections[indexPath.section].values[indexPath.row]
        
        //get context...
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext

        managedContext.deleteObject(thisMeal)
        //save that ish
        do {
            try managedContext.save()
            
            sections[indexPath.section].values.removeAtIndex(indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            self.tableView.endUpdates()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}

