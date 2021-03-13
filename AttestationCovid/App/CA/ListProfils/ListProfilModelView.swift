//
//  ListProfilModelView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/03/2021.
//

import ComposableArchitecture

public struct ListProfilsModelView {

    public let store: Store<ListProfilsState, ListProfilsAction>

    init() {
        store = .init(initialState: .init(), reducer: listProfilsReducer, environment: ())
    }

    public func onAdd(_ viewStore: ViewStore<ListProfilsState, ListProfilsAction>){
        var user = Profil()
        user.firstName = "Nouveau Profil"
        viewStore.send(.add(user))
    }

    public func moveItem(from source: IndexSet, to destination: Int, viewStore: ViewStore<ListProfilsState, ListProfilsAction>) {
        viewStore.send(.move(source,destination))
    }

    public func deleteItem(at indexSet: IndexSet, with viewStore: ViewStore<ListProfilsState, ListProfilsAction>) {
        viewStore.send(.remove(indexSet))
    }
}
