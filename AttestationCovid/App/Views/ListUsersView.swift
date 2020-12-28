//
//  UsersView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI

struct ListUsersView: View {
    @EnvironmentObject var appRouting: AppRouting
    @EnvironmentObject var userData: UserData
    @State private var editMode = EditMode.inactive

    var body: some View {
        NavigationView {
            List {
                ForEach(userData.allUsers) { user in
                    HStack {
                        Spacer()
                        NavigationLink(destination : UserFormView(user: user.firstName == "Nouveau Profil" ? CovidUser() : user )) {
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
        var userCovid = CovidUser()
        userCovid.firstName = "Nouveau Profil"
        userData.globalUsers.append(userCovid)
        userData.allUsers = userData.globalUsers
    }

    private func moveItem(from source: IndexSet, to destination: Int) {
        userData.globalUsers.move(fromOffsets: source, toOffset: destination)
        userData.allUsers = userData.globalUsers
    }

    private func deleteItem(at indexSet: IndexSet) {
        userData.globalUsers.remove(atOffsets: indexSet)
        userData.allUsers = userData.globalUsers
        print(userData.globalUsers)
    }
}

struct ListUsersView_Previews: PreviewProvider {

    static var previews: some View {
        ListUsersView()
            .environmentObject(AppRouting())
            .environmentObject(UserData.shared)
    }
}
