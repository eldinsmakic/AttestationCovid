//
//  AppRouting.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import Combine

public enum Router {
    case main
    case choose
    case profile
}

public final class AppRouting: ObservableObject {
    @Published var router = Router.main
}
