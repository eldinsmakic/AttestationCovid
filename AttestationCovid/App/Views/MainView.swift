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
        TabView {
            MovingMotifFormView()
                .environmentObject(appRouting)
                .environmentObject(profilLocalData)
                .tabItem {
                    Image(systemName: appRouting.router == Router.main  ? "house.fill" : "house")
                    Text("Home")
                }
            ListProfilsView()
                .environmentObject(appRouting)
                .environmentObject(profilLocalData)
                .tabItem {
                    Image(systemName: appRouting.router == Router.profile ? "person.fill" : "person")
                    Text("Profiles")
                }
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
