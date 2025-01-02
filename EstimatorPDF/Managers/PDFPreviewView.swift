//
//  PDFPreviewView.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-04-11.
//
import Foundation
import SwiftUI
import PDFKit

struct PDFPreviewView: UIViewRepresentable {
    let pdfData: Data

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: pdfData)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}
