//
//  EstimateView.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-04-27.
//

import SwiftUI


struct EstimateView: View {
    
    let estimate: EstimateModel
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 10) {
            
            
            Text("Estimate")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            Text("Client: \(estimate.customer.customerName)")
            
            Text("Project: \(estimate.customer.referenceNumber.uuidString)") // UUID needs .uuidString
            
            Text("Total Estimate: $\(estimate.subtotal, specifier: "%.2f")")
                .fontWeight(.bold)
            
            Divider()
            
            ForEach(estimate.items) { item in
                
                VStack(alignment: .leading) {
                    
                    Text(item.title)
                        .font(.headline)
                    
                    Text("Quantity: \(item.quantity)")
                    
                    Text("Unit Price: $\(item.unitPrice, specifier: "%.2f")")
                }
                .padding(.vertical, 5)
                
                Divider()
                
            }
        }
        .padding()
    }
}


