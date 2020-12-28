//
//  PdfView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 26/12/2020.
//


import SwiftUI
import PDFKit
import UIKit

let url = Bundle.main.url(forResource: "attestation", withExtension: "pdf", subdirectory: nil, localization: nil)


struct PdfViewToSwifUI: UIViewRepresentable {
    typealias UIViewType = PDFView
        var url: URL?

        init(url : URL?) {
            self.url = url
        }

        func makeUIView(context: Context) -> PDFView {
           let pdfView = PDFView()

           if let url = url {

              pdfView.document = PDFDocument(url: url)
              pdfView.displayMode = .singlePage

              pdfView.autoScales = true
              test()
           }


           return pdfView
       }

       func updateUIView(_ uiView: PDFView, context: Context) {
       }

}

struct PdfView: View {

    var body: some View {
        VStack {
            PdfViewToSwifUI(url: url)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
    }
}

func test() {
    let pdf = PDFDocument(url: url!)


    print("test")

    if let pdf = pdf {
        drawText(text: "01/02/1994", x: 119, y: 645, font: font, to: pdf)
//      
        print("drawned")
        print(pdf.allowsDocumentChanges)
        let annotation = PDFAnnotation(bounds: CGRect(x: 100, y: 100, width: 100, height: 100), forType: .freeText, withProperties: nil)
       annotation.contents = "Hello, world!"
        annotation.font = UIFont.systemFont(ofSize: 40.0)
       annotation.fontColor = .blue
       annotation.color = .clear
       pdf.page(at: 0)!.addAnnotation(annotation)
        let page = PDFPage()
        page.addAnnotation(annotation)
        print(pdf.page(at: 0)?.annotations)
        pdf.insert(page, at: 1)

        if let data = pdf.dataRepresentation() {
          try? data.write(to: url!)
            print("saving")
        }
    }
//        do {
//            if let data = pdf.dataRepresentation() {
//
//                var url = pdf.documentURL?.deletingLastPathComponent()
//                url = url?.appendingPathComponent("attes2.pdf")
//
//                let fileManager = FileManager.default
//                let urls = fileManager.urls(for: .userDirectory, in: .userDomainMask)
//                    if let applicationSupportURL = urls.last {
//                        do{
//                            try fileManager.createDirectory(at: applicationSupportURL, withIntermediateDirectories: true, attributes: nil)
//                            let testUrl = applicationSupportURL
//                            testUrl.appendingPathComponent("attes2.pdf")
//                            print(testUrl.absoluteURL)
//                            try data.write(to: testUrl, options: [.noFileProtection, .atomicWrite])
//                        }
//                        catch{
//                            print(error)
//                        }
//                    }
//
//
////                try data.write(to: pdf.documentURL!.absoluteURL)
//
//
//                print("Write to fill" )
//            }
//            print("hh")
//        } catch let error {
//            print(error)
//        }
//    }

}



