//
//  MainView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appRouting: AppRouting
    @EnvironmentObject var profilLocalData: ProfilLocalData
    
    var body: some View {
        TabView(selection: $appRouting.router) {
//            PdfView()
            MovingMotifFormView()
                .environmentObject(appRouting)
                .environmentObject(profilLocalData)
                .tabItem {
//                    Image(systemName: appRouting.router == Router.main  ? "house.fill" : "house")
                    Image(systemName: "house")
                    Text("Home")
                }.tag(Router.main)

            ListProfilsView(store: .init(initialState: .init(), reducer: listProfilsReducer, environment: ()))
                .environmentObject(appRouting)
                .tabItem {
//                    Image(systemName: appRouting.router == Router.profile ? "person.fill" : "person")
                    Image(systemName: "person")
                    Text("Profiles")
                }.tag(Router.profile)

            ListPDFView()
                .tabItem {
                    Image(systemName: "doc")
                    Text("Attestations")
                }.tag(Router.attestationPDFs)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .environmentObject(AppRouting())
                .environmentObject(ProfilLocalData.shared)
            MainView()
                .preferredColorScheme(.dark)
                .environmentObject(AppRouting())
                .environmentObject(ProfilLocalData.shared)
        }
    }
}
