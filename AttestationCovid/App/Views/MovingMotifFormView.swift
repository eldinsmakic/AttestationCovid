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
    case resetCheck
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
    case .resetCheck:
        for index in 0..<state.raisonsChoices.count {
            state.raisonsChoices[index].isChecked = false
        }

        for index in 0..<state.profilsChoices.count {
            state.profilsChoices[index].isChecked = false
        }
    }
    return .none
}

struct MovingMotifFormView: View {

    let profilLocalData = ProfilLocalData.shared
    @State var store: Store<AppState,AppAction>

    @State var raisons: [Raison]

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack{
                if profilLocalData.globalUsers.isEmpty {
                    Text("Vous devez créer un profil")
                } else {
                    VStack {
                        Text("Motif de déplacement")
                            .font(.title)
                        Spacer()
                        List{
                            ForEach(viewStore.raisonState.raisonsChoices, id: \.raison.id) { raisonChoice in
                                ChoiceButtonRaisonView(
                                    store: self.store.scope(
                                        state: \.raisonState,
                                        action: AppAction.raison),
                                   raisonChoice: raisonChoice
                                )
                            }
                        }
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Text("Profils disponible")
                            .font(.title)
                        List {
                            ForEach(viewStore.raisonState.profilsChoices, id: \.profil.id) { user in
                                ChoiceButtonProfilView(
                                    store: self.store.scope(
                                        state: \.raisonState,
                                        action: AppAction.raison
                                    ),
                                    profilChoice: user
                                )
                            }
                        }
                    }
                    Spacer()
                        Button("Valider", action: {
                            createPDfAndShowIt(viewStore: viewStore)
                        })
                    Spacer()
                }
            }
            .onAppear {
                fetchRaisonOnAppear(viewStore: viewStore)
            }
        }
    }

    func fetchRaisonOnAppear(viewStore: ViewStore<AppState, AppAction>) {
        viewStore.send(.raison(.loadRaisons(raisons.map({ RaisonChoice(raison: $0) }))))
        viewStore.send(.raison(.loadProfils(profilLocalData.globalUsers.map({ ProfilChoice(profil: $0)}))))
    }

    func createPDfAndShowIt(viewStore: ViewStore<AppState, AppAction>) {
        let selectedPorfil = viewStore.raisonState.profilsChoices.filter({ $0.isChecked })
        let selectedRaisons = viewStore.raisonState.raisonsChoices.filter({ $0.isChecked }).map({ RaisonPDF(rawValue: $0.raison.code)! })
        selectedPorfil.forEach { profilChoice in

            let profilPDF = ProfilPDF(
                profil: profilChoice.profil,
                datesortie: Date(),
                heuresortie: Date()
            )

            let data = generatePdf(profilPDF: profilPDF, reasons: selectedRaisons)
            let fileManager = FileManagerPDF.shared
            let date = Date().getDateAndHour()

            let fileName =  "\(profilChoice.profil.firstName)_\(selectedRaisons[0])_\(date)"
            let result = fileManager.add(pdfName: fileName, withData: data)

            if result {
                viewStore.send(.raison(.resetCheck))
                viewStore.send(.router(.changeTabView(2)))
            }
        }
    }
}

struct MovingMotifFormView_Previews: PreviewProvider {
    static var previews: some View {
        MovingMotifFormView(store: .init(initialState: .init(routerState: .init(), raisonState: .init()), reducer: appReducer, environment: ()), raisons: [])
    }
}
