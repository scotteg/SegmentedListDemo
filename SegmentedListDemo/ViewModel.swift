//
//  ViewModel.swift
//  SegmentedListDemo
//
//  Created by Scott Gardner on 1/10/19.
//  Copyright © 2019 Scott Gardner. All rights reserved.
//

import Foundation

final class ViewModel {
    
    lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter
    }()
    
    lazy var data: [Item] = {
        var data = [Item]()
        
        (0...1000).forEach {
            data.append(
                Item(value: numberFormatter.string(from: NSNumber(integerLiteral: $0))!)
            )
        }
        
        return data
    }()
    
    var selectedData: [Item] {
        return data.filter { $0.isSelected }
    }
}

final class Item {
    
    let value: String
    var isSelected: Bool = false
    
    init(value: String, selected: Bool = false) {
        self.value = value
        self.isSelected = selected
    }
}
