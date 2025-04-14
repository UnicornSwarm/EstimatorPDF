//
//  PdfCanvas.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-02.
//

import SwiftUI
import PDFKit

struct PdfCanvas: View {
    
    @EnvironmentObject var documentManager: DocumentManager // Access DocumentManager
    
    @State private var showDocList = false // Control document list visibility
    
    var defaultPDFData: Data {
        generatePDFDocument(estimate: mockEstimate, selectedDocTypeName: documentManager.selectedDocTypeName) ?? Data()
    } // Generate the PDF using the estimate from the DocumentManager
    
    var body: some View {
        ZStack {
            PDFPreviewView(pdfData: defaultPDFData)
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Spacer() // Push content left
                        Image(systemName: "list.triangle")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                            .padding()
                            .onTapGesture {
                                showDocList.toggle()
                            }
                    }
                    Spacer() // Push content up
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            
            // Document list overlay
            if showDocList {
                VStack {
                    Text("Select a Document")
                        .font(.headline)
                        .padding()
                    List(documentManager.getDocMenuOpt(), id: \.self) { doc in
                        Text(doc)
                            .onTapGesture {
                                // Perform actions on selection, e.g., update selected document
                                print("Selected: \(doc)")
                                showDocList = false
                            }
                    }
                    .frame(maxHeight: 300) // Limit height
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .padding()
                .background(Color.black.opacity(0.5).ignoresSafeArea())
            }
        }
    }
}



#Preview {
    PdfCanvas() // Default mock estimate for previews
        .environmentObject(DocumentManager())
}


