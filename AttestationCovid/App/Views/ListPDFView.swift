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
                    List {
                        ForEach(directoryContents, id: \.self ) { file in
                            NavigationLink(file.lastPathComponent, destination: PdfViewToSwifUI(url: file))
                        }.onDelete(perform: onDelete)
                    }
                }
            }.onAppear {
                directoryContents = fileManagerPDF.getAllFilesURL()
            }
        }
    }

    func onDelete(indexSet index: IndexSet) {
        index.forEach { fileIndex in
            let file = directoryContents[fileIndex]
            directoryContents.remove(atOffsets: index)
            fileManagerPDF.remove(url: file)
        }
    }
}

struct ListPDFView_Previews: PreviewProvider {
    static var previews: some View {
        ListPDFView()
    }
}
