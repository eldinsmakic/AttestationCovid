//
//  ListPDFView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 04/01/2021.
//

import SwiftUI

struct ListPDFView: View {
    let fileManagerPDF = FileManagerPDF.shared
    @State var directoryContents = [URL]()

    var body: some View {
        NavigationView {
            VStack {
                if directoryContents.isEmpty {
                    Text("Aucune attestations pour l'instant")
                } else {
                    List(directoryContents, id: \.self ) { file in
                        NavigationLink(file.lastPathComponent, destination: PdfViewToSwifUI(url: file))
                    }
                }
            }.onAppear {
                directoryContents = fileManagerPDF.getAllFilesURL()
                print(directoryContents)
            }
        }
    }
}

struct ListPDFView_Previews: PreviewProvider {
    static var previews: some View {
        ListPDFView()
    }
}
