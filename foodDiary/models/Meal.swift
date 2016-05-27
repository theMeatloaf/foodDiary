//
//  Meal.swift
//  foodDiary
//
//  Created by Ryan Wedig on 5/26/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//

import Foundation
import CoreData


public enum MealType : String{
    case Breakfast = "Breakfast"
    case Snack = "Snack"
    case Lunch = "Lunch"
    case Dinner = "Dinner"
}

@objc(Meal)
public class Meal: NSManagedObject {

    
    public func getMealType() -> MealType? {
        if let ty = self.type {
            return MealType(rawValue: ty)!
        }else {
            return .None
        }
    }
    
    
}
