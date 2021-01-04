//
//  ListPDFView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 04/01/2021.
//

import SwiftUI


let url_pdf_file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("pdfs")

var directoryContents = [URL]()

struct ListPDFView: View {
    var body: some View {
        NavigationView {
            VStack {
                List(directoryContents, id: \.self ) { file in
                    NavigationLink(file.lastPathComponent, destination: PdfView())
                }
            }
        }.onAppear {
            if !FileManager.default.fileExists(atPath: url_pdf_file.absoluteString) {
                do {
                    try FileManager.default.createDirectory(at: url_pdf_file, withIntermediateDirectories: true, attributes: nil)

                    directoryContents = try FileManager.default.contentsOfDirectory(at: url_pdf_file, includingPropertiesForKeys: nil, options: [])
                    print(directoryContents)
                } catch {
                    print(error.localizedDescription);
                }
            }
        }
    }
}

struct ListPDFView_Previews: PreviewProvider {
    static var previews: some View {
        ListPDFView()
    }
}
