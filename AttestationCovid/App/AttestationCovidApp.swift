//
//  AttestationCovidApp.swift
//  AttestationCovid
//
//  Created by eldin smakic on 12/11/2020.
//
 
import SwiftUI

@main
struct AttestationCovidApp: App {
    let profil = ProfilLocalData.shared
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(AppRouting())
                .environmentObject(profil)
        }
    }
}
