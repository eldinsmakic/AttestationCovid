//
//  Profile.swift
//  AttestationCovid
//
//  Created by eldin smakic on 25/12/2020.
//

import Foundation

struct ProfilePDF: Codable {
    let lastname: String
    let firstname: String
    let birthday: Date
    let placeofbirth: String
    let address: String
    let zipcode: String
    let city: String
    let datesortie: Date
    let heuresortie: Date
}