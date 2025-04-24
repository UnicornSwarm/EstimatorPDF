//
//  InvoiceModel.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-02.
//

import Foundation

struct InvoiceModel: DocumentModel {
    
    
    var id: UUID
    var title: String
    var date: Date
    var dueDate: Date? ///Date automated to 30 days from date of creation, but can be updated. settigns to 30/60/90/120...
    
    var items: [TrackableItem]
    var sections: [DocumentSection]
    
    var business: BusinessModel    // 👈 Add business reference
    var customer: Customer
    
    var notes: String?
    var finalNotes: String?
    var paymentTerms: String?

    var docType: DocTypeEnum {
        .invoice
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
   /// ---------------------------------------------------------------------
    static func generateMockData() -> InvoiceModel {
        
        InvoiceModel(
            
            id: UUID(),
            title: "Sample Invoice",
            date: Date(),
            dueDate: Calendar.current.date(byAdding: .day, value: 30, to: Date()),
            
            items: [
                TrackableItem(id: UUID(), title: "Consulting", description: "Time spent inspecting Project", quantity: 10, unitPrice: 20, taxRate: 0.13),
                TrackableItem(id: UUID(), title: "Repairs", description: "Repairing and maintenance", quantity: 10, unitPrice: 60, taxRate: 0.13)
            ],
            sections: [
                DocumentSection(name: "Invoice Header", layout: .header, widgets: .header([])),
                DocumentSection(name: "Invoice Body", layout: .body, widgets: .body([])),
                DocumentSection(name: "Invoice Footer", layout: .footer, widgets: .footer([]))
            ],

            business: mockBusiness,   // 👈 Inject a mock business
            customer: mockCustomer,   // 👈 Inject a mock customer
            
            notes: "Thanks for your support!",
            finalNotes: "Private notes about customer service reports.",
            paymentTerms: "Pay in 30 days or less."
        )
    }

}

extension InvoiceModel {
    static func generateMock() -> InvoiceModel {
        return mockInvoice
    }
}

