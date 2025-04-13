//
//  DocManager.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-05.
//

import Foundation
import SwiftUI
import PDFKit

// Example usage of DocumentManager:
// let docManager = DocumentManager()

class DocumentManager: ObservableObject {
    
    // MARK: - Properties
    /// Selected document type
    @Published var selectedDocType: DocTypeEnum?
    
    /// Selected document type (default: .estimate)
    @Published var selectedDocument: DocumentType = .estimate(EstimateModel.generateMock())

    /// Selected submenu document type
    @Published var selectedSubType: DocumentType?
    
    @Published var currentDocument: BaseDocument?
    
    // ✅ Computed Properties for Active Document Models
    var currentEstimate: EstimateModel? {
        if case .estimate(let model) = selectedDocument {
            return model
        }
        return nil
    }

    var currentInvoice: InvoiceModel? {
        if case .invoice(let model) = selectedDocument {
            return model
        }
        return nil
    }
    
    // Init, other functions, etc.
    init(estimate: EstimateModel = EstimateModel.generateMock()) {
        self.selectedDocument = .estimate(estimate)
    }
    
    //MARK: - default document type ESTIMATE TO START
    var effectiveDocType: DocTypeEnum {
        selectedDocType ?? .estimate
    }
    
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
    
    //MARK: - Fetch methods
    
    
    //MARK: Main menu options (top-level document types)
    
    /// - Returns a list of all document types in a capitalized format.
    /// Example usage:
    /// ```
    /// let docManager = DocumentManager()
    /// print(docManager.getMainMenuOptions()) // Output: ["Estimate", "Invoice"]
    /// ```
    func getMainMenuOptions() -> [String] {
        return DocTypeEnum.allCases.map { $0.rawValue.capitalized }
    } //TODO: Can more than 1 word gets a space?
    
    //MARK: Submenu options based on the selected document type
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
    
    
    //MARK: - Reset to the main menu defaults
    
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
    
    
    
    //MARK: - Update methods
    // Add methods to update the Estimate
    func updateEstimate(newEstimate: EstimateModel) {
        self.selectedDocument = .estimate(newEstimate)
    }

    // Add methods to update the Default Document
    func updateDefaultDocType(to newDefault: DocTypeEnum) {
        DocumentDefaults.shared.setDefaultDocType(newDefault as! BaseDocument)
        print("Default document type updated to: \(newDefault.rawValue)")
    }
    
    
    //MARK: - Shared PDF files
    func sharePDF(data: Data, document: BaseDocument) {
        let docTypeName = document.title
        print("Using document type: \(docTypeName)")
        
        // Create a temporary file URL for the PDF
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(docTypeName).pdf")
        do {
            try data.write(to: tempURL) // Write the data to the temporary file
            
            let activityVC = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil) // Create the activity view controller
            
            // Find the current window scene
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(activityVC, animated: true, completion: nil) // Present the activity view controller
            }
        } catch {
            print("Failed to write PDF to temporary file: \(error.localizedDescription)")
        }
    }
}
