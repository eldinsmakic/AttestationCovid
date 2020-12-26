//
//  UserForm.swift
//  AttestationCovid
//
//  Created by eldin smakic on 12/11/2020.
//

import SwiftUI

struct UserFormView: View {
    @EnvironmentObject var userData: UserData
    @State var user: CovidUser
    var body: some View {
        VStack {
            Spacer()
            VStack {
                TitleTextField(title: "Prénom")
                TextField("Camille", text: $user.firstName)

                TitleTextField(title: "Nom")
                TextField("Dupont", text: $user.lastName)

                TitleTextField(title: "Date de naissance")
                DatePicker("", selection: $user.birthday, displayedComponents: .date)
            }
            VStack {
                TitleTextField(title: "Lieu de naissance")
                TextField("Lille", text: $user.birthPlace)

                TitleTextField(title: "Ville")
                TextField("Lille", text: $user.address)

                TitleTextField(title: "Code Postal")
                TextField("59370", text: $user.zipcode)
            }
            Spacer()
            Button("Valider") {
                userData.globalUsers.removeAll(where: { $0.id == user.id })
                userData.globalUsers.append(user)
                userData.allUsers = userData.globalUsers
            }
        }.padding()
    }
}

struct UserForm_Previews: PreviewProvider {
    static var previews: some View {
        if let user = globalUser {
            UserFormView(user: user)
        } else {
            UserFormView(user: CovidUser())
        }

    }
}


struct TitleTextField: View {
    let title: String
    var body: some View {
         HStack {
            Text(title)
                .font(.title2)
            Spacer()
        }
    }
}


