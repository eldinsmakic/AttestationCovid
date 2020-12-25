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
    let userData = UserData.shared
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(AppRouting())
                .environmentObject(userData)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
