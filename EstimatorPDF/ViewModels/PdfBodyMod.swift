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

// MARK: Body Class
struct BodyWidget {
    let text: String
    let font: UIFont
    let color: UIColor
    let alignment: NSTextAlignment
}

class DocumentBodyData: ObservableObject {
    @Published var items: [TrackableItem] // Represents dynamic list of items
    @Published var additionalDetails: String? // Optional additional details
    
    init(items: [TrackableItem], additionalDetails: String? = nil) {
        self.items = items
        self.additionalDetails = additionalDetails
    }
}

// Draw the body for the PDF
func drawBody(widgets: [BodyWidget], in bounds: CGRect) {
    let startY: CGFloat = bounds.minY + 140
    var currentY: CGFloat = startY
    
    for widget in widgets {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = widget.alignment
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: widget.font,
            .foregroundColor: widget.color,
            .paragraphStyle: paragraphStyle
        ]
        
        let widgetRect = CGRect(x: bounds.minX + 10,
                                y: currentY,
                                width: bounds.width - 20,
                                height: 20)
        
        widget.text.draw(in: widgetRect, withAttributes: attributes)
        currentY += 25 // Adjust spacing as needed
    }
}




