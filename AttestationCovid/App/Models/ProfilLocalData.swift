//
//  UserData.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI
import Combine
import Defaults

public final class ProfilLocalData: ObservableObject {

    static var shared = ProfilLocalData()

    private init() {
        self.allUsers = globalUsers
    }

    @Published var allUsers: [Profil] = []

    public var globalUsers: [Profil] {
        get { Defaults[.users] }
        set { Defaults[.users] = newValue }
    }
}

extension Defaults.Keys {
    static let users = Key<[Profil]>("users", default: [])
}




