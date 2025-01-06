//
//  PdfHeaderMod.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-05.
//

import Foundation
import PDFKit
import SwiftUI
import UIKit

//MARK: - Estimate-Header, Block
func createPDFHeader(for estimate: Estimate, selectedDocTypeName: String,  in context: CGContext, bounds: CGRect) {
    
    let docTypeName = selectedDocTypeName
    let headerFont = UIFont.boldSystemFont(ofSize: 18)
    let subHeaderFont = UIFont.systemFont(ofSize: 14)
    let padding: CGFloat = 10
    var currentY = bounds.minY + 20 /// Start at the top of the page
    
    //Title
    //TODO: (Can be Updataed by user)
    let headerTitle = "\(docTypeName)"
    let titleAttributes: [NSAttributedString.Key: Any] = [.font: headerFont, .foregroundColor: UIColor.black]
    let titleSize = headerTitle.size(withAttributes: titleAttributes)
    
    let titleRect = CGRect(x: bounds.midX - (titleSize.width / 2), y: currentY, width: titleSize.width, height: titleSize.height)
    headerTitle.draw(in: titleRect, withAttributes: titleAttributes)
    currentY += titleSize.height + padding

    // Subtitle (e.g., Refrence Number,  Date)
    //TODO:  ref# = UUID 4-5 digi's, + 2 digi's of the year.
    //TODO: date basic, year/month/day, Time option(infered from local device) ||  With menu to date things forward or back
    let headerSubtitle = "Ref: \(estimate.referenceNumber) | Date: \(estimate.date)"
    let subtitleAttributes: [NSAttributedString.Key: Any] = [.font: subHeaderFont, .foregroundColor: UIColor.darkGray]
    let subtitleSize = headerSubtitle.size(withAttributes: subtitleAttributes)
    
    let subtitleRect = CGRect(x: bounds.midX - (subtitleSize.width / 2), y: currentY, width: subtitleSize.width, height: subtitleSize.height)
    headerSubtitle.draw(in: subtitleRect, withAttributes: subtitleAttributes)
    currentY += subtitleSize.height + padding

    /// Business Info
    //TODO: Make letter head style, name/bio/address/Image display(Logo), with background banner, so highlight their letter head section, like a business card.
    let businessName = mockBusiness.businessName
    let businessAttributes: [NSAttributedString.Key: Any] = [.font: subHeaderFont, .foregroundColor: UIColor.black]
    
    let businessRect = CGRect(x: bounds.minX + 20, y: currentY, width: bounds.width - 40, height: 20)
    businessName.draw(in: businessRect, withAttributes: businessAttributes)
    currentY += 20 + padding

    /// Customer Info(name, product-being-serviced(vehicle, computer, ie something being repaired or altered but the base object in the incoice/estimate belonging to the customer)? <Optional>)
    let customerInfo = "Customer: \(estimate.customer.customerName)"
    let customerAttributes: [NSAttributedString.Key: Any] = [.font: subHeaderFont, .foregroundColor: UIColor.black]
    
    let customerRect = CGRect(x: bounds.minX + 20, y: currentY, width: bounds.width - 40, height: 20)
    customerInfo.draw(in: customerRect, withAttributes: customerAttributes)
    currentY += 20 + padding

    /// Additional Info (References, Notes)
    let additionalInfo = "Notes: \(estimate.notes ?? "Thank you for your business!")"
    let additionalAttributes: [NSAttributedString.Key: Any] = [.font: subHeaderFont, .foregroundColor: UIColor.darkGray]
    
    let additionalRect = CGRect(x: bounds.minX + 20, y: currentY, width: bounds.width - 40, height: 20)
    additionalInfo.draw(in: additionalRect, withAttributes: additionalAttributes)
}
