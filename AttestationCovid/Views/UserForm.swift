//
//  UserForm.swift
//  AttestationCovid
//
//  Created by eldin smakic on 12/11/2020.
//

import SwiftUI

struct CovidUser {
    var firstName: String
    var lastName: String
    var birthday: Date
    var birthPlace: String
    var address: String
    var locality: String
    var zipcode: String

    init() {
        self.firstName = ""
        self.lastName = ""
        self.birthday = Date()
        self.birthPlace = ""
        self.address = ""
        self.locality = ""
        self.zipcode = ""
    }
}

struct UserForm: View {
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
                DatePicker("", selection: $user.birthday)
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
                print("Hello")
            }
        }.padding()
    }
}

struct UserForm_Previews: PreviewProvider {
    static var previews: some View {
        UserForm(user: CovidUser())
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



