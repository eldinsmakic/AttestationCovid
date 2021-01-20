//
//  MainView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI
import ComposableArchitecture

struct AppState: Equatable {
    var currentTabView = 0
}

enum AppAction: Equatable {
    case changeTabView(Int)
}

let appReducer = Reducer<AppState, AppAction, Void> {
    state, action, _ in
    switch action {
    case .changeTabView(let number):
        state.currentTabView = number
    }
    return .none
}


struct MainView: View {
    @EnvironmentObject var appRouting: AppRouting

    @State var store: Store<AppState,AppAction>
    @State var etat = 0

    var body: some View {
        WithViewStore(self.store) { viewStore in
            TabView(selection: viewStore.binding(
                get: \.currentTabView,
                send: AppAction.changeTabView
            )) {
                MovingMotifFormView(store: .init(initialState: .init(), reducer: raisonReducer, environment: ()))
                    .tabItem {
                        Image(systemName: viewStore.state.currentTabView == 0 ? "house.fill" : "house")
                        Text("Home")
                    }.tag(0)

                ListProfilsView(store: .init(initialState: .init(), reducer: listProfilsReducer, environment: ()))
                    .environmentObject(appRouting)
                    .tabItem {
                        Image(systemName: viewStore.state.currentTabView == 1 ? "person.fill" : "person")
                        Text("Profiles")
                    }.tag(1)

                ListPDFView()
                    .tabItem {
                        Image(systemName: viewStore.state.currentTabView == 2 ? "doc.fill" : "doc")
                        Text("Attestations")
                }.tag(2)
            }
        }
    }
}

//
//struct MainView_Previews: PreviewProvider {
//    let store: Store<appState, appAction> = .init(initialState: .init(), reducer: appReducer, environment: ())
//    static var previews: some View {
//        Group {
//            MainView(store: store)
//                .environmentObject(AppRouting())
//            MainView(store: store)
//                .preferredColorScheme(.dark)
//                .environmentObject(AppRouting())
//        }
//    }
//}
