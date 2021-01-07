//
//  ListProfilsView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI
import ComposableArchitecture

struct ListProfilsState: Equatable {

    var profils = [Profil]()
}

enum ListProfilsAction: Equatable {
    case add(Profil)
    case remove(Profil)
    case edit(Profil)
}

let listProfilsReducer = Reducer<ListProfilsState, ListProfilsAction, Void> { state, action, _ in
    switch action {
    case .add(let profil):
        state.profils.append(profil)
    case .remove(let profil):
        state.profils.removeAll(where: { $0 == profil })
    default:
        return .none
    }
    return .none
}

struct ListProfilsView: View {
    let store: Store<ListProfilsState, ListProfilsAction>

    @EnvironmentObject var appRouting: AppRouting
    @EnvironmentObject var profilLocalData: ProfilLocalData
    @State private var editMode = EditMode.inactive
    @State private var profils = [Profil]()
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.state.profils) { profil in
                        HStack {
                            Spacer()
                            NavigationLink(destination : ProfilDetailView(user: profil)) {
                                    Text(profil.firstName)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .onMove(perform: moveItem2)
                .onDelete(perform: deleteItem2)

                Spacer()
            }.onAppear{
                appRouting.router = .profile
            }
            .navigationBarTitle(Text("Profils"))
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .environment(\.editMode, $editMode)
        }
    }

    private var addButton: some View {
        WithViewStore(self.store) { viewStore -> AnyView in
            switch editMode {
            case .inactive:
                return AnyView(Button(action: {onAdd2(viewStore: viewStore)}) { Image(systemName: "plus") })
            default:
                return AnyView(EmptyView())
            }
        }
    }

    func onAdd() {
        var user = Profil()
        user.firstName = "Nouveau Profil"
        profilLocalData.globalUsers.append(user)
        profilLocalData.allUsers = profilLocalData.globalUsers
    }

    func onAdd2(viewStore: ViewStore<ListProfilsState, ListProfilsAction>) {
        var user = Profil()
        user.firstName = "Nouveau Profil"
        viewStore.send(.add(user))
    }

    private func moveItem(from source: IndexSet, to destination: Int) {
        profilLocalData.globalUsers.move(fromOffsets: source, toOffset: destination)
        profilLocalData.allUsers = profilLocalData.globalUsers
    }

    private func moveItem2(from source: IndexSet, to destination: Int) {
        profils.move(fromOffsets: source, toOffset: destination)
    }

    private func deleteItem(at indexSet: IndexSet) {
        profilLocalData.globalUsers.remove(atOffsets: indexSet)
        profilLocalData.allUsers = profilLocalData.globalUsers
        print(profilLocalData.globalUsers)
    }

    private func deleteItem2(at indexSet: IndexSet) {
        profils.remove(atOffsets: indexSet)
    }
}

struct ListUsersView_Previews: PreviewProvider {

    static var previews: some View {
        ListProfilsView()
            .environmentObject(AppRouting())
            .environmentObject(ProfilLocalData.shared)
    }
}
