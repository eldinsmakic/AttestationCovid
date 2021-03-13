//
//  MovingMotifModelView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/03/2021.
//

import ComposableArchitecture

public struct MovingMotifModelView {

    let profilLocalData = ProfilLocalData.shared

    public init() {
    }

    public func fetchRaisonOnAppear(viewStore: ViewStore<AppState, AppAction>, raisons: [Raison]) {
        viewStore.send(.raison(.loadRaisons(raisons.map({ RaisonChoice(raison: $0) }))))
        viewStore.send(.raison(.loadProfils(profilLocalData.globalUsers.map({ ProfilChoice(profil: $0)}))))
    }

    public func createPDfAndShowIt(viewStore: ViewStore<AppState, AppAction>) {
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
