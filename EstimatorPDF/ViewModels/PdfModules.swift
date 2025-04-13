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

////MARK: HEADER
//func createDynamicHeader(for document: BaseDocument, business: BusinessModel, customer: Customer) -> [HeaderWidget] {
//    return [
//        HeaderWidget(
//            text: document.title.capitalized,
//            font: UIFont.boldSystemFont(ofSize: 18),
//            color: .black,
//            alignment: .center
//        ),
//        HeaderWidget(
//            text: "Ref: \(document.id.uuidString.prefix(6)) | Date: \(DateFormatter.localizedString(from: document.date, dateStyle: .medium, timeStyle: .none))",
//            font: UIFont.systemFont(ofSize: 14),
//            color: .darkGray,
//            alignment: .justified
//        ),
//        HeaderWidget(
//            text: "\(business.businessName)",
//            font: UIFont.systemFont(ofSize: 14),
//            color: .black,
//            alignment: .left
//        ),
//        HeaderWidget(
//            text: "Customer: \(customer.customerName)",
//            font: UIFont.systemFont(ofSize: 14),
//            color: .black,
//            alignment: .right
//        )
//    ]
//}
////MARK: BODY
//func createDynamicBody(for items: [TrackableItem], additionalDetails: String?) -> [BodyWidget] {
//    var widgets: [BodyWidget] = items.map { item in
//        BodyWidget(
//            text: "\(item.title): \(item.description) | Qty: \(item.quantity) | Unit Price: $\(item.unitPrice) | Total: $\(item.totalPrice)",
//            font: UIFont.systemFont(ofSize: 12),
//            color: .black,
//            alignment: .left
//        )
//    }
//
//    if let details = additionalDetails {
//        widgets.append(
//            BodyWidget(
//                text: details,
//                font: UIFont.italicSystemFont(ofSize: 12),
//                color: .darkGray,
//                alignment: .left
//            )
//        )
//    }
//
//    return widgets
//}
//
////MARK: FOOTER
//func createDynamicFooter(notes: String, disclaimer: String?) -> [FooterWidget] {
//    var widgets: [FooterWidget] = [
//        FooterWidget(
//            text: notes,
//            font: UIFont.systemFont(ofSize: 12),
//            color: .gray,
//            alignment: .center
//        )
//    ]
//
//    if let disclaimer = disclaimer {
//        widgets.append(
//            FooterWidget(
//                text: disclaimer,
//                font: UIFont.italicSystemFont(ofSize: 10),
//                color: .lightGray,
//                alignment: .center
//            )
//        )
//    }
//
//    return widgets
//}


protocol WidgetProtocol {
    var title: String { get }
    var text: String { get } ///This updates the text size correct?
    var font: UIFont { get }///this makes it so i can update the font?
    var color: UIColor { get }///The colour?
    var alignment: NSTextAlignment { get }///And the alignment??
    // You can add more shared rendering data here
}

struct HeaderWidget: WidgetProtocol {
    var title: String
    var subtitle: String
    var text: String ///This updates the text size correct?
    var font: UIFont ///this makes it so i can update the font?
    var color: UIColor ///The colour?
    var alignment: NSTextAlignment ///And the alignment??

}

struct BodyWidget: WidgetProtocol {
    var title: String
    var content: String
    var text: String ///This updates the text size correct?
    var font: UIFont ///this makes it so i can update the font?
    var color: UIColor ///The colour?
    var alignment: NSTextAlignment ///And the alignment??
}

struct FooterWidget: WidgetProtocol {
    var title: String
    var notes: String
    var text: String ///This updates the text size correct?
    var font: UIFont ///this makes it so i can update the font?
    var color: UIColor ///The colour?
    var alignment: NSTextAlignment ///And the alignment?
}



// MARK: Widget Rendering
func renderWidgets<T: WidgetProtocol>(_ widgets: [T], in context: CGContext, at yStart: CGFloat, pageRect: CGRect) -> CGFloat {
    var yOffset = yStart
    for widget in widgets {
        // Example: simple rendering logic
        let text = widget.title  // All your widgets seem to have `title`
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string: text, attributes: attributes)

        let textRect = CGRect(x: 20, y: yOffset, width: pageRect.width - 40, height: 20)
        attributedText.draw(in: textRect)

        yOffset += 30  // adjust based on content height
    }
    return yOffset
}


// MARK: Modular PDF Generation
func generatePDF(from sections: [DocumentSection], meta: PDFMetaData) -> Data? {
    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = meta.asDictionary

    let pageWidth = 8.5 * 72.0
    let pageHeight = 11 * 72.0
    let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

    let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

    let data = renderer.pdfData { context in
        context.beginPage()

        var yOffset: CGFloat = 20.0

        for section in sections {
            switch section.widgets {
            case .header(let widgets):
                yOffset = renderWidgets(widgets, in: context.cgContext, at: yOffset, pageRect: pageRect)
            case .body(let widgets):
                yOffset = renderWidgets(widgets, in: context.cgContext, at: yOffset, pageRect: pageRect)
            case .footer(let widgets):
                yOffset = renderWidgets(widgets, in: context.cgContext, at: yOffset, pageRect: pageRect)
            }
        }
    }

    return data
}

