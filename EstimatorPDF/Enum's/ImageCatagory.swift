//
//  ImageCatagory.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-04-30.
//

import Foundation
import SwiftUI

// MARK: - Image model
struct ImageModel: Identifiable {
    
    let id: UUID
    let title: String
    let category: ImageCategory
    let imageName: String // File name or reference
    let dateAdded: Date
}


// Image sub-catagoey types
enum ImageCategory: String, CaseIterable, DocumentCategory {
    
    case receipts, licenses, awards, rewards, events, jobs, reports, signatures
    
    var title: String {
            rawValue.capitalized
        }

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
