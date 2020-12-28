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

    var body: some View {
        NavigationView {
            List {
                ForEach(profilLocalData.allUsers) { user in
                    HStack {
                        Spacer()
                        NavigationLink(destination : ProfilDetailView(user: user.firstName == "Nouveau Profil" ? Profil() : user )) {
                            Text(user.firstName)
                        }
                        Spacer()
                    }
                }
                .onMove(perform: moveItem)
                .onDelete(perform: deleteItem)

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
                return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
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

    private func moveItem(from source: IndexSet, to destination: Int) {
        profilLocalData.globalUsers.move(fromOffsets: source, toOffset: destination)
        profilLocalData.allUsers = profilLocalData.globalUsers
    }

    private func deleteItem(at indexSet: IndexSet) {
        profilLocalData.globalUsers.remove(atOffsets: indexSet)
        profilLocalData.allUsers = profilLocalData.globalUsers
        print(profilLocalData.globalUsers)
    }
}

struct ListUsersView_Previews: PreviewProvider {

    static var previews: some View {
        ListProfilsView()
            .environmentObject(AppRouting())
            .environmentObject(ProfilLocalData.shared)
    }
}
