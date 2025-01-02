//
//  mockModel.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-03.
//

import Foundation


// Mock Business Data
let mockBusiness = BusinessModel(
    businessID: UUID(), //TODO: starts with a string of the business name or initials ( limit of 6 characters), Limit 4 digits for the UUID()
    businessName: "UNIK3 Coded",
    businessAddress: "Up to late, q0q0q09, Canada, Ontario",
    businessPhone: "(613) 284-2120",
    businessEmail: "UNik3Industries@gmail.com",
    businessWebsite: "IDK.com",
    businessDescription: "Testing bad app ideas and spending too much time building them!",
    businessServices: "App testing, Developing, and time-wasting",
    businessImageName: "businessBanner",
    businessLogoName: "businessLogo"
)

// Mock Customer Data
let mockCustomer = Customer(
    referenceNumber: UUID(),
    customerName: "Sample User, Jessica Lynn VanDusen",
    emailCustomer: "Email.Customer.MicroApple@gmsn.bing",
    phoneCustomer: "123 678 1237",
    addressCustomer: "1232, wrkasfl, adlkjadj",
    customerImageName: "IDONTHAVEANASSETLIBRARYIMAGE",
    itemsInCareOf: [
        CustomerItem(
            id: UUID(), //TODO: starts with a string of the product name or initials ( limit of 6 characters), Limit 4 digits for the UUID()
            title: "Computer",
            description: "MacBook Pro 2016"
            
        )
    ],
    hiddenNotes: "Backup MacBook Pro for the customer."
)

let mockItems: [TrackableItem] = [
    TrackableItem(
        id: UUID(),
        title: "Sample Item 1",
        description: "This is a sample item for testing.",
        quantity: 2,
        unitPrice: 100.0,
        tax: 10.0
    ),
    TrackableItem(
        id: UUID(),
        title: "Replacement Part A",
        description: "Ordered part for repair.",
        quantity: 1,
        unitPrice: 50.0,
        tax: 5.0
    )
]

let mockEstimate = EstimateModel(
    title: "Estimate",
    id: UUID(),
    date: Date(),
    items: mockItems,
    finalNotes: "Thank you for your business!",
    additionalDetails: "This is additional estimate information.",
    sections: [
        DocumentSection(
            name: "Header",
            data: DocumentHeaderData(
                title: "Estimate",
                referenceNumber: UUID().uuidString,
                date: "\(Date())",
                businessInfoHeader: mockBusiness,
                customerInfoHeader: mockCustomer,
                estimate: EstimateModel(
                    title: "Empty Estimate",
                    id: UUID(),
                    date: Date(),
                    items: [],
                    finalNotes: nil,
                    additionalDetails: nil,
                    sections: []
                ) // <-- Placeholder instead of nil
            ),
            layout: .header
        ),
        DocumentSection(
            name: "Body",
            data: DocumentBodyData(items: mockItems, additionalDetails: "Notes on ordered/repaired items."),
            layout: .body
        ),
        DocumentSection(
            name: "Footer",
            data: DocumentFooterData(finalNotes: "All parts are subject to availability.", disclaimer: "Warranty void if misused."),
            layout: .footer
        )
    ]
)

let mockInvoice = InvoiceModel(
    id: UUID(),
    customerName: mockCustomer.customerName,
    businessName: mockBusiness.businessName,
    items: mockItems,
    date: Date(),
    dueDate: Calendar.current.date(byAdding: .day, value: 30, to: Date()) ?? Date(),
    paymentTerms: "Please pay within 30 days.",
    notes: "Lovely customer!",
    sections: [
        DocumentSection(
            name: "Header",
            data: DocumentHeaderData(
                title: "Invoice",
                referenceNumber: UUID().uuidString.prefix(10).description,
                date: "\(Date())",
                businessInfoHeader: mockBusiness,
                customerInfoHeader: mockCustomer,
                estimate: EstimateModel( // 🧩 Placeholder if your header needs it
                    title: "Empty Estimate",
                    id: UUID(),
                    date: Date(),
                    items: [],
                    finalNotes: nil,
                    additionalDetails: nil,
                    sections: []
                )
            ),
            layout: .header
        ),
        DocumentSection(
            name: "Body",
            data: DocumentBodyData(
                items: mockItems,
                additionalDetails: "Invoice details for your records."
            ),
            layout: .body
        ),
        DocumentSection(
            name: "Footer",
            data: DocumentFooterData(
                finalNotes: "Thank you for your payment.",
                disclaimer: "Late payments may be subject to fees."
            ),
            layout: .footer
        )
    ]
)


//
////MARK: -- Default Estimate Data
//func generateEstimateMD() -> EstimateModel {
//    let sampleItems = [
//        TrackableItem(
//            id: UUID(),
//            title: "Logic Board Replacement",
//            description: "Replaced damaged logic board with a new Apple-certified part.",
//            quantity: 1,
//            unitPrice: 749.99,
//            taxRate: 13.0
//        ),
//        TrackableItem(
//            id: UUID(),
//            title: "Battery Replacement",
//            description: "Replaced the degraded battery with a new Apple-certified battery.",
//            quantity: 1,
//            unitPrice: 129.99,
//            taxRate: 13.0
//        ),
//        TrackableItem(
//            id: UUID(),
//            title: "Labor Fee",
//            description: "Diagnostic and repair labor for MacBook.",
//            quantity: 1,
//            unitPrice: 199.99,
//            taxRate: 13.0
//        )
//    ]
//    
//    let estimate = EstimateModel(
//        title: "Estimate",
//        id: UUID(),
//        date: Date(),
//        items: sampleItems,
//        finalNotes: "All replaced parts come with a 90-day warranty. Thank you for choosing UNIK3 Tech Services!",
//        additionalDetails: "This is additional estimate information.",
//        sections: [] // We'll populate this below
//    )
//
//    let header = DocumentSection(
//        name: "Header",
//        data: DocumentHeaderData(
//            title: estimate.title,
//            referenceNumber: estimate.id.uuidString.prefix(10).description, // Shortened reference number
//            date: "\(estimate.date)",
//            businessInfoHeader: mockBusiness,
//            customerInfoHeader: mockCustomer,
//            estimate: estimate
//        ),
//        layout: .header
//    )
//
//    let body = DocumentSection(
//        name: "Body",
//        data: DocumentBodyData(items: estimate.items, additionalDetails: estimate.additionalDetails),
//        layout: .body
//    )
//
//    let footer = DocumentSection(
//        name: "Footer",
//        data: DocumentFooterData(finalNotes: estimate.finalNotes ?? "No additional notes."),
//        layout: .footer
//    )
//
//    // Add sections to estimate
//    return EstimateModel(
//        title: estimate.title,
//        id: estimate.id,
//        date: estimate.date,
//        items: estimate.items,
//        finalNotes: estimate.finalNotes,
//        additionalDetails: estimate.additionalDetails,
//        sections: [header, body, footer]
//    )
//}
//
//// MARK: -- Default Invoice Data
//func generateInvoiceMD() -> InvoiceModel {
//    let invoice = InvoiceModel(
//        id: UUID(),
//        customerName: "Jessica Burger Mana-Lover",
//        businessName: "Apple Inc.",
//        items: [
//            TrackableItem(
//                id: UUID(),
//                title: "Logic Board 3000",
//                description: "Logic Board Replacement",
//                quantity: 1,
//                unitPrice: 749.99,
//                taxRate: 13.0
//            ),
//            TrackableItem(
//                id: UUID(),
//                title: "Battery 5000000",
//                description: "Battery Replacement",
//                quantity: 1,
//                unitPrice: 129.99,
//                taxRate: 13.0
//            ),
//            TrackableItem(
//                id: UUID(),
//                title: "Labour Costs",
//                description: "Labor Fee",
//                quantity: 10,
//                unitPrice: 199.99,
//                taxRate: 13.0
//            )
//        ],
//        date: Date(),
//        dueDate: Calendar.current.date(byAdding: .day, value: 30, to: Date()),
//        paymentTerms: "Please pay within 30 days or late fees apply",
//        notes: "These are notes, like it was dirty or something",
//        sections: [] // Populate below
//    )
//
//    // 🛠 Create Header using `createDynamicHeader`
//    let header = DocumentSection(
//        name: "Header",
//        data: DocumentHeaderData(
//            title: "\(invoice.businessName) Invoice",
//            referenceNumber: invoice.id.uuidString.prefix(10).description,
//            date: "\(invoice.date ?? Date())",
//            businessInfoHeader: mockBusiness,
//            customerInfoHeader: mockCustomer,
//            estimate: estimate // Invoice doesn't have an estimate
//        ),
//        layout: .header
//    )
//
//    // 🛠 Create Body using `createDynamicBody`
//    let body = DocumentSection(
//        name: "Body",
//        data: DocumentBodyData(items: invoice.items, additionalDetails: invoice.notes ?? ""),
//        layout: .body
//    )
//
//    // 🛠 Create Footer using `createDynamicFooter`
//    let footer = DocumentSection(
//        name: "Footer",
//        data: DocumentFooterData(finalNotes: invoice.notes ?? "No additional notes."),
//        layout: .footer
//    )
//
//    return InvoiceModel(
//        id: invoice.id,
//        customerName: invoice.customerName,
//        businessName: invoice.businessName,
//        items: invoice.items,
//        date: invoice.date,
//        dueDate: invoice.dueDate,
//        paymentTerms: invoice.paymentTerms,
//        notes: invoice.notes,
//        sections: [header, body, footer]
//    )
//}


//MARK: default Recipt Data

//MARK: default image Data

//MARK: submenu - default financials Data

//MARK: submenu - default legal Data

//MARK: submenu - default legalPersonal Data
