//
//  AttestationCovidApp.swift
//  AttestationCovid
//
//  Created by eldin smakic on 12/11/2020.
//
 
import SwiftUI

@main
struct AttestationCovidApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ListUsersView()
                .environmentObject(UserData())
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
