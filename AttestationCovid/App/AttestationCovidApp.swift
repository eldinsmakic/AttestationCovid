//
//  AttestationCovidApp.swift
//  AttestationCovid
//
//  Created by eldin smakic on 12/11/2020.
//
 
import SwiftUI

@main
struct AttestationCovidApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(AppRouting())
        }
    }
}
