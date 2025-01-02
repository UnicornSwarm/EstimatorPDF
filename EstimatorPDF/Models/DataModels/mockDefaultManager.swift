//
//  mockDefaultManager.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-06.
//

import Foundation


//MARK: Default Manager
class DocumentDefaults {
    
    static let shared = DocumentDefaults()
    
    // Default document type (reuse MockDefaultManager)
    static var defaultDocType: BaseDocument {
        get { DocumentDefaults.shared.getDefaultDocType() }
        set { DocumentDefaults.shared.setDefaultDocType(newValue) }
    }
    
    private var defaultTheme: String = "Light"
    private var defaultUserRole: String = "Guest"
    
    // Accessor methods
    func getDefaultDocType() -> BaseDocument {
        return DocumentDefaults.defaultDocType
    }
    
    func setDefaultDocType(_ docType: BaseDocument) {
        DocumentDefaults.defaultDocType = docType
    }
    
    // You need to pass the DocumentManager instance here
    func userSelectedDocType(docType: DocTypeEnum, docManager: DocumentManager) {
        // Now you can safely update the `selectedDocType` in DocumentManager
        docManager.selectedDocType = docType
    }
    
}


