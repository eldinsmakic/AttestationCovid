//
//  ListProfilsReducer.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/03/2021.
//

import ComposableArchitecture

public struct ListProfilsState: Equatable {
    var profils = ProfilLocalData.shared.globalUsers
}

public enum ListProfilsAction: Equatable {
    case add(Profil)
    case remove(IndexSet)
    case edit(Profil)
    case move(IndexSet, Int)
}

public let listProfilsReducer = Reducer<ListProfilsState, ListProfilsAction, Void> { state, action, _ in
    switch action {
    case .add(let profil):
        state.profils.append(profil)
    case .remove(let indexSet):
        state.profils.remove(atOffsets: indexSet)
    case .edit(let profil):
        state.profils = state.profils.map( { if ($0.id == profil.id) {
            return profil
        }
            return $0
        })
    case .move(let source, let destination):
        state.profils.move(fromOffsets: source, toOffset: destination)
    }
    ProfilLocalData.shared.globalUsers = state.profils
    return .none
}
