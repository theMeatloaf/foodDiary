//
//  Meal.swift
//  foodDiary
//
//  Created by Ryan Wedig on 5/26/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//

import Foundation

enum MealType : String{
    case Breakfast = "Breakfast"
    case Snack = "Snack"
    case Lunch = "Lunch"
    case Dinner = "Dinner"
}

public struct Meal {
    
    var dateTime : NSDate?
    var type : MealType?
    var whatYouAte : String?
    var whereYouAte : String?
    var howYouFeel : String?
    
}
