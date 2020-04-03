//
//  ProductViewModel.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 26/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

class ProductViewModel {
    var model: Product
    
    init(model: Product) {
        self.model = model
    }
    
    var name: String {
        return model.name ?? "Unknown Product"
    }
    
    var glutenLabel: String {
        guard let value = model.isGlutenFree else {
            return "Gluten free: This information is not available"
        }
        
        return value == true ? "Gluten free: Yes" : "Gluten free: No"
    }
    
    var allergensText: String {
        return model.allergens?.isEmpty == true ?
            "No allergen" :
            "Others allergens: \(model.allergens!)"
    }
    
    var shouldDisplayWheatImage: Bool {
        guard let value = model.isGlutenFree else { return false }
        return !value
    }
}

extension Array where Element == Product {
    var toViewModels: [ProductViewModel] {
        return self.map { ProductViewModel(model: $0) }
    }
}
