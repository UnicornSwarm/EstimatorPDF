//
//  FileTypeEnum.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-04.
//

import Foundation
import SwiftUI

protocol DocumentType {
    func loadDocuments() -> [String]
}

// Main Menu Documents
enum DocTypeEnum: String, CaseIterable, DocumentType {
    case estimate, invoice, image, financials, legal, legalPersonal
    
    func loadDocuments() -> [String] {
        switch self {
        case .estimate: return ["Estimate1.pdf", "Estimate2.pdf"]
        case .invoice: return ["Invoice1.pdf", "Invoice2.pdf"]
        case .image: return ["image1.png", "image2.jpg"]
        case .financials: return Financials.allCases.map { $0.rawValue }
        case .legal: return Legal.allCases.map { $0.rawValue }
        case .legalPersonal: return LegalPersonal.allCases.map { $0.rawValue }
        }
    }
}

// Submenu Documents
enum Financials: String, CaseIterable, DocumentType {
    case bankStatement = "Bank Statement", financialReport = "Financial Report", cashFlowStatement = "Cash Flow Statement", balanceSheet = "Balance Sheet", incomeStatement = "Income Statement", taxes, payroll, receipts, properties, vehicles, cards, contracts, insurances, businessPlan = "Business Plan", shareholdersPartnerships = "Shareholders Partnerships", investments, charitableContributions = "Charitable Contributions"
    
    func loadDocuments() -> [String] {
        switch self {
        case .bankStatement: return ["BankStatement1.pdf", "BankStatement2.pdf"]
        case .financialReport: return ["FinancialReport1.pdf", "FinancialReport2.pdf"]
        case .cashFlowStatement: return ["CashFlowStatement1.pdf", "CashFlowStatement2.pdf"]
        case .balanceSheet: return ["BalanceSheet1.pdf", "BalanceSheet2.pdf"]
        case .incomeStatement: return ["IncomeStatement1.pdf", "IncomeStatement2.pdf"]
        case .taxes: return ["Tax1.pdf", "Tax2.pdf"]
        case .payroll: return ["Payroll1.pdf", "Payroll2.pdf"]
        case .receipts: return ["Receipt1.pdf", "Receipt2.pdf"]
        case .properties: return ["Property1.pdf", "Property2.pdf"]
        case .vehicles: return ["Vehicle1.pdf", "Vehicle2.pdf"]
        case .cards: return ["Card1.pdf", "Card2.pdf"]
        case .contracts: return ["Contract1.pdf", "Contract2.pdf"]
        case .insurances: return ["Insurance1.pdf", "Insurance2.pdf"]
        case .businessPlan: return ["BusinessPlan1.pdf", "BusinessPlan2.pdf"]
        case .shareholdersPartnerships: return ["ShareholdersPartnerships1.pdf", "ShareholdersPartnerships2.pdf"]
        case .investments: return ["Investment1.pdf", "Investment2.pdf"]
        case .charitableContributions: return ["CharitableContributions1.pdf", "CharitableContributions2.pdf"]
        }
    }
}

// Submenu for Legal Documents
enum Legal: String, CaseIterable {
    case policies, termsAndConditions = "Terms and Conditions", privacyPolicy = "Privacy Policy", legalAgreement = "Legal Agreement", businessRegistration = "Business Registration", businessLicense = "Business License", naics = "NAICS"
    
    func loadDocuments() -> [String] {
        switch self {
        case .policies: return ["Policy1.pdf", "Policy2.pdf"]
        case .termsAndConditions: return ["Terms.pdf", "Conditions.pdf"]
        case .privacyPolicy: return ["PrivacyPolicy1.pdf", "PrivacyPolicy2.pdf"]
        case .legalAgreement: return ["LegalAgreement1.pdf", "LegalAgreement2.pdf"]
        case .businessRegistration: return ["BusinessRegistration1.pdf", "BusinessRegistration2.pdf"]
        case .businessLicense: return ["BusinessLicense1.pdf", "BusinessLicense2.pdf"]
        case .naics: return ["NAICS1.pdf", "NAICS2.pdf"]
        }
    }
}

// Submenu for Personal Legal Documents
enum LegalPersonal: String, CaseIterable {
    case will, trust, estate, powerOfAttorney = "Power of Attorney", livingWill = "Living Will"
    
    func loadDocuments() -> [String] {
        switch self {
        case .will: return ["Will1.pdf", "Will2.pdf"]
        case .trust: return ["Trust1.pdf", "Trust2.pdf"]
        case .estate: return ["Estate1.pdf", "Estate2.pdf"]
        case .powerOfAttorney: return ["POA1.pdf", "POA2.pdf"]
        case .livingWill: return ["LivingWill1.pdf", "LivingWill2.pdf"]
        }
    }
}
