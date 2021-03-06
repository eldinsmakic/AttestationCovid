//
//  UIActivityViewControllerView.swift
//  AttestationCovid
//
//  Created by eldin smakic on 10/01/2021.
//

import UIKit
import SwiftUI

struct ActivityViewControllerView: UIViewControllerRepresentable {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewControllerView>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewControllerView>) {}

}
