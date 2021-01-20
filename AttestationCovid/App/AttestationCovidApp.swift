//
//  AttestationCovidApp.swift
//  AttestationCovid
//
//  Created by eldin smakic on 12/11/2020.
//
 
import SwiftUI
import ComposableArchitecture

struct AppState: Equatable {
    var routerState: RouterState
    var raisonState: RaisonState
}

enum AppAction {
    case router(RouterAction)
    case raison(RaisonAction)
}

let appReducer = Reducer<AppState, AppAction, Void>.combine(Reducer<AppState, AppAction,Void> {
    _, _, _ in
    return .none
    },
    routerReducer.pullback(
        state: \.routerState,
        action: /AppAction.router,
        environment: {}
    ),
    raisonReducer.pullback(
        state: \.raisonState,
        action: /AppAction.raison,
        environment: {}
    )
)

@main
struct AttestationCovidApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(store: .init(initialState: .init(routerState: .init(), raisonState: .init()), reducer: appReducer, environment: ()))
        }
    }
}
