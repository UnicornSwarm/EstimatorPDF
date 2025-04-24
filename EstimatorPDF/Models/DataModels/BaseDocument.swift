//
//  BaseDocument.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-13.
//

import Foundation

protocol BaseDocument {
    var title: String { get set }
    var id: UUID { get set }
    var date: Date { get set }
    var items: [TrackableItem] { get set }
    var finalNotes: String? { get set }
    
    var subtotal: Double { get }
    var tax: Double { get }
    var total: Double { get }
    
    var docType: DocTypeEnum { get }
    
    func loadDocuments() -> [String] // Can be overridden by specific document types
}
