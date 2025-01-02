//
//  EstimateModel.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-02.
//

import Foundation

// Estimate Struct - Subtotal, Tax, and Total (Updated)
struct EstimateModel: BaseDocument {
    var title: String
    var id: UUID
    var date: Date
    var items: [TrackableItem]
    var finalNotes: String?
    var disclaimer: String?
    var additionalDetails: String?
    var sections: [DocumentSection]

    var subtotal: Double {
        items.reduce(0) { $0 + $1.unitPrice * Double($1.quantity) }
    }

    var tax: Double {
        items.reduce(into: 0) { $0 += $1.tax }
    }

    var total: Double {
        subtotal + tax
    }

    func loadDocuments() -> [String] {
        return ["Estimate: \(title)"]
    }

    static func generateMock() -> EstimateModel {
        return mockEstimate
    }
}


