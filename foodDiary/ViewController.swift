//
//  ViewController.swift
//  foodDiary
//
//  Created by Ryan Wedig on 5/26/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//

import UIKit

public class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var meals : [Meal] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        cell.textLabel?.text = thisMeal.type?.rawValue
        cell.detailTextLabel?.text = thisMeal.whatYouAte
        
        return cell
    }
    @IBAction func addMeal(sender: AnyObject) {
        
        
        
    }
}

