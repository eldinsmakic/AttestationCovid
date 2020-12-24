//
//  MainView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appRouting: AppRouting
    var body: some View {
        TabView {
            MovingMotifFormView()
                .environmentObject(appRouting)
                .tabItem {
                    Image(systemName: appRouting.router == Router.main  ? "house.fill" : "house")
                    Text("Home")
                }
            ListUsersView()
                .environmentObject(appRouting)
                .environmentObject(UserData())
                .tabItem {
                    Image(systemName: appRouting.router == Router.profile ? "person.fill" : "person")
                    Text("Profiles")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AppRouting())
    }
}
