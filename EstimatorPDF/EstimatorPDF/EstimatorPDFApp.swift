//
//  EstimatorPDFApp.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-02.
//

import SwiftUI

@main
struct EstimatorPDFApp: App {
    
    @StateObject var documentManager = DocumentManager()
    
    var body: some Scene {
        WindowGroup {
            PdfCanvas()
                .environmentObject(documentManager)
        }
    }
}
