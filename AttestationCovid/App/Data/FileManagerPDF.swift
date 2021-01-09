//
//  FileManager.swift
//  AttestationCovid
//
//  Created by eldin smakic on 09/01/2021.
//

import Foundation

final class FileManagerPDF {
    public let url: URL

    init() {
        url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("pdfs")
    }
}
