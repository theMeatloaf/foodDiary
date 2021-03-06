//
//  Meal+CoreDataProperties.swift
//  foodDiary
//
//  Created by Ryan Wedig on 8/23/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Meal {

    @NSManaged var dateTime: NSDate?
    @NSManaged var howYouFeel: String?
    @NSManaged var type: String?
    @NSManaged var whatYouAte: String?
    @NSManaged var whereYouAte: String?
    @NSManaged var notes: String?
    @NSManaged var tags: NSSet?

}
