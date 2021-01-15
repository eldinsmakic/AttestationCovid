//
//  Raison.swift
//  AttestationCovid
//
//  Created by eldin smakic on 04/01/2021.
//

import Foundation

struct Raison: Codable, Identifiable, Equatable {
    let code: String
    let label: String

    var id: UUID {
        UUID()
    }
}

let dataUrl = Bundle.main.url(forResource: "FormData", withExtension: "json")!
