//
//  Section.swift
//  foodDiary
//
//  Created by Ryan Wedig on 5/26/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//

import Foundation

public struct TableSection {
    var name : String
    var values : [Meal]

    init(withHeadername name:String, meal:Meal) {
        self.name = name
        self.values = [meal]
    }
    
    public mutating func addMeal(meal:Meal) {
        self.values.append(meal)
    }
}