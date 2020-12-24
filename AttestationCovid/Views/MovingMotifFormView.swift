//
//  MovingMotifView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI

struct MovingMotifFormView: View {
    @EnvironmentObject var appRouting: AppRouting
    var body: some View {
        VStack {
            Spacer()
            ChoiceButton(title: "Activite", isChecked: false)
            ChoiceButton(title: "Activite", isChecked: false)
            ChoiceButton(title: "Activite", isChecked: false)
            ChoiceButton(title: "Activite", isChecked: false)
            Spacer()
            Button("Valider") {
                appRouting.router = Router.profile
            }.padding()
        }.onAppear {
            appRouting.router = .main
            print(appRouting.router)
        }
    }
}

struct MovingMotifFormView_Previews: PreviewProvider {
    static var previews: some View {
        MovingMotifFormView()
            .environmentObject(AppRouting())
    }
}
