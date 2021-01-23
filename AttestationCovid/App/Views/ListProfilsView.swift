//
//  ListProfilsView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import Defaults
import SwiftUI
import ComposableArchitecture

struct ListProfilsState: Equatable {
    var profils = ProfilLocalData.shared.globalUsers
}

enum ListProfilsAction: Equatable {
    case add(Profil)
    case remove(IndexSet)
    case edit(Profil)
    case move(IndexSet, Int)
}

let listProfilsReducer = Reducer<ListProfilsState, ListProfilsAction, Void> { state, action, _ in
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

struct ListProfilsView: View {
    let store: Store<ListProfilsState, ListProfilsAction>

    @State private var editMode = EditMode.inactive

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.state.profils) { profil in
                        HStack {
                            Spacer()
                            NavigationLink(destination : ProfilDetailView(store: store, user: profil)) {
                                    Text(profil.firstName)
                            }
                            Spacer()
                        }
                    }
                    .onMove(perform: { source,destination in
                        moveItem(from: source, to: destination, viewStore: viewStore)})
                    .onDelete(perform: {index in deleteItem(at: index, with: viewStore )})

                    Spacer()
                }
                .navigationBarTitle(Text("Profils"))
                .navigationBarItems(leading: EditButton(), trailing: addButton)
                .environment(\.editMode, $editMode)
            }
        }
    }

    private var addButton: some View {
        WithViewStore(self.store) { viewStore -> AnyView in
            switch editMode {
            case .inactive:
                return AnyView(Button(action: {onAdd(viewStore)}) { Image(systemName: "plus") })
            default:
                return AnyView(EmptyView())
            }
        }
    }

    func onAdd(_ viewStore: ViewStore<ListProfilsState, ListProfilsAction>) {
        var user = Profil()
        user.firstName = "Nouveau Profil"
        viewStore.send(.add(user))
    }

    private func moveItem(from source: IndexSet, to destination: Int, viewStore: ViewStore<ListProfilsState, ListProfilsAction>) {
        viewStore.send(.move(source,destination))
    }

    private func deleteItem(at indexSet: IndexSet, with viewStore: ViewStore<ListProfilsState, ListProfilsAction>) {
        viewStore.send(.remove(indexSet))
    }
}

struct ListUsersView_Previews: PreviewProvider {

    static var previews: some View {
        ListProfilsView(store: .init(initialState: .init(), reducer: listProfilsReducer, environment: ()))
    }
}
