//
//  MovingMotifView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI
import ComposableArchitecture

struct ProfilChoice {
    let profil: Profil
    var isChecked = false
}

struct RaisonChoice {
    let raison: Raison
    var isChecked = false
}

struct RaisonState {
    var raisonsChoices = [RaisonChoice]()
    var profilsChoices = [ProfilChoice]()
}

enum RaisonAction {
    case changeRaison(RaisonChoice)
    case changeProfil(ProfilChoice)
}

let raisonReducer = Reducer<RaisonState, RaisonAction, Void> { state, action, _ in

    switch (action) {
    case .changeRaison(let newRaison):
        for i in 0..<state.raisonsChoices.count {
            if state.raisonsChoices[i].raison.id == newRaison.raison.id {
                state.raisonsChoices[i].isChecked.toggle()
            }
        }
    case .changeProfil(let newProfil):
        for i in 0..<state.profilsChoices.count {
            if state.profilsChoices[i].profil.id == newProfil.profil.id {
                state.profilsChoices[i].isChecked.toggle()
            }
        }
    }
    return .none
}

struct MovingMotifFormView: View {

    @EnvironmentObject var appRouting: AppRouting
    let profilLocalData = ProfilLocalData.shared
    @State var raisonsChoices: [RaisonChoice] = []
    @State var profilsChoices = [ProfilChoice]()
    @State var isSharePresented: Bool = false
    @State var data: Data?

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
                    Text("Profils disponible")
                        .font(.title)

                    List(profilsChoices, id: \.profil.id) { user in
                        ChoiceButton(title: user.profil.firstName , isChecked: user.isChecked)
                    }
                }
                Spacer()
                Button("Valider", action: {
                    createPDfAndShowIt()
                }).sheet(isPresented: $isSharePresented, onDismiss: {
                    self.isSharePresented = false
                }, content: {
                    ActivityViewControllerView(activityItems: [self.data!])
                })
                Spacer()
            }
        }
        .onAppear {
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

    func createPDfAndShowIt() {
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
            self.data = generatePdf(profile: profilePDF, reasons: selectedRaisons)
            self.isSharePresented = true
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
