//
//  TitleTextField.swift
//  AttestationCovid
//
//  Created by eldin smakic on 13/03/2021.
//

import SwiftUI

struct TitleTextField: View {
    let title: String
    var body: some View {
         HStack {
            Text(title)
                .font(.title2)
            Spacer()
        }
    }
}

