//
//  Raison.swift
//  AttestationCovid
//
//  Created by eldin smakic on 04/01/2021.
//

import Foundation

struct Raison: Codable, Equatable {
    let code: String
    let label: String

    var id = UUID()

    private enum CodingKeys : String, CodingKey {
            case code, label
    }
}

let dataUrl = Bundle.main.url(forResource: "FormData", withExtension: "json")!
