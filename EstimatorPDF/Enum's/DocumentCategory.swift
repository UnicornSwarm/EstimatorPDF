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
    
    var id: UUID { get set }
    var title: String { get set }
    var date: Date { get set }
    var sections: [DocumentSection] { get set }
    var docType: DocTypeEnum { get }

    func loadDocuments() -> [String]
    static func generateMockData() -> Self
}

///Too store and search document files, and subfiles.
protocol DocumentCategory {
    var title: String { get }
    func loadDocuments() -> [String]
}



// MARK: - Main Document Types Enum
enum DocTypeEnum: String, CaseIterable {
    
    case estimate
    case invoice
    case image
    case financial
    case legal
    case personalLegal
    
    func loadDocuments() -> [String] {
        switch self {
        case .estimate:
            return ["Estimate1.pdf", "Estimate2.pdf"]
        case .invoice:
            return ["Invoice1.pdf", "Invoice2.pdf"]
        case .image:
            // Instead of returning actual files, return ImageCategories first
            return ImageCategory.allCases.map { $0.rawValue.capitalized }
        case .financial:
            return FinancialCatagory.allCases.map { $0.rawValue.capitalized }
        case .legal:
            return LegalCatagory.allCases.map { $0.rawValue.capitalized }
        case .personalLegal:
            return LegalPersonalCatagory.allCases.map { $0.rawValue.capitalized }
        }
    }
    
    /// Returns whether this DocTypeEnum has subcategories
    var hasSubcategories: Bool {
        switch self {
        case .image:
            return true
        case .financial:
            return true
        case .legal:
            return true
        case .personalLegal:
            return true
        default:
            return false
        }
    }
}





// MARK: - Financial Document Subcategories
enum FinancialCatagory: String, CaseIterable {
    
    case bankStatement, financialReport, cashFlowStatement, balanceSheet, incomeStatement, taxes, payroll, receipts, properties, vehicles, cards, contracts, insurances, businessPlan, shareholdersPartnerships, investments, charitableContributions
    
    func loadDocuments() -> [String] {
        switch self {
            
        case .bankStatement: return ["BankStatement1.pdf", "BankStatement2.pdf"]
        case .financialReport: return ["FinancialReport.pdf", "FinancialReport2.pdf"]
        case .cashFlowStatement: return ["cashFlowStatement.pdf", "cashFlowStatement2.pdf"]
        case .balanceSheet: return ["BalanceSheet.pdf", "BalanceSheet2.pdf"]
        case .incomeStatement: return ["IncomeStatement.pdf", "IncomeStatement2.pdf"]
        case .taxes: return ["Taxes.pdf", "Taxes2.pdf"]
        case .payroll: return ["Payroll.pdf", "Payroll2.pdf"]
        case .receipts: return ["Receipts.pdf", "Receipts2.pdf"]
        case .properties: return ["Properties.pdf", "Properties2.pdf"]
        case .vehicles: return ["Vehicles.pdf", "Vehicles2.pdf"]
        case .cards: return ["Cards.pdf", "Cards2.pdf"]
        case .contracts: return ["Contracts.pdf", "Contracts2.pdf"]
        case .insurances: return ["Insurances.pdf", "Insurances2.pdf"]
        case .businessPlan: return ["BusinessPlan.pdf", "BusinessPlan2.pdf"]
        case .shareholdersPartnerships: return ["ShareholdersPartnerships.pdf", "ShareholdersPartnerships2.pdf"]
        case .investments: return ["1nvestments.pdf", "Investments2.pdf"]
        case .charitableContributions: return ["CharitableContributions.pdf", "CharitableContributions2.pdf"]
            
        }
    }
}

// MARK: - Legal Document Subcategories
enum LegalCatagory: String, CaseIterable {
    
    case policies, termsAndConditions, privacyPolicy, legalAgreement, businessRegistration, businessLicense, naics

    func loadDocuments() -> [String] {
        switch self {
            
        case .policies: return []
        case .termsAndConditions: return []
        case .privacyPolicy: return []
        case .legalAgreement: return []
        case .businessRegistration: return []
        case .businessLicense: return []
        case .naics: return []
            
        }
    }
}

// MARK: - Personal Legal Document Subcategories
enum LegalPersonalCatagory: String, CaseIterable {
    
    case will, trust, estate, powerOfAttorney, livingWill

    func loadDocuments() -> [String] {
        
        switch self {
        case .will: return []
        case .trust: return []
        case .estate: return []
        case .powerOfAttorney: return []
        case .livingWill: return []
            
        }
    }
}

