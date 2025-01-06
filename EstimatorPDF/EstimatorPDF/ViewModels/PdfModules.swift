//
//  PdfModules.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-02.
//

import Foundation
import PDFKit
import SwiftUI
import UIKit



//MARK: Draw the header for modularity
struct HeaderWidget {
    let text: String
    let font: UIFont
    let color: UIColor
    let alignment: NSTextAlignment
}

struct DocumentHeaderData {
    let title: String
    let referenceNumber: String
    let date: String
    let businessName: String
    let customerName: String
    let notes: String
}


func drawHeader(widgets: [HeaderWidget], in bounds: CGRect) {
    for (index, widget) in widgets.enumerated() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = widget.alignment

        let attributes: [NSAttributedString.Key: Any] = [
            .font: widget.font,
            .foregroundColor: widget.color,
            .paragraphStyle: paragraphStyle
        ]

        let widgetHeight = bounds.height / CGFloat(widgets.count)
        let yOffset = CGFloat(index) * widgetHeight

        let widgetRect = CGRect(x: bounds.origin.x + 10,
                                y: bounds.origin.y + yOffset,
                                width: bounds.width - 20,
                                height: widgetHeight)

        widget.text.draw(in: widgetRect, withAttributes: attributes)
    }
}

func drawBody(for estimate: Estimate, in bounds: CGRect, context: CGContext) {
    let bodyFont = UIFont.systemFont(ofSize: 12)
    let attributes: [NSAttributedString.Key: Any] = [.font: bodyFont, .foregroundColor: UIColor.black]
    var yOffset: CGFloat = 20
    
    for item in estimate.items {
        let text = "\(item.title): \(item.description) | Qty: \(item.quantity) | Unit Price: $\(item.unitPrice) | Total: $\(item.totalPrice)"
        let textRect = CGRect(x: bounds.minX + 20, y: bounds.minY + yOffset, width: bounds.width - 40, height: 20)
        text.draw(in: textRect, withAttributes: attributes)
        yOffset += 20
    }
}


func drawFooter(with notes: String, in bounds: CGRect, context: CGContext) {
    let footerFont = UIFont.systemFont(ofSize: 12)
    let attributes: [NSAttributedString.Key: Any] = [.font: footerFont, .foregroundColor: UIColor.gray]
    let footerRect = CGRect(x: bounds.minX + 20, y: bounds.maxY - 30, width: bounds.width - 40, height: 20)
    notes.draw(in: footerRect, withAttributes: attributes)
}

//MARK: Header style updates 
func createDynamicHeaderWidgets(for estimate: Estimate, selectedDocTypeName: String?) -> [HeaderWidget] {
    let docTypeName = selectedDocTypeName ?? "Estimate"
    
    return [
        HeaderWidget(
            text: docTypeName,
            font: UIFont.boldSystemFont(ofSize: 18),
            color: .black,
            alignment: .center
        ),
        HeaderWidget(
            text: "Ref: \(estimate.referenceNumber.uuidString.prefix(8)) | Date: \(estimate.date)",
            font: UIFont.systemFont(ofSize: 14),
            color: .darkGray,
            alignment: .center
        ),
        HeaderWidget(
            text: "\(mockBusiness.businessName)",
            font: UIFont.systemFont(ofSize: 14),
            color: .black,
            alignment: .left
        ),
        HeaderWidget(
            text: "Customer: \(estimate.customer.customerName)",
            font: UIFont.systemFont(ofSize: 14),
            color: .black,
            alignment: .left
        ),
        HeaderWidget(
            text: "Notes: \(estimate.notes ?? "No additional notes.")",
            font: UIFont.systemFont(ofSize: 14),
            color: .darkGray,
            alignment: .left
        )
    ]
}

//MARK: --

//MARK: Shared PDF files
func sharePDF(data: Data, selectedDocTypeName: String?) {
   
    guard let docTypeName = selectedDocTypeName, !docTypeName.isEmpty else {/// Guard to ensure we have a valid document type name
        print("No document type selected. Defaulting to 'Estimate'.")
        let docTypeName = "Estimate"  /// Defaulting to "Estimate" if no valid document type is provided

        // Create a temporary file URL for the PDF with the default name
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(docTypeName).pdf")
        do {
            
            try data.write(to: tempURL)/// Write the data to the temporary file
            
           
            let activityVC = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)  /// Create the activity view controller
            
            // Find the current window scene
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                
                rootVC.present(activityVC, animated: true, completion: nil)/// Present the activity view controller
            }
        } catch {
            print("Failed to write PDF to temporary file: \(error.localizedDescription)")
        }
        return
    }
}




// MARK: Modular Estimate Generation
func generatePDFDocument(estimate: Estimate, selectedDocTypeName: String?) -> Data? {
    let pdfMetaData = [
        kCGPDFContextCreator: mockBusiness.businessName,
        kCGPDFContextAuthor: "Jessica VanDusen",
        kCGPDFContextTitle: selectedDocTypeName ?? "Estimate",
        kCGPDFContextSubject: "Customer Estimate PDF",
        kCGPDFContextKeywords: "Estimate, Invoice, \(mockBusiness.businessName), \(estimate.customer.customerName)"
    ]
    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = pdfMetaData as [String: Any]
    
    let pageWidth = 8.5 * 72.0
    let pageHeight = 11.0 * 72.0
    let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
    
    let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
    
    return renderer.pdfData { context in
        context.beginPage()
        let headerWidgets = createDynamicHeaderWidgets(for: estimate, selectedDocTypeName: selectedDocTypeName)
        drawHeader(widgets: headerWidgets, in: pageRect)
        drawBody(for: estimate, in: pageRect, context: context.cgContext)
        drawFooter(with: estimate.notes ?? "Thank you for your business!", in: pageRect, context: context.cgContext)
    }
}




//Filters the data to data readable by the view (UI view)
struct PDFPreviewView: UIViewRepresentable {
    
    let pdfData: Data

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: pdfData)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}



//TODO: - Generate: Invoice based on Estimate.....

