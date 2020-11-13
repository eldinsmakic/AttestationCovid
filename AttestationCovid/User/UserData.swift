//
//  UserData.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI
import Combine

public final class UserData: ObservableObject {
    @Published var allUsers = globalAllUsers
}
