//
//  UsersView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI

struct ListUsersView: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.allUsers) { user in
                    HStack {
                        Spacer()
                        NavigationLink(destination : UserFormView(user: user)) {
                            Text(user.firstName)
                        }
                        Spacer()
                    }
                }.onDelete(perform: deleteItem)

                Spacer()
                NavigationLink(destination : UserFormView(user: CovidUser())) {
                    Text("Ajouter un profil")
                }
            }.navigationBarTitle(Text("Profils"))
        }
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
            .environmentObject(UserData())
    }
}
