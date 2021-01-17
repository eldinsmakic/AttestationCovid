//
//  ChoiceButtonProfil.swift
//  AttestationCovid
//
//  Created by eldin smakic on 17/01/2021.
//

import SwiftUI
import ComposableArchitecture

struct ChoiceButtonProfil: View {
    let store: Store<RaisonState,RaisonAction>
    @State var profilChoice: ProfilChoice

    var body: some View {
        WithViewStore(self.store) { viewStore in
            Button(action: {
                profilChoice.isChecked.toggle()
                viewStore.send(.changeProfil(profilChoice))
                }
            ){
                HStack {
                    if profilChoice.isChecked {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 50, height: 50)
                    } else {
                        Rectangle()
                            .stroke(Color.blue)
                            .frame(width: 50, height: 50)
                    }
                    Text(profilChoice.profil.firstName)
                        .font(.title2)
                        .padding()
                }
            }
        }
    }
}

