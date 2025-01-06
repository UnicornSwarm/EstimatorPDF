//
//  EstimateModel.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-02.
//

import Foundation

struct Estimate {
    let referenceNumber: UUID
    let customer: Customer // Reference the Customer object directly
    let date: Date
    //Info
    var items: [EstimateItem]
    let notes: String?
    //Price
    var subtotal: Double {
        items.reduce(0) { $0 + ($1.unitPrice * Double($1.quantity)) }
    }
    var totalTax: Double {
        items.reduce(0) { $0 + (($1.unitPrice * Double($1.quantity)) * ($1.taxRate / 100)) }
    }
    var total: Double {
        subtotal + totalTax
    }
}

struct EstimateItem {
    let title: String
    let description: String
    //Price & Quantity
    let quantity: Int
    let unitPrice: Double
    var taxRate: Double
    var totalPrice: Double {
        Double(quantity) * (unitPrice + (unitPrice * (taxRate / 100)))
    }
}
