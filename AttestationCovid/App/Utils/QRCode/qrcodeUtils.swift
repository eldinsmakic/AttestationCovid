//
//  qrcodeUtils.swift
//  AttestationCovid
//
//  Created by eldin smakic on 03/01/2021.
//

import UIKit
import CoreImage.CIFilterBuiltins

let context = CIContext()
let filter = CIFilter.qrCodeGenerator()

func generateQRCode(from string: String) -> UIImage {
    let data = Data(string.utf8)
    filter.setValue(data, forKey: "inputMessage")

    let transform = CGAffineTransform(scaleX: 10, y: 10)
    if let outputImage = filter.outputImage?.transformed(by: transform) {
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgimg)
        }
    }

    return UIImage(systemName: "xmark.circle") ?? UIImage()
}
