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
            }.navigationBarTitle(Text("Profils"))
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .environment(\.editMode, $editMode)
        }.onAppear{
            appRouting.router = .profile
            print(appRouting.router)
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
        userData.allUsers.append(userCovid)
    }

    private func moveItem(from source: IndexSet, to destination: Int) {
        userData.allUsers.move(fromOffsets: source, toOffset: destination)
    }

    private func deleteItem(at indexSet: IndexSet) {
        userData.allUsers.remove(atOffsets: indexSet)
    }
}

var user: CovidUser = {
    var user = CovidUser()
    user.firstName = "Eldin"

    return user
}()

var user2: CovidUser = {
    var user = CovidUser()
    user.firstName = "Maman"

    return user
}()

struct ListUsersView_Previews: PreviewProvider {

    static var previews: some View {
        ListUsersView()
            .environmentObject(AppRouting())
            .environmentObject(UserData())
    }
}
