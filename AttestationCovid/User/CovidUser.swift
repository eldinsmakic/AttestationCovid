//
//  CovidUser.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import Foundation
import Defaults

public struct CovidUser: Codable, Identifiable {
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

public var globalUser: CovidUser? {
    get { Defaults[.user] }
    set { Defaults[.user] = newValue }
}

public var globalAllUsers: [CovidUser] {
    get { Defaults[.users] }
    set { Defaults[.users] = newValue }
}


extension Defaults.Keys {
    static let user = Key<CovidUser?>("user", default: nil)
    static let users = Key<[CovidUser]>("users", default: [])
}
