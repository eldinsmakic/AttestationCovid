//
//  MovingMotifView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI

struct MovingMotifFormView: View {
    @EnvironmentObject var appRouting: AppRouting
    @EnvironmentObject var users: UserData
    var body: some View {
        VStack{
            if users.globalUsers.isEmpty {
                Text("Vous devez créer un profil")
            } else if (appRouting.router == Router.main) {
                VStack {
                    Spacer()
                    ChoiceButton(title: "Activite", isChecked: false)
                    ChoiceButton(title: "Activite", isChecked: false)
                    ChoiceButton(title: "Activite", isChecked: false)
                    ChoiceButton(title: "Activite", isChecked: false)
                    Spacer()
                }

                Spacer()
                List(users.globalUsers, id: \.id) { user in
                    ChoiceButton(title: user.firstName , isChecked: false)
                }
                Spacer()
                Button("Valider") {

                }.padding()
                Spacer()
            }
        }.onAppear {
            appRouting.router = .main
        }
    }
}

struct MovingMotifFormView_Previews: PreviewProvider {
    static var previews: some View {
        MovingMotifFormView()
            .environmentObject(AppRouting())
            .environmentObject(UserData.shared)
    }
}
