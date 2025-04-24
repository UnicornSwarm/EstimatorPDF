//
//  DocumentDisplayView.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-04-27.
//

import SwiftUI

struct DocumentDisplayView: View {
    @EnvironmentObject var docManager: DocumentManager

    var body: some View {
        Group {
            if let estimate = docManager.currentDocument as? EstimateModel {
                EstimateView(estimate: estimate)
            } else if let invoice = docManager.currentDocument as? InvoiceModel {
                InvoiceView(invoice: invoice)
            }
            // Add future types here
            else {
                Text("No document selected.")
                    .foregroundColor(.gray)
            }
        }
    }
}

//add other items on enum doc types
