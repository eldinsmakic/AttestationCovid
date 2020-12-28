//
//  UserData.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI
import Combine
import Defaults

public final class UserData: ObservableObject {

    static var shared = UserData()

    private init() {
        self.allUsers = globalUsers
    }

    @Published var allUsers: [CovidUser] = []

    public var globalUsers: [CovidUser] {
        get { Defaults[.users] }
        set { Defaults[.users] = newValue }
    }
}

extension Defaults.Keys {
    static let users = Key<[CovidUser]>("users", default: [])
}




