//
//  MovingMotifView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI

struct MovingMotifFormView: View {
    @EnvironmentObject var appRouting: AppRouting
    @EnvironmentObject var profilLocalData: ProfilLocalData

    @State var raisons: [Raison] = []
    var body: some View {
        VStack{
            if profilLocalData.globalUsers.isEmpty {
                Text("Vous devez créer un profil")
            } else if (appRouting.router == Router.main) {
                VStack {
                    Text("Motif de déplacement")
                    Spacer()
                    List(raisons) { raison in
                        ChoiceButton(title: raison.code, isChecked: false)
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    Text("Profils disponnible")
                    List(profilLocalData.globalUsers, id: \.id) { user in
                        ChoiceButton(title: user.firstName , isChecked: false)
                    }
                }
                Spacer()
                Button("Valider") {

                }.padding()
                Spacer()
            }
        }.onAppear {
            appRouting.router = .main
            do {
                let data = try Data(contentsOf: dataUrl)
                raisons = try JSONDecoder().decode([Raison].self, from: data)
            } catch let error {
                print(error)
            }
        }
    }
}

struct MovingMotifFormView_Previews: PreviewProvider {
    static var previews: some View {
        MovingMotifFormView()
            .environmentObject(AppRouting())
            .environmentObject(ProfilLocalData.shared)
    }
}
