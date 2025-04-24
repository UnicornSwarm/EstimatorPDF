//
//  ViewSnapshotExtension.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-04-27.
//


import SwiftUI

///Renders the Save to PDF fuction as a proper size format
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        // Set the correct size
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
}



