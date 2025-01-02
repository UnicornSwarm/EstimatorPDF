import SwiftUI
import PDFKit

struct PdfCanvas: View {

    @EnvironmentObject var docManager: DocumentManager
    @State private var showDocList = false

    var body: some View {
        ZStack {
            // Attempt to load PDF data (mocked for now from finalNotes)
            if let pdfData = generatePDFData(from: docManager.currentEstimate!)
            {
                PDFPreviewView(pdfData: pdfData)
                    .ignoresSafeArea()
            } else {
                Text("Unable to load PDF")
                    .foregroundColor(.red)
                    .font(.headline)
            }


            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "list.triangle")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                        .padding()
                        .onTapGesture {
                            showDocList.toggle()
                        }
                }
                Spacer()
            }

            if showDocList {
                VStack(spacing: 0) {
                    Text("Select a Document")
                        .font(.headline)
                        .padding()

                    List(docManager.getMainMenuOptions(), id: \.self) { doc in
                        Text(doc)
                        
                    }
                    .frame(maxHeight: 300)
                    .listStyle(PlainListStyle())
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .padding()
                .background(
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showDocList = false
                        }
                )
            }
        }
    }

    // Placeholder PDF generation method
    func generatePDFData(from document: BaseDocument) -> Data? {
        if let estimate = document as? EstimateModel {
            print("Generating PDF for Estimate: \(estimate.title)")
            return Data() // Replace with actual PDF generation logic
        }
        return nil
    }
}

#Preview {
    PdfCanvas()
        .environmentObject(DocumentManager())
}
