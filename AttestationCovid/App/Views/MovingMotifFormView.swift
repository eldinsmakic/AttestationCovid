//
//  MovingMotifView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI

struct ProfilChoice {
    let profil: Profil
    var isChecked = false
}

struct RaisonChoice {
    let raison: Raison
    var isChecked = false
}

struct MovingMotifFormView: View {
    @EnvironmentObject var appRouting: AppRouting
    let profilLocalData = ProfilLocalData.shared
    @State var raisonsChoices: [RaisonChoice] = []
    @State var profilsChoices = [ProfilChoice]()
    var body: some View {
        VStack{
            if profilLocalData.globalUsers.isEmpty {
                Text("Vous devez créer un profil")
            } else if (appRouting.router == Router.main) {
                VStack {
                    Text("Motif de déplacement")
                        .font(.title)
                    Spacer()
                    List(raisonsChoices, id: \.raison.id) { raisonChoice in
                        ChoiceButton(title: raisonChoice.raison.code, isChecked: raisonChoice.isChecked)
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    Text("Profils disponnible")
                        .font(.title)

                    List(profilsChoices, id: \.profil.id) { user in
                        ChoiceButton(title: user.profil.firstName , isChecked: user.isChecked)
                    }
                }
                Spacer()
                Button("Valider") {
                    let selectedPorfil = profilsChoices.filter({ $0.isChecked })
                    let selectedRaisons = raisonsChoices.filter({ $0.isChecked }).map({ RaisonPDF(rawValue: $0.raison.code)! })
                    selectedPorfil.forEach { profile in
                    let profilePDF = ProfilePDF(
                            lastname: profile.profil.lastName,
                            firstname: profile.profil.firstName,
                            birthday: profile.profil.birthday,
                            placeofbirth: profile.profil.birthPlace,
                            address: profile.profil.address,
                            zipcode: profile.profil.zipcode,
                            city: profile.profil.locality,
                            datesortie: Date(),
                            heuresortie: Date()
                        )
//                        generatePdf(profile: profilePDF, reasons: selectedRaisons, pdfBase: <#T##URL#>)
                    }
                }.padding()
                Spacer()
            }
        }.onAppear {
            do {
                let data = try Data(contentsOf: dataUrl)
                let raisons = try JSONDecoder().decode([Raison].self, from: data)
                raisonsChoices = raisons.map({ RaisonChoice(raison: $0) })
                profilsChoices = profilLocalData.globalUsers.map({ ProfilChoice(profil: $0) })
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
