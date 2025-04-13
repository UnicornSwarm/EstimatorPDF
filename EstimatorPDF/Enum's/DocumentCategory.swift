//
//  DocTypeEnum.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-04.
//

import Foundation
import SwiftUI

// MARK: - Document Model Protocol
protocol DocumentModel: BaseDocument {
    var sections: [DocumentSection] { get }
    func generateMockData() -> Self
}


// MARK: - Document Type Enum
enum DocumentType {
    case estimate(EstimateModel)
    case invoice(InvoiceModel)
    case image(ImageModel)
    case financial(FinancialType)
    case legal(LegalType)
    case personalLegal(LegalPersonalType)
}

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



// MARK: - Main Document Types Enum
enum DocTypeEnum: String, CaseIterable { //Name change? 
    case estimate, invoice, image, financial, legal, personalLegal

    func loadDocuments() -> [String] {
        switch self {
        case .estimate:
            return EstimateModel.generateMock().sections.map { $0.name }
        case .invoice:
            return InvoiceModel.generateMock().sections.map { $0.name }
        case .image:
            return ImageCategory.allCases.flatMap { $0.loadDocuments() }
        case .financial:
            return FinancialType.allCases.flatMap { $0.loadDocuments() }
        case .legal:
            return LegalType.allCases.flatMap { $0.loadDocuments() }
        case .personalLegal:
            return LegalPersonalType.allCases.flatMap { $0.loadDocuments() }
        }
    }
}


// MARK: - Image Document Type & Subcategories
struct ImageModel: Identifiable {
    let id: UUID
    let title: String
    let category: ImageCategory
    let imageName: String // File name or reference
    let dateAdded: Date
}

enum ImageCategory: String, CaseIterable {
    case receipts, licenses, awards, rewards, events, jobs, reports, signatures

    func loadDocuments() -> [String] {
        switch self {
        case .receipts: return ["Receipt1.jpg", "Receipt2.jpg"]
        case .licenses: return ["License1.jpg", "License2.jpg"]
        case .awards: return ["Award1.jpg", "Award2.jpg"]
        case .rewards: return ["Reward1.jpg", "Reward2.jpg"]
        case .events: return ["Event1.jpg", "Event2.jpg"]
        case .jobs: return ["Job1.jpg", "Job2.jpg"]
        case .reports: return ["Report1.jpg", "Report2.jpg"]
        case .signatures: return ["Signature1.png", "Signature2.png"]
        }
    }
}

// MARK: - Financial Document Subcategories
enum FinancialType: String, CaseIterable {
    case bankStatement = "Bank Statement", financialReport = "Financial Report", cashFlowStatement = "Cash Flow Statement"
    case balanceSheet = "Balance Sheet", incomeStatement = "Income Statement", taxes, payroll, receipts
    case properties, vehicles, cards, contracts, insurances, businessPlan = "Business Plan"
    case shareholdersPartnerships = "Shareholders Partnerships", investments, charitableContributions = "Charitable Contributions"

    func loadDocuments() -> [String] {
        return [self.rawValue + "1.pdf", self.rawValue + "2.pdf"]
    }
}

// MARK: - Legal Document Subcategories
enum LegalType: String, CaseIterable {
    case policies, termsAndConditions = "Terms and Conditions", privacyPolicy = "Privacy Policy"
    case legalAgreement = "Legal Agreement", businessRegistration = "Business Registration"
    case businessLicense = "Business License", naics = "NAICS"

    func loadDocuments() -> [String] {
        return [self.rawValue + "1.pdf", self.rawValue + "2.pdf"]
    }
}

// MARK: - Personal Legal Document Subcategories
enum LegalPersonalType: String, CaseIterable {
    case will, trust, estate, powerOfAttorney = "Power of Attorney", livingWill = "Living Will"

    func loadDocuments() -> [String] {
        return [self.rawValue + "1.pdf", self.rawValue + "2.pdf"]
    }
}
