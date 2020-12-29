//
//  ListProfilsView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI

struct ListProfilsView: View {
    @EnvironmentObject var appRouting: AppRouting
    @EnvironmentObject var profilLocalData: ProfilLocalData
    @State private var editMode = EditMode.inactive
    @State private var profils = [Profil]()
    var body: some View {
        NavigationView {
            List {
                ForEach(profils.indices, id: \.self) { indice in
                    HStack {
                        Spacer()
                            NavigationLink(destination : ProfilDetailView(user: $profils[indice])) {
                                Text(profils[indice].firstName)
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
            switch editMode {
            case .inactive:
                return AnyView(Button(action: onAdd2) { Image(systemName: "plus") })
            default:
                return AnyView(EmptyView())
            }
    }

    func onAdd() {
        var user = Profil()
        user.firstName = "Nouveau Profil"
        profilLocalData.globalUsers.append(user)
        profilLocalData.allUsers = profilLocalData.globalUsers
    }

    func onAdd2() {
        var user = Profil()
        user.firstName = "Nouveau Profil"
        profils.append(user)
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
