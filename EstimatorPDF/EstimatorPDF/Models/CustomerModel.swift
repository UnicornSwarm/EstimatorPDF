//
//  CustomerModel.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-03.
//

import Foundation
import UIKit

struct Customer {
    let referenceNumber: UUID
    let customerName: String
    let emailCustomer: String?
    let phoneCustomer: String?
    let addressCustomer: String?
    let customerImageName: String
    var items: [CustomerItem]?
    let hidenNotes: String? // Optional notes for estimates
    //TODO: make a hidden notes section for business to make notes on customer interactions, specifications.(same for customers to use on businesses.)
    
    var customerImage: UIImage? {
        UIImage(named: customerImageName)
    }
}

///Customer bringd the object to be repaired or service, maybe custom paint work. So their product will be on the invoice. 
struct CustomerItem {
    let title: String
    let description: String
    let quantity: Int
    let estimatedCost: Double
    let noteds: String?
}
