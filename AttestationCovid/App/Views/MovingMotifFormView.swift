//
//  MovingMotifView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI
import ComposableArchitecture

struct ProfilChoice: Equatable {
    let profil: Profil
    var isChecked = false
}

struct RaisonChoice: Equatable {
    let raison: Raison
    var isChecked = false
}

struct RaisonState: Equatable {
    var raisonsChoices = [RaisonChoice]()
    var profilsChoices = [ProfilChoice]()
}

enum RaisonAction {
    case loadRaisons([RaisonChoice])
    case loadProfils([ProfilChoice])
    case changeRaison(RaisonChoice)
    case changeProfil(ProfilChoice)
}

let raisonReducer = Reducer<RaisonState, RaisonAction, Void> { state, action, _ in

    switch (action) {
    case .changeRaison(let raisonChoice):
        for i in 0..<state.raisonsChoices.count {
            if state.raisonsChoices[i].raison.id == raisonChoice.raison.id {
                state.raisonsChoices[i] = raisonChoice
            }
        }
    case .changeProfil(let newProfil):
        for i in 0..<state.profilsChoices.count {
            if state.profilsChoices[i].profil.id == newProfil.profil.id {
                state.profilsChoices[i] = newProfil
            }
        }
    case .loadRaisons(let raisons):
        state.raisonsChoices = raisons
    case .loadProfils(let profils):
        state.profilsChoices = profils
    }
    return .none
}

struct MovingMotifFormView: View {

    @EnvironmentObject var appRouting: AppRouting
    let profilLocalData = ProfilLocalData.shared
    let store: Store<RaisonState,RaisonAction>

    @State var isSharePresented: Bool = false
    @State var data: Data? = nil

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack{
                if profilLocalData.globalUsers.isEmpty {
                    Text("Vous devez créer un profil")
                } else if (appRouting.router == Router.main) {
                    VStack {
                        Text("Motif de déplacement")
                            .font(.title)
                        Spacer()
                        List(viewStore.raisonsChoices, id: \.raison.id) { raisonChoice in
                            ChoiceButtonRaison(store: self.store, raisonChoice: raisonChoice)
                        }
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Text("Profils disponible")
                            .font(.title)
                        List(viewStore.profilsChoices, id: \.profil.id) { user in
                            ChoiceButtonProfil(store: self.store, profilChoice: user)
                        }
                    }
                    Spacer()
                    Button("Valider", action: {
                        createPDfAndShowIt(viewStore: viewStore)
                    }).sheet(isPresented: $isSharePresented, onDismiss: {
                        self.isSharePresented = false
                    }, content: {
                        ActivityViewControllerView(activityItems: [self.data!])
                    })
//                    .sheet(isPresented: $isSharePresented, onDismiss: {
//                        self.isSharePresented = false
//                    }, content: {
//                        ActivityViewControllerView(activityItems: [self.data])
//                    })
                    Spacer()
                }
            }
            .onAppear {
                fetchRaisonOnAppear(viewStore: viewStore)
            }
        }
    }

    func fetchRaisonOnAppear(viewStore: ViewStore<RaisonState, RaisonAction>) {
        do {
            let data = try Data(contentsOf: dataUrl)
            let raisons = try JSONDecoder().decode([Raison].self, from: data)
            viewStore.send(.loadRaisons(raisons.map({ RaisonChoice(raison: $0) })))
            viewStore.send(.loadProfils(profilLocalData.globalUsers.map({ ProfilChoice(profil: $0) })))
        } catch let error {
            print(error)
        }
    }

    func createPDfAndShowIt(viewStore: ViewStore<RaisonState, RaisonAction>) {
        let selectedPorfil = viewStore.profilsChoices.filter({ $0.isChecked })
        let selectedRaisons = viewStore.raisonsChoices.filter({ $0.isChecked }).map({ RaisonPDF(rawValue: $0.raison.code)! })
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
        MovingMotifFormView(store: .init(initialState: .init() , reducer: raisonReducer, environment: ()) )
            .environmentObject(AppRouting())
            .environmentObject(ProfilLocalData.shared)
    }
}
