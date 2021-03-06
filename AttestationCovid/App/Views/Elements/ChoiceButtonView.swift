//
//  ChoiceButton.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/11/2020.
//

import SwiftUI

struct ChoiceButton: View {
    var title: String
    @State var isChecked = false
    var body: some View {
        HStack {
            if isChecked {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50)
            } else {
                Rectangle()
                    .stroke(Color.blue)
                    .frame(width: 50, height: 50)
            }
            Text(title)
                .font(.title2)
                .padding()
        }
    }
}

struct ChoiceButton_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceButton(title: "activité professionnelle")
    }
}
