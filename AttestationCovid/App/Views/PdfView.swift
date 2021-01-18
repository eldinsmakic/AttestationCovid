//
//  PdfView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 26/12/2020.
//


import SwiftUI
import PDFKit
import UIKit

struct PdfViewToSwifUI: UIViewRepresentable {
    typealias UIViewType = PDFView

        let url: URL

        init(url : URL) {
            self.url = url
        }

        func makeUIView(context: Context) -> PDFView {
           let pdfView = PDFView()

            pdfView.document = PDFDocument(url: url)
            pdfView.displayMode = .singlePageContinuous

            pdfView.autoScales = true

           return pdfView
       }

       func updateUIView(_ uiView: PDFView, context: Context) {
       }

}

struct PdfView: View {
    let url = URL(string: "helo")!
    var body: some View {
        VStack {
            PdfViewToSwifUI(url: url)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
    }
}
