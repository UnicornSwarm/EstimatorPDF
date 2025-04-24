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
    @Published var documentCatagory: DocTypeEnum?
    
    /// Selected document type (default: .estimate)
    @Published var selectedDocument: DocTypeEnum?
    /// Selected submenu document type
    @Published var selectedSubType: DocTypeEnum?
    
    ///Current Doc showing
    @Published var currentDocument: DocumentModel?
    ///Current Showing in subCatagory
    @Published var selectedImageCategory: ImageCategory? = nil

    
    
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
        return documentCatagory?.rawValue.capitalized ?? DocTypeEnum.estimate.rawValue.capitalized
    }
    
    func selectDocument(named name: String) {
        let lowercasedName = name.lowercased()
        if lowercasedName.contains("estimate") {
            self.currentDocument = EstimateModel.generateMockData()
        } else if lowercasedName.contains("invoice") {
            self.currentDocument = InvoiceModel.generateMockData()
        } else if lowercasedName.contains("image") {
            // Handle image documents
        } else if lowercasedName.contains("financial") {
            // Handle financial documents
        } else if lowercasedName.contains("legal") {
            // Handle legal documents
        } else if lowercasedName.contains("personallegal") {
            // Handle personal legal documents
        }
        // Handle more types cleanly later
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
        guard let docType = documentCatagory else {
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
        guard let docType = documentCatagory else { return [] }
        
        if docType.hasSubcategories {
            // Return the subcategories
            return ImageCategory.allCases.map { $0.rawValue.capitalized }
        } else {
            // Return normal documents
            return docType.loadDocuments()
        }
    }
    
    ///method to get submenu items for list
    func getImageDocuments() -> [String] {
        guard let category = selectedImageCategory else { return [] }
        return category.loadDocuments()
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
        documentCatagory = nil
    }
    
    
    
    //MARK: - Update methods
    /// ✅ Save PDF Data to File
       func savePDFData(data: Data) -> URL? {
           let fileManager = FileManager.default
           let docsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
           let timestamp = Int(Date().timeIntervalSince1970)
           let pdfURL = docsDir.appendingPathComponent("Export_\(timestamp).pdf")
           
           do {
               try data.write(to: pdfURL)
               return pdfURL
           } catch {
               print("❌ Error saving PDF: \(error)")
               return nil
           }
       }
   }
//I have like 3 save funcs????
    
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

