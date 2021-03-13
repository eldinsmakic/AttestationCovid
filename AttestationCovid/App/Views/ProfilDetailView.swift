//
//  ProfilDetailView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 12/11/2020.
//

import SwiftUI
import ComposableArchitecture

struct ProfilDetailView: View {
    @EnvironmentObject var profilLocalData: ProfilLocalData

    let store: Store<ListProfilsState, ListProfilsAction>
    @State var user: Profil

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Spacer()
                VStack {
                    TitleTextField(title: "Prénom")
                    TextField(
                        "Camille",
                        text: Binding(
                            get: { user.firstName },
                            set: { user.firstName = $0
                                viewStore.send(.edit(user))
                            }
                        )
                    )

                    TitleTextField(title: "Nom")
                    TextField(
                        "Dupont",
                        text: Binding(
                            get: { user.lastName },
                            set: { user.lastName = $0
                                  viewStore.send(.edit(user))
                            }
                        )
                    )

                    TitleTextField(title: "Date de naissance")
                    DatePicker(
                        "",
                        selection: Binding(
                            get: { user.birthday },
                            set: { user.birthday = $0
                                  viewStore.send(.edit(user))
                            }
                        ),
                        displayedComponents: .date
                    )
                }
                VStack {
                    TitleTextField(title: "Lieu de naissance")
                    TextField(
                        "Lille",
                        text: Binding(
                            get: { user.birthPlace },
                            set: { user.birthPlace = $0
                                  viewStore.send(.edit(user))
                            }
                        )
                    )

                    TitleTextField(title: "Ville")
                    TextField(
                        "Lille",
                        text: Binding(
                            get: { user.locality },
                            set: { user.locality = $0
                                  viewStore.send(.edit(user))
                            }
                        )
                    )

                    TitleTextField(title: "Addresse")
                    TextField(
                        "Lille",
                        text: Binding(
                            get: { user.address },
                            set: { user.address = $0
                                  viewStore.send(.edit(user))
                            }
                        )
                    )

                    TitleTextField(title: "Code Postal")
                    TextField(
                        "59370",
                        text: Binding(
                            get: { user.zipcode },
                            set: { user.zipcode = $0
                                  viewStore.send(.edit(user))
                            }
                        )
                    )
                }
                Spacer()
                Button("Valider") {
                    viewStore.send(.edit(user))

                }
            }.padding()
        }.onAppear {
            if user.firstName == "Nouveau Profil" {
                user.firstName = ""
            }
        }
    }
}

//struct ProfilDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        if let user = globalUser {
//            ProfilDetailView(user: user)
//        } else {
//            ProfilDetailView(user: Profil())
//        }
//
//    }
//}
