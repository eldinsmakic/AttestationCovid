//
//  FileManager.swift
//  AttestationCovid
//
//  Created by eldin smakic on 09/01/2021.
//

import Foundation

public final class FileManagerPDF {
    public let url: URL

    public static let shared = FileManagerPDF()

    private init() {
        url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("pdfs", isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print(error.localizedDescription);
            }
        }
    }

    func isDirectory() {
        if !FileManager.default.fileExists(atPath: url.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription);
            }
        }
    }

    func add(pdfName: String, withData contents: Data?) -> Bool {
        let path = createURL(name: pdfName)

        return FileManager.default.createFile(atPath: path.path, contents: contents, attributes: nil)
    }

    func remove(url: URL) -> Bool {
//        let url = createURL(name: pdfName)

        do {
            try FileManager.default.removeItem(at: url)
        } catch let error {
            print(error.localizedDescription)
        }

        return FileManager.default.fileExists(atPath: url.absoluteString)
    }

    func getAllFilesURL() -> [URL] {
        var result = [URL]()
        do {
            result = try FileManager.default.contentsOfDirectory(at: self.url, includingPropertiesForKeys: nil, options: [])
        } catch let error {
            print(error)
        }

        return result
    }

    private func createURL(name: String) -> URL {
        return url.appendingPathComponent(name)
    }
}
