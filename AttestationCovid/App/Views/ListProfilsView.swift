//
//  ListProfilsView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import Defaults
import SwiftUI
import ComposableArchitecture

struct ListProfilsView: View {

    let listProfilModelView = ListProfilsModelView()
    @State private var editMode = EditMode.inactive

    var body: some View {
        WithViewStore(self.listProfilModelView.store) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.state.profils) { profil in
                        HStack {
                            Spacer()
                            NavigationLink(
                                destination : ProfilDetailView(
                                    store: listProfilModelView.store,
                                    user: profil
                                )
                            ) {
                                    Text(profil.firstName)
                            }
                            Spacer()
                        }
                    }
                    .onMove(
                        perform: { source,destination in
                            listProfilModelView.moveItem(
                                from: source,
                                to: destination,
                                viewStore: viewStore
                            )
                        }
                    )
                    .onDelete(
                        perform: { index in
                            listProfilModelView.deleteItem(
                                at: index,
                                with: viewStore
                            )
                        }
                    )
                    Spacer()
                }
                .navigationBarTitle(Text(verbatim: "Profils"))
                .navigationBarItems(leading: EditButton(), trailing: addButton)
                .environment(\.editMode, $editMode)
            }
        }
    }

    private var addButton: some View {
        WithViewStore(self.listProfilModelView.store) { viewStore -> AnyView in
            switch editMode {
            case .inactive:
                return AnyView(Button(action: { self.listProfilModelView.onAdd(viewStore)}) { Image(systemName: "plus") })
            default:
                return AnyView(EmptyView())
            }
        }
    }
}

struct ListUsersView_Previews: PreviewProvider {

    static var previews: some View {
        ListProfilsView()
    }
}
