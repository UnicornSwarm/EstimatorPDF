//
//  InvoiceView.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-04-27.
//


import SwiftUI

struct InvoiceView: View {
    var invoice: InvoiceModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(invoice.title)
                .font(.largeTitle)
                .bold()

            Text("Invoice ID: \(invoice.id.uuidString.prefix(8))")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Issued: \(invoice.date.formatted(date: .abbreviated, time: .omitted))")
            Text("Due: \(invoice.dueDate?.formatted(date: .abbreviated, time: .omitted) ?? "\(invoice.date + 30)" )") ///Invoice date made plus 30 days????
                .foregroundColor(.red)

            Divider()

            Text("Billed To:")
                .font(.headline)
            Text(invoice.customer.customerName)
            Text(invoice.customer.addressCustomer ?? "Not Available") /// default customer address when not found

            Divider()

            ForEach(invoice.items) { item in
                VStack(alignment: .leading) {
                    Text(item.title).bold()
                    Text(item.description)
                    HStack {
                        Text("Qty: \(item.quantity)")
                        Spacer()
                        Text("Rate: $\(item.unitPrice, specifier: "%.2f")")
                        Spacer()
                        Text("Tax: \(item.taxRate, specifier: "%.1f")%")
                    }
                }
                .padding(.vertical, 4)
            }

            Divider()

            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    let subtotal = invoice.items.reduce(0) { $0 + ($1.unitPrice * Double($1.quantity)) }
                    let totalTax = invoice.items.reduce(0) { $0 + ($1.unitPrice * Double($1.quantity) * $1.taxRate / 100) }
                    let total = subtotal + totalTax

                    Text("Subtotal: $\(subtotal, specifier: "%.2f")")
                    Text("Tax: $\(totalTax, specifier: "%.2f")")
                        .foregroundColor(.secondary)
                    Text("Total: $\(total, specifier: "%.2f")")
                        .bold()
                }
            }

            Spacer()

            Text(invoice.paymentTerms ?? "") ///Default when terms not specified
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
