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
        taxRate: 10.0
    ),
    TrackableItem(
        id: UUID(),
        title: "Replacement Part A",
        description: "Ordered part for repair.",
        quantity: 1,
        unitPrice: 50.0,
        taxRate: 5.0
    )
]

let mockEstimate = EstimateModel(
    id: UUID(),
    title: "Estimate 007",
    date: Date(),
    items: mockItems,
    finalNotes: "Thank you for your business!",
    sections: [],
    business: mockBusiness,
    customer: mockCustomer
)

let mockInvoice = InvoiceModel(
    id: UUID(),
    title: "Invoice 007",
    date: Date(),
    dueDate: Calendar.current.date(byAdding: .day, value: 30, to: Date()) ?? Date(),
    items: mockItems, // 👈 correct plural
    sections: [],     // 👈 you can leave empty for now
    business: mockBusiness, // 👈 full BusinessModel
    customer: mockCustomer, // 👈 full Customer
    notes: "Lovely customer!",
    finalNotes: "Private notes about customer service reports.",
    paymentTerms: "Please pay within 30 days."
)


//
//let mockInvoice: InvoiceModel = {
//    let invoice = InvoiceModel(
//        id: UUID(),
//        title: "Invoice #007",
//        date: Date(),
//        dueDate: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
//        items: mockItems,
//        sections: [], // Populated below
//        business: mockBusiness,
//        customer: mockCustomer,
//        notes: "Customer was friendly and pickup was timely.",
//        finalNotes: "Service quality confirmed by client. All systems operational.",
//        paymentTerms: "Payment due within 30 days of invoice date. Late fees may apply."
//    )
//
//    let header = DocumentSection(
//        name: "Header",
//        data: DocumentHeaderData(
//            title: "Invoice",
//            referenceNumber: invoice.id.uuidString.prefix(8).uppercased(),
//            date: invoice.date.formatted(date: .abbreviated, time: .omitted),
//            businessInfoHeader: invoice.business,
//            customerInfoHeader: invoice.customer,
//            invoice: invoice
//        ),
//        layout: .header
//    )
//
//    let body = DocumentSection(
//        name: "Body",
//        data: DocumentBodyData(items: invoice.items, additionalDetails: invoice.notes),
//        layout: .body
//    )
//
//    let footer = DocumentSection(
//        name: "Footer",
//        data: DocumentFooterData(finalNotes: invoice.finalNotes),
//        layout: .footer
//    )
//
//    return InvoiceModel(
//        id: invoice.id,
//        title: invoice.title,
//        date: invoice.date,
//        dueDate: invoice.dueDate,
//        items: invoice.items,
//        sections: [header, body, footer],
//        business: invoice.business,
//        customer: invoice.customer,
//        notes: invoice.notes,
//        finalNotes: invoice.finalNotes,
//        paymentTerms: invoice.paymentTerms
//    )
//}()



//MARK: default Recipt Data

//MARK: default image Data

//MARK: submenu - default financials Data

//MARK: submenu - default legal Data

//MARK: submenu - default legalPersonal Data
