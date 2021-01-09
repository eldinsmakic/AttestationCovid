//
//  FileManagerPDFTest.swift
//  AttestationCovidTests
//
//  Created by eldin smakic on 09/01/2021.
//

import XCTest
@testable import AttestationCovid

class FileManagerPDFTest: XCTestCase {


    func testinit() {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("pdfs")
        let fileManager = FileManagerPDF()

        XCTAssertNotNil(fileManager)
        XCTAssertEqual(fileManager.url, url)
    }

    func testGetUrl() {

    }
}
