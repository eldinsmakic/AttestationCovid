//
//  ChoiceButtonRaison.swift
//  AttestationCovid
//
//  Created by eldin smakic on 17/01/2021.
//

import SwiftUI
import ComposableArchitecture

struct ChoiceButtonRaison: View {
    let store: Store<RaisonState,RaisonAction>
    @State var raisonChoice: RaisonChoice

    var body: some View {
        WithViewStore(self.store) { viewStore in
            Button(action: {
                raisonChoice.isChecked.toggle()
                viewStore.send(.changeRaison(raisonChoice))
                }
            ){
                HStack {
                    if raisonChoice.isChecked {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 50, height: 50)
                    } else {
                        Rectangle()
                            .stroke(Color.blue)
                            .frame(width: 50, height: 50)
                    }
                    Text(raisonChoice.raison.code)
                        .font(.title2)
                        .padding()
                }
            }
        }
    }
}
