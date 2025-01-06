//
//  DocManager.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-05.
//

import Foundation
import SwiftUI

// Example usage of DocumentManager:
// let docManager = DocumentManager()

class DocumentManager: ObservableObject {
    
    // MARK: - Properties
    
    /// Selected document type (default: .estimate)
    @Published var selectedDocType: DocTypeEnum? = .estimate
    
    ///  // Default mock estimate, to start
    @Published var estimate: Estimate = mockEstimate
    
    /// Selected submenu document type
    @Published var selectedSubType: DocumentType?
    
    // MARK: - Derived Properties
    
    /// Dynamically derived name of the selected document type
    /// - If no type is selected, returns "Estimate".
    /// Example usage:
    /// ```
    /// let docManager = DocumentManager()
    /// print(docManager.selectedDocTypeName) // Output: "Estimate"
    /// docManager.selectedDocType = .invoice
    /// print(docManager.selectedDocTypeName) // Output: "Invoice"
    /// ```
    var selectedDocTypeName: String {
        return selectedDocType?.rawValue.capitalized ?? DocTypeEnum.estimate.rawValue.capitalized
    }
    
    // MARK: - Menu Functions
    
    /// Get the list of document options for the selected type
    /// - If no type is selected, defaults to `.estimate` documents.
    /// Example usage:
    /// ```
    /// let docManager = DocumentManager()
    /// print(docManager.getDocMenuOpt()) // Output: ["Estimate1.pdf", "Estimate2.pdf"]
    /// docManager.selectedDocType = .invoice
    /// print(docManager.getDocMenuOpt()) // Output: ["Invoice1.pdf", "Invoice2.pdf"]
    /// ```
    func getDocMenuOpt() -> [String] {
        guard let docType = selectedDocType else {
            return DocTypeEnum.estimate.loadDocuments()
        }
        return docType.loadDocuments()
    }
    
    //MARK: Fetch the main menu options (top-level document types)
    
    /// - Returns a list of all document types in a capitalized format.
    /// Example usage:
    /// ```
    /// let docManager = DocumentManager()
    /// print(docManager.getMainMenuOptions()) // Output: ["Estimate", "Invoice"]
    /// ```
    func getMainMenuOptions() -> [String] {
        return DocTypeEnum.allCases.map { $0.rawValue.capitalized }
    }
    
    //MARK: Fetch the submenu options based on the selected document type
    /// - Returns a list of documents for the selected type.
    /// Example usage:
    /// ```
    /// let docManager = DocumentManager()
    /// docManager.selectedDocType = .invoice
    /// print(docManager.getSubMenuOptions()) // Output: ["Invoice1.pdf", "Invoice2.pdf"]
    /// ```
    func getSubMenuOptions() -> [String] {
        guard let docType = selectedDocType else { return [] }
        return docType.loadDocuments()
    }
    
    //MARK: Reset to the main menu defaults
    
    /// - Clears the current selections and resets to defaults.
    /// Example usage:
    /// ```
    /// let docManager = DocumentManager()
    /// docManager.selectedDocType = .invoice
    /// docManager.resetToMainMenu()
    /// print(docManager.getDocMenuOpt()) // Output: ["Estimate1.pdf", "Estimate2.pdf"]
    /// ```
    func resetToMainMenu() {
        selectedSubType = nil
        selectedDocType = nil
    }
    
    // Add methods to update the estimate as needed
    func updateEstimate(newEstimate: Estimate) {
        self.estimate = newEstimate
    }
}
