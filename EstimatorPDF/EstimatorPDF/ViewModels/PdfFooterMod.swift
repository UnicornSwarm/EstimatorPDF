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

//MARK: - Estimate-Footer, Block
func createPDFFooter(for estimate: Estimate, in context: CGContext, bounds: CGRect) {
    let footerFont = UIFont.systemFont(ofSize: 14)
    let footerText = "Total: \(estimate.total)"
    let attributes: [NSAttributedString.Key: Any] = [.font: footerFont]
    
    let textRect = CGRect(x: bounds.minX + 20, y: bounds.minY + 40, width: bounds.width - 40, height: 20)
    footerText.draw(in: textRect, withAttributes: attributes)
}
