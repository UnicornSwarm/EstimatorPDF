//
//  Untitled.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-13.
//

import Foundation

struct TrackableItem: Hashable, Equatable {
    let id: UUID
    let title: String
    let description: String
    var quantity: Int = 1
    var unitPrice: Double
    var tax: Double

    // Total Price for the Item
    var totalPrice: Double {
        guard unitPrice > 0, quantity > 0 else { return 0 }
        let taxAmount = unitPrice * (tax / 100)
        return Double(quantity) * (unitPrice + taxAmount)
    }

    // Total Tax for the Item
    var totalTax: Double {
        guard unitPrice > 0, quantity > 0 else { return 0 }
        return Double(quantity) * (unitPrice * (tax / 100))
    }

    // Equatable implementation based on the `id`
    static func ==(lhs: TrackableItem, rhs: TrackableItem) -> Bool {
        return lhs.id == rhs.id
    }
}

// To add 'CustomerItem' from the CustomerModel.swift file (as a trackable item)
extension TrackableItem {
    init(from customerItem: CustomerItem, unitPrice: Double = 0.0, taxRate: Double = 0.0) {
        self.id = customerItem.id
        self.title = customerItem.title
        self.description = customerItem.description
        self.quantity = 1
        self.unitPrice = unitPrice
        self.tax = taxRate
    }
}

