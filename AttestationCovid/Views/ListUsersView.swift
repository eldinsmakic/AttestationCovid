//
//  UsersView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI

struct ListUsersView: View {
    @State var listUser: [CovidUser]
    var body: some View {
        NavigationView {
            List {
                ForEach(listUser) { user in
                    HStack {
                        Spacer()
                        NavigationLink(destination : UserFormView(user: user)) {
                            Text(user.firstName)
                        }
                        Spacer()
                    }
                }
                NavigationLink(destination : UserFormView(user: CovidUser())) {
                    Text("Ajouter un profil")
                }
            }
        }.navigationBarTitle(Text("Profils"))
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
        ListUsersView(listUser: [user,user2])
    }
}
