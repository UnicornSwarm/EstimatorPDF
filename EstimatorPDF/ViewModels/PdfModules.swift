//
//  PdfModules.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-02.
//
//Manage the logic for the modularity of the documentlayout. Making custom documents, out of default layouts based on industry standards. 
import Foundation
import PDFKit
import SwiftUI
import UIKit

//MARK: HEADER
func createDynamicHeader(for document: BaseDocument, business: BusinessModel, customer: Customer) -> [HeaderWidget] {
    return [
        HeaderWidget(
            text: document.title.capitalized,
            font: UIFont.boldSystemFont(ofSize: 18),
            color: .black,
            alignment: .center
        ),
        HeaderWidget(
            text: "Ref: \(document.id.uuidString.prefix(6)) | Date: \(DateFormatter.localizedString(from: document.date, dateStyle: .medium, timeStyle: .none))",
            font: UIFont.systemFont(ofSize: 14),
            color: .darkGray,
            alignment: .justified
        ),
        HeaderWidget(
            text: "\(business.businessName)",
            font: UIFont.systemFont(ofSize: 14),
            color: .black,
            alignment: .left
        ),
        HeaderWidget(
            text: "Customer: \(customer.customerName)",
            font: UIFont.systemFont(ofSize: 14),
            color: .black,
            alignment: .right
        )
    ]
}
//MARK: BODY
func createDynamicBody(for items: [TrackableItem], additionalDetails: String?) -> [BodyWidget] {
    var widgets: [BodyWidget] = items.map { item in
        BodyWidget(
            text: "\(item.title): \(item.description) | Qty: \(item.quantity) | Unit Price: $\(item.unitPrice) | Total: $\(item.totalPrice)",
            font: UIFont.systemFont(ofSize: 12),
            color: .black,
            alignment: .left
        )
    }

    if let details = additionalDetails {
        widgets.append(
            BodyWidget(
                text: details,
                font: UIFont.italicSystemFont(ofSize: 12),
                color: .darkGray,
                alignment: .left
            )
        )
    }

    return widgets
}

//MARK: FOOTER
func createDynamicFooter(notes: String, disclaimer: String?) -> [FooterWidget] {
    var widgets: [FooterWidget] = [
        FooterWidget(
            text: notes,
            font: UIFont.systemFont(ofSize: 12),
            color: .gray,
            alignment: .center
        )
    ]

    if let disclaimer = disclaimer {
        widgets.append(
            FooterWidget(
                text: disclaimer,
                font: UIFont.italicSystemFont(ofSize: 10),
                color: .lightGray,
                alignment: .center
            )
        )
    }

    return widgets
}



// MARK: Modular Estimate Generation
func generatePDF(for document: BaseDocument?,
                 docTypeName: String,
                 business: BusinessModel,
                 customer: Customer) -> Data? {
    
    let pdfMetaData = [
        kCGPDFContextCreator: business.businessName,
        kCGPDFContextAuthor: "Jessica VanDusen",
        kCGPDFContextTitle: docTypeName,
        kCGPDFContextSubject: "\(docTypeName) Document for \(customer.customerName)"
    ]
    
    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = pdfMetaData as [String: Any]
    
    let pageWidth = 8.5 * 72.0
    let pageHeight = 11.0 * 72.0
    let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
    
    // Use either the selected document or a default mock
    let activeDocument: BaseDocument
    if let document = document {
        activeDocument = document
    } else {
        activeDocument = mockEstimate // 👈 fallback
    }
    
    return UIGraphicsPDFRenderer(bounds: pageRect, format: format).pdfData { context in
        context.beginPage()
        
        // 1. Header
        let headerWidgets = createDynamicHeader(for: activeDocument, business: business, customer: customer)
        drawHeader(widgets: headerWidgets, in: pageRect)
        
        // 2. Body
        if let estimate = activeDocument as? EstimateModel {
            let bodyWidgets = createDynamicBody(for: estimate.items, additionalDetails: estimate.additionalDetails)
            drawBody(widgets: bodyWidgets, in: pageRect)
        }

        // 3. Footer
        if let estimate = activeDocument as? EstimateModel {
            let summary = (
                subtotal: estimate.subtotal,
                tax: estimate.tax,
                total: estimate.total
            )
            
            drawFooter(
                notes: estimate.finalNotes ?? "Thank you!",
                disclaimer: estimate.disclaimer ?? "Default Disclaimer",
                summary: summary,
                in: pageRect
            )
        }
    }
}

