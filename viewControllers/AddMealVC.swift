//
//  AddMealVC.swift
//  foodDiary
//
//  Created by Ryan Wedig on 5/26/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//

import Eureka

public class AddMealViewController : FormViewController {
    
    public var inputMeal : Meal?
    
    public override func viewWillDisappear(animated: Bool) {
        
        let values = form.values()
        if let type = values["Meal Type"] as? MealType {
            self.inputMeal?.type = type.rawValue
        }
        self.inputMeal?.whatYouAte = values["whatyouate"] as? String
        self.inputMeal?.dateTime = values["Date Eaten"] as? NSDate
        self.inputMeal?.howYouFeel = values["howyoufeel"] as? String
        self.inputMeal?.notes = values["notes"] as? String
        
        //get context...
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        //try and save yo
        do {
            try managedContext.save()
        } catch let error {
            print("Error Saving:\(error)")
        }
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.inputMeal?.dateTime != nil {
            self.title = "Edit Meal"
        }else {
            self.title = "New Meal"
        }
        
        form +++ Section()
            <<< PickerInlineRow<MealType>(){
                $0.title = "Meal Type"
                $0.tag = $0.title
                $0.options = [.Snack,.Breakfast,.Lunch,.Dinner]
                if let type = inputMeal?.getMealType() {
                    $0.value = type
                } else {
                    $0.value = .Snack
                }
            }
            
            +++ Section()
            <<< DateTimeInlineRow(){
                $0.title = "Date Eaten"
                $0.tag = $0.title
                if let date = inputMeal?.dateTime {
                    $0.value = date
                } else {
                    $0.value = NSDate()
                }
            }
        
            +++ Section("What you ate..")
            <<< TextAreaRow(){
                $0.tag = "whatyouate"
                $0.placeholder = "type what you ate here..."
                $0.textAreaHeight = .Dynamic(initialTextViewHeight: 110)
                $0.value = inputMeal?.whatYouAte
            }
        
            +++ Section("How did it make you feel?")
            <<< SegmentedRow<String>(){
                $0.options = ["☹️","😐","😀"]
                $0.tag = "howyoufeel"
                if let curVal = inputMeal?.howYouFeel {
                    $0.value = curVal
                } else {
                    $0.value = "😐"
                }
                }.cellSetup { cell, row in
                    cell.segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.redColor()], forState: .Selected)
            }
            
            <<< TextAreaRow(){
                $0.tag = "notes"
                $0.placeholder = "notes..."
                $0.textAreaHeight = .Dynamic(initialTextViewHeight: 110)
                $0.value = inputMeal?.notes
            }
        
            +++ Section("Tags")
            <<< tagRow(){
                $0.options = ["test1","test2"]
            }

    }
}