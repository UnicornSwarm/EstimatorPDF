//
//  EstimateModel.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-02.
//

import Foundation

struct EstimateModel: DocumentModel {
    
    var id: UUID
    var title: String
    var date: Date
    var items: [TrackableItem]
    var finalNotes: String?
    var sections: [DocumentSection]
    
    var business: BusinessModel    // 👈 Add business reference
    var customer: Customer
    
    var docType: DocTypeEnum {
        .estimate
    }
    
    var subtotal: Double {
        items.subtotal
    }
    
    var tax: Double {
        items.totalTax
    }
    
    var total: Double {
        subtotal + tax
    }
    
    func loadDocuments() -> [String] {
        sections.map { $0.name }
    }
    
    
    static func generateMockData() -> EstimateModel {
        EstimateModel(
            id: UUID(),
            title: "Sample Estimate",
            date: Date(),
            items: [
                TrackableItem(id: UUID(), title: "Consultation", description: "Initial project meeting", quantity: 1, unitPrice: 120.00, taxRate: 13.0),
                TrackableItem(id: UUID(), title: "Material", description: "Supplies and parts", quantity: 3, unitPrice: 50.00, taxRate: 13.0)
            ],
            finalNotes: "Proposal valid for 30 days. Thank you for considering us!",
            sections: [
                DocumentSection(name: "Estimate Header", layout: .header, widgets: .header([])),
                DocumentSection(name: "Estimate Body", layout: .body, widgets: .body([])),
                DocumentSection(name: "Estimate Footer", layout: .footer, widgets: .footer([]))
            ],
            business: mockBusiness,   // 👈 Inject a mock business
            customer: mockCustomer   // 👈 Inject a mock customer
        )
    }
}

extension EstimateModel {
    static func generateMock() -> EstimateModel {
        return mockEstimate
    }
}
