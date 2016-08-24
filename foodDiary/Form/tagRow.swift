//
//  tagRow.swift
//  foodDiary
//
//  Created by Ryan Wedig on 8/23/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//

import Foundation
import Eureka

public final class tagRow<T: Hashable> : GenericMultipleSelectorRow<T, PushSelectorCell<Set<T>>, TagSelectorVC<T,ListCheckRow<T>>>,RowType {
    
    
    public required init(tag: String?) {        
        super.init(tag: tag)
    }
}