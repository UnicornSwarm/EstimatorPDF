//
//  InvoiceModel.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-02.
//

import Foundation

struct InvoiceModel {
    let id: UUID
    let customerName: String
    let businessName: String
    var items: [TrackableItem] // Reuse TrackableItem
    let date: Date?
    let dueDate: Date?
    let paymentTerms: String?
    let notes: String?
    var sections: [DocumentSection]

    var subtotal: Double {
        items.reduce(0) { $0 + $1.unitPrice * Double($1.quantity) }
    }

    var totalTax: Double {
        items.reduce(0) { $0 + $1.totalTax }
    }

    var total: Double {
        subtotal + totalTax
    }
    
    static func generateMock() -> InvoiceModel {
        return mockInvoice
    }

}

