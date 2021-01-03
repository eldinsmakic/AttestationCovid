//
//  PDFImageAnnotationn.swift
//  AttestationCovid
//
//  Created by eldin smakic on 03/01/2021.
//

import UIKit
import PDFKit

class ImageStampAnnotation: PDFAnnotation {
    var image: UIImage!
    // A custom init that sets the type to Stamp on default and assigns our Image variable
    init(with image: UIImage!, forBounds bounds: CGRect, withProperties properties: [AnyHashable : Any]?) {
        super.init(bounds: bounds, forType: PDFAnnotationSubtype.stamp,  withProperties: properties)
        self.image = image
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(with box: PDFDisplayBox, in context: CGContext)   {
        // Get the CGImage of our image
        guard let cgImage = self.image.cgImage else { return }
        // Draw our CGImage in the context of our PDFAnnotation bounds
        context.draw(cgImage, in: self.bounds)
        }
}
