//
//  PdfBodyMod.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-04.
//

import Foundation
import CoreGraphics
import UIKit
import PDFKit

//MARK: - Estimate-Body, Block
func createPDFBody(for estimate: Estimate, in context: CGContext, bounds: CGRect) {
    let bodyFont = UIFont.systemFont(ofSize: 14)
    let attributes: [NSAttributedString.Key: Any] = [.font: bodyFont]
    
    var yOffset = bounds.maxY - 100
    for item in estimate.items {
        let lineText = "\(item.title) \(item.description) \(item.unitPrice) x \(item.quantity) = \(item.totalPrice)"
        
        let textRect = CGRect(x: bounds.minX + 20, y: yOffset, width: bounds.width - 40, height: 20)
        lineText.draw(in: textRect, withAttributes: attributes)
        yOffset -= 25
    }
}
