//
//  MovingMotifView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI
import ComposableArchitecture

struct MovingMotifFormView: View {

    @State var store: Store<AppState,AppAction>

    let movingMotifModelView = MovingMotifModelView()

    @State var raisons: [Raison]

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack{
                if movingMotifModelView.profilLocalData.globalUsers.isEmpty {
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
                            movingMotifModelView.createPDfAndShowIt(viewStore: viewStore)
                        })
                    Spacer()
                }
            }
            .onAppear {
                movingMotifModelView.fetchRaisonOnAppear(viewStore: viewStore, raisons: raisons)
            }
        }
    }
}

struct MovingMotifFormView_Previews: PreviewProvider {
    static var previews: some View {
        MovingMotifFormView(store: .init(initialState: .init(routerState: .init(), raisonState: .init()), reducer: appReducer, environment: ()), raisons: [])
    }
}
