//
//  Untitled.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-13.
//

import Foundation

struct TrackableItem: Identifiable, Hashable, Equatable {
    
    let id: UUID
    let title: String
    let description: String
    var quantity: Int = 1
    var unitPrice: Double
    var taxRate: Double  // as a percentage like 13.0 for 13%
    
    // Subtotal: just price × quantity
    var subtotal: Double {
        return Double(quantity) * unitPrice
    }

    // Tax for this item: subtotal × taxRate
    var taxAmount: Double {
        return subtotal * (taxRate / 100)
    }

    // Total price for the item (subtotal + tax)
    var totalPrice: Double {
        return subtotal + taxAmount
    }

    static func ==(lhs: TrackableItem, rhs: TrackableItem) -> Bool {
        return lhs.id == rhs.id
    }
}

// CustomerItem initializer stays same
extension TrackableItem {
    init(from customerItem: CustomerItem, unitPrice: Double = 0.0, taxRate: Double = 0.0) {
        self.id = customerItem.id
        self.title = customerItem.title
        self.description = customerItem.description
        self.quantity = 1
        self.unitPrice = unitPrice
        self.taxRate = taxRate
    }
}

extension Array where Element == TrackableItem {
    var subtotal: Double {
        self.reduce(0) { $0 + $1.subtotal }
    }

    var totalTax: Double {
        self.reduce(0) { $0 + $1.taxAmount }
    }

    var grandTotal: Double {
        subtotal + totalTax
    }
}


