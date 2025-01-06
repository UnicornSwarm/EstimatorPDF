//
//  mockModel.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-03.
//

import Foundation

//MARK: - Sample/Mock data

let mockEstimate = Estimate(
    referenceNumber: UUID(),
    customer: mockCustomer,
    date: Date(),
    items: [
        EstimateItem(title: "Cooler",
                     description: "Item Infooo",
                     quantity: 1, unitPrice: 500.0, taxRate: 13.0),
        EstimateItem(title: "Cables",
                     description: "Also importans item info",
                     quantity: 6, unitPrice: 39.99, taxRate: 13.0)
    ],
    notes: "Sample estimate for testing purposes"
)
//Business Data
 let mockBusiness = businessModuleModel (
  businessID: UUID(),
  businessName: "UNIK3 Coded",
  businessAddress: "Up to late",
  businessPhone: "(613)284-2120",
  businessEmail: "UNik3Industries@gmail.com",
  businessWebsite: "IDK.com",
  businessDescription: "Testing out bad app idea's, and spending too much time building them!",
  businessServices: "App testing, and Developing, avide time waster.",
  businessImageName: "businessBanner", ///PNG's in asset library.
  businessLogoName: "businessLogo"
)

// Mock Customer data
let mockCustomer = Customer (
    referenceNumber: UUID(),
    customerName: "Sample User, Jessica Lynn VanDusen",
    emailCustomer: "Email.Customer.MicroApple@gmsn.bing",
    phoneCustomer: "",
    addressCustomer: "",
    customerImageName: "",
    items: [
        CustomerItem(title: "Computer",
                     description: "Macbook Pro 2016",
                     quantity: 1,
                     estimatedCost: 899.99,
                     noteds: "Beloved, Family photo's, and old memories, stored on here. Keep safe!")
    ],
    hidenNotes: "// Optional notes for Businesses to differentiate between Customers, Character sheets? Maybe, Prefrences, Likes/Dislikes, etc. like: Back up mackbook pro, for customer!"
)
