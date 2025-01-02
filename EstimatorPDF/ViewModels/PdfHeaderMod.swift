////
////  PdfHeaderMod.swift
////  EstimatorPDF
////
////  Created by Jessica VanDusen on 2025-01-05.
////

import Foundation
import PDFKit
import SwiftUI
import UIKit

// MARK: Header Class
struct HeaderWidget {
    let text: String ///This updates the text size correct?
    let font: UIFont ///this makes it so i can update the font?
    let color: UIColor ///The colour?
    let alignment: NSTextAlignment ///And the alignment??
}
//Classes of the Document sections. Combined is the BaseDocument?
class DocumentHeaderData: ObservableObject {
    @Published var title: String
    @Published var referenceNumber: String
    @Published var date: String
    @Published var businessInfoHeader: BusinessModel
    @Published var customerInfoHeader: Customer
    @Published var estimate: EstimateModel
    
    init(title: String, referenceNumber: String, date: String, businessInfoHeader: BusinessModel, customerInfoHeader: Customer, estimate: EstimateModel) {
        self.title = title
        self.referenceNumber = referenceNumber
        self.date = date
        self.businessInfoHeader = businessInfoHeader
        self.customerInfoHeader = customerInfoHeader
        self.estimate = estimate
    }
}

// MARK: - PDF Rendering Functions
// Draw the header for the PDF
func drawHeader(widgets: [HeaderWidget], in bounds: CGRect) {
    let headerHeight: CGFloat = 120
    let headerRect = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: headerHeight)

    for (index, widget) in widgets.enumerated() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = widget.alignment

        let attributes: [NSAttributedString.Key: Any] = [
            .font: widget.font,
            .foregroundColor: widget.color,
            .paragraphStyle: paragraphStyle
        ]

        let yOffset = CGFloat(index) * 25
        let widgetRect = CGRect(x: headerRect.minX + 10,
                                y: headerRect.minY + yOffset,
                                width: headerRect.width - 20,
                                height: 20)

        widget.text.draw(in: widgetRect, withAttributes: attributes)
    }
}
