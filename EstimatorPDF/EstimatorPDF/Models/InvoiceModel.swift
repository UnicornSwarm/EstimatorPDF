//
//  InvoiceModel.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-02.
//

import Foundation

struct Invoice {
    let id: UUID
    let customerName: String
    let items: [InvoiceItem]
    let totalIn: Double
    let date: Date
}

struct InvoiceItem {
    let description: String
    let quantity: Int
    let unitPrice: Double
    let taxRate: Double
    var totalPriceIn: Double { Double(quantity) * (unitPrice + taxRate) }
}
