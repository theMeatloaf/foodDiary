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
        formatter.timeStyle = .ShortStyle
        return formatter
    }()
    
    var meals : [Meal] = []
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
            self.meals = try managedContext.executeFetchRequest(mealFetch) as! [Meal]
            self.tableView.reloadData()
        } catch {
            fatalError("Failed to fetch meals: \(error)")
        }
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let thisMeal = meals[indexPath.row]
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Meal")
        
        cell.textLabel?.text = "\(thisMeal.type!) - \(ListViewController.dateFormater.stringFromDate(thisMeal.dateTime!))"
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
        meal.type = "Snack"
        
        //4
        do {
            try managedContext.save()
            self.meals.append(meal)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        newVc.inputMeal = meal
        self.navigationController?.pushViewController(newVc, animated: true)
        
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisMeal = meals[indexPath.row]
        let editVC = AddMealViewController()
        
        editVC.inputMeal = thisMeal
        
        self.navigationController?.pushViewController(editVC, animated: true)
        
    }
}

