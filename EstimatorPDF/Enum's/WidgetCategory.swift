//
//  WidgetCategory.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-04-30.
//


import Foundation
import SwiftUI
// MARK: --
// MARK: - Document Section Struct
enum WidgetData {
    case header([HeaderWidget])
    case body([BodyWidget])
    case footer([FooterWidget])
}

struct DocumentSection {
    let name: String
    let layout: SectionLayout
    let widgets: WidgetData
}

enum SectionLayout {
    case header
    case body
    case footer
}

struct PDFMetaData {
    let title: String
    let author: String
    let subject: String
    let keywords: String
    let creationDate: Date?

    var asDictionary: [String: Any] {
        return [
            kCGPDFContextTitle as String: title,
            kCGPDFContextAuthor as String: author,
            kCGPDFContextSubject as String: subject,
            kCGPDFContextKeywords as String: keywords
            // `creationDate` isn't usually supported here but could be embedded elsewhere if needed
        ]
    }
}
