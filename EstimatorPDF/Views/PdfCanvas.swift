import SwiftUI
import PDFKit


struct PdfCanvas: View {
    
    @EnvironmentObject var docManager: DocumentManager
    @State private var showDocList = false
    @State var selectedMainTypeWithSubmenu: DocTypeEnum?
    
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    
                    Menu {
                        ForEach(docManager.getMainMenuOptions(), id: \.self) { docOption in
                            Button(action: {
                                if let docType = DocTypeEnum(rawValue: docOption.lowercased()) {
                                    docManager.documentCatagory = docType
                                    docManager.selectDocument(named: docOption)
                                }
                            }) {
                                Text(docOption)
                            }
                        }
                    } label: {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                
                Spacer()
                
                
                DocumentDisplayView()
                    .padding()
                
                
                Button(action: saveAsPDF) {
                    Text("Save as PDF")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
    
    
    private func saveAsPDF() {
        
        let pageSize = CGSize(width: 595.2, height: 841.8) // A4 size

        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))

        let data = pdfRenderer.pdfData { context in
            context.beginPage()

            let hostingController = UIHostingController(rootView: DocumentDisplayView().environmentObject(docManager))
            let view = hostingController.view!
            view.frame = CGRect(origin: .zero, size: pageSize)
            view.backgroundColor = .white

            let renderer = UIGraphicsImageRenderer(size: pageSize)
            let image = renderer.image { _ in
                view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            }

            image.draw(in: CGRect(origin: .zero, size: pageSize))
        }

        if let savedURL = docManager.savePDFData(data: data) {
            print("✅ PDF successfully saved at: \(savedURL.path)")

            // Optionally present the system preview or sharing options
            let activityVC = UIActivityViewController(activityItems: [savedURL], applicationActivities: nil)
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
               let rootVC = keyWindow.rootViewController {
                rootVC.present(activityVC, animated: true)
            }

        } else {
            print("❌ Failed to save PDF")
        }
    }

}
    

#Preview {
    PdfCanvas()
        .environmentObject(DocumentManager())
}

