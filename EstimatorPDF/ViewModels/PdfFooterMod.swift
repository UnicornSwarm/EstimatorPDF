//
//  PdfFooterMod.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-04.
//

import Foundation
import CoreGraphics
import UIKit
import PDFKit


// MARK: Footer Class
struct FooterWidget {
    let text: String
    let font: UIFont
    let color: UIColor
    let alignment: NSTextAlignment
}

class DocumentFooterData: ObservableObject {
    @Published var finalNotes: String
    @Published var disclaimer: String? // Optional disclaimer

    init(finalNotes: String, disclaimer: String? = nil) {
        self.finalNotes = finalNotes
        self.disclaimer = disclaimer
    }
}

//MARK: - Estimate-Footer, Block
func createPDFFooter(for estimate: EstimateModel, in context: CGContext, bounds: CGRect) {
    let footerFont = UIFont.systemFont(ofSize: 14)
    let footerText = "Total: \(estimate.total)"
    let attributes: [NSAttributedString.Key: Any] = [.font: footerFont]
    
    let textRect = CGRect(x: bounds.minX + 20, y: bounds.minY + 40, width: bounds.width - 40, height: 20)
    footerText.draw(in: textRect, withAttributes: attributes)
}

// Draw the footer for the PDF
func drawFooter(notes: String, disclaimer: String?, summary: (subtotal: Double, tax: Double, total: Double), in bounds: CGRect) {
    let footerStartY: CGFloat = bounds.maxY - 120
    let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.gray]

    // Draw Notes
    let notesRect = CGRect(x: bounds.minX + 20, y: footerStartY, width: bounds.width - 40, height: 20)
    notes.draw(in: notesRect, withAttributes: attributes)

    // Draw Summary
    let summaryText = """
    Subtotal: $\(summary.subtotal)
    Tax: $\(summary.tax)
    Total: $\(summary.total)
    """
    let summaryRect = CGRect(x: bounds.minX + 20, y: footerStartY + 40, width: bounds.width - 40, height: 60)
    summaryText.draw(in: summaryRect, withAttributes: attributes)

    // Draw Disclaimer
    if let disclaimer = disclaimer {
        let disclaimerRect = CGRect(x: bounds.minX + 20, y: footerStartY + 80, width: bounds.width - 40, height: 20)
        disclaimer.draw(in: disclaimerRect, withAttributes: attributes)
    }
}

