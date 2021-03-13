//
//  CovidUser.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import Foundation
import Defaults

public struct Profil: Codable, Identifiable, Equatable {

    public var id = UUID()
    var firstName: String
    var lastName: String
    var birthday: Date
    var birthPlace: String
    var address: String
    var locality: String
    var zipcode: String

    init() {
        self.firstName = ""
        self.lastName = ""
        self.birthday = Date()
        self.birthPlace = ""
        self.address = ""
        self.locality = ""
        self.zipcode = ""
    }
}

public var globalUser: Profil? {
    get { Defaults[.user] }
    set { Defaults[.user] = newValue }
}


extension Defaults.Keys {
    static let user = Key<Profil?>("user", default: nil)
}

extension Array where Element == Profil {

    func index(of element: Element) -> Int? {
        for i in 0..<self.count {
            if self[i].id == element.id {
                return i
            }
        }
        return nil
    }
}
