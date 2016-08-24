//
//  TagSelectorVC.swift
//  foodDiary
//
//  Created by Ryan Wedig on 8/23/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//

import Foundation
import Eureka

public class TagSelectorVC <T:Hashable, Row: SelectableRowType where Row: BaseRow, Row: TypedRowType, Row.Value == T, Row.Cell.Value == T> : FormViewController, TypedRowControllerType {
    
    /// The row that pushed or presented this controller
    public var row: RowOf<Set<T>>!
    
    public var selectableRowCellUpdate: ((cell: Row.Cell, row: Row) -> ())?
    
    /// A closure to be called when the controller disappears.
    public var completionCallback : ((UIViewController) -> ())?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRectMake(0,self.view.frame.size.height-50,self.view.frame.size.width,50))
        button.setTitle("NEW TAG", forState: .Normal)
        button.backgroundColor = UIColor.blueColor()
        button.addTarget(self, action: #selector(self.newTag), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        
        guard let options = row.dataProvider?.arrayData else { return }
        form +++= SelectableSection<Row, Row.Value>(row.title ?? "", selectionType: .MultipleSelection) { [weak self] section in
            if let sec = section as? SelectableSection<Row, Row.Value> {
                sec.onSelectSelectableRow = { _, selectableRow in
                    var newValue: Set<T> = self?.row.value ?? []
                    if let selectableValue = selectableRow.value {
                        newValue.insert(selectableValue)
                    }
                    else {
                        newValue.remove(selectableRow.selectableValue!)
                    }
                    self?.row.value = newValue
                }
            }
        }

        for o in options {
            form.first! <<< Row.init() { [weak self] in
                $0.title = String(o.first!)
                $0.selectableValue = o.first!
                $0.value = self?.row.value?.contains(o.first!) ?? false ? o.first! : nil
                }.cellUpdate { [weak self] cell, row in
                    self?.selectableRowCellUpdate?(cell: cell, row: row)
            }
            
        }
        form.first?.header = HeaderFooterView<UITableViewHeaderFooterView>(title: row.title)
    }
    
    public func newTag() {
        form.first! <<< Row.init() { [weak self] in
            $0.title = String("Testy Taco")
            $0.selectableValue = "Test Taco" as? T
            $0.value = self?.row.value?.contains(o.first!) ?? false ? o.first! : nil
            }.cellUpdate { [weak self] cell, row in
                self?.selectableRowCellUpdate?(cell: cell, row: row)
        }
    }
    
}