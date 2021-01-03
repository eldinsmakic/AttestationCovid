//
//  pdfUtils.swift
//  AttestationCovid
//
//  Created by eldin smakic on 25/12/2020.
//

import Foundation
import PDFKit

let ys = [
  "travail": 540,
  "sante": 508,
  "famille": 474,
  "handicap": 441,
  "convocation": 418,
  "missions": 397,
  "transits": 363,
  "animaux": 330,
]

let sizeFont = CGFloat(11.0)
//let font =  UIFont(name: "HelveticaNeue-Thin", size: sizeFont)!
let font = UIFont.systemFont(ofSize: 11)

func generatePdf(profile: ProfilePDF, reasons: [RaisonPDF], pdfBase: URL) {
    let dateFormater = DateFormatter()
    dateFormater.dateStyle = .short
    dateFormater.timeStyle = .short
    dateFormater.locale = Locale(identifier: "FR.fr")

    let creationInstant = Date()

    let creationDate = dateFormater.string(from: creationInstant)

    dateFormater.dateFormat = "hh:mm"
    let creationHour = dateFormater.string(from: creationInstant)

    let lastname = profile.lastname
    let firstname = profile.firstname
    let birthday = profile.birthday
    let placeofbirth = profile.placeofbirth
    let address = profile.address
    let zipcode = profile.zipcode
    let city = profile.city
    let datesortie = profile.datesortie
    let heuresortie = profile.heuresortie


  let data = [
    "Cree le: \(creationDate) a \(creationHour)",
    "Nom: \(lastname)",
    "Prenom: \(firstname)",
    "Naissance: \(birthday) a \(placeofbirth)",
    "Adresse: \(address) \(zipcode) \(city)",
    "Sortie: \(datesortie) a \(heuresortie)",
    "Motifs: \(reasons)",
    "", // Pour ajouter un ; aussi au dernier élément
  ].joined(separator: ";\n")

    let pdfDoc = PDFDocument(url: pdfBase)!

    let pdfMetaData = [
        kCGPDFContextTitle: "COVID-19 - Déclaration de déplacement",
       kCGPDFContextSubject: "Attestation de déplacement dérogatoire",
        kCGPDFContextKeywords: "covid19,covid-19,attestation,déclaration,déplacement,officielle,gouvernement"
    ]

    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = pdfMetaData as [String: Any]

    let page1 = pdfDoc.page(at: 0)!

    page1.draw(text: "\(firstname) \(lastname)", x: 119, y: 665)
    page1.draw(text: "01/02/1994", x: 119, y: 645)
    page1.draw(text: placeofbirth, x: 312, y: 645)
    page1.draw(text: "\(address) \(zipcode) \(city)", x: 133, y: 625)

    reasons.forEach {
        page1.draw(text: "X", x: 73, y: CGFloat(ys[$0.rawValue]!))
    }

    page1.draw(text: profile.city, x: 105, y: 286)
    page1.draw(text: profile.datesortie.description, x: 91, y: 267)
    page1.draw(text: profile.heuresortie.description, x: 312, y: 267)

    page1.draw(text: creationDate.description, x: 314, y: 189)

    page1.draw(text: "Date de création", x: 479, y: 130)
    page1.draw(text: "\(creationDate.description) à \(creationHour.description)", x: 470, y: 124)

    let qrTitle1 = "QR-code contenant les informations "
    let qrTitle2 = "de votre attestation numérique"

    page1.draw(text: "\(qrTitle1) \n + \(qrTitle2)", x: 440, y: 230)

    let qrCode = generateQRCode(from: data)
    let bounds = pdfDoc.page(at: 0)?.bounds(for: PDFDisplayBox.mediaBox)
    let size = bounds?.size
    pdfDoc.page(at: 0)?.draw(image: qrCode, x: size!.width - 125, y:  125, width: 92, height: 92)
    
//  page1.drawText(qrTitle1 + '\n' + qrTitle2, { x: 440, y: 230, size: 6, font, lineHeight: 10, color: rgb(1, 1, 1) })

//
    let page2 = PDFPage(image: generateQRCode(from: data))!
    pdfDoc.insert(page2, at: 1)
//  pdfDoc.addPage()
//  const page2 = pdfDoc.getPages()[1]
//  page2.drawText(qrTitle1 + qrTitle2, { x: 50, y: page2.getHeight() - 40, size: 11, font, color: rgb(1, 1, 1) })
//  page2.drawImage(qrImage, {
//    x: 50,
//    y: page2.getHeight() - 350,
//    width: 300,
//    height: 300,
//  })
//
//  const pdfBytes = await pdfDoc.save()
//
//  return new Blob([pdfBytes], { type: 'application/pdf' })
//}
//
//function getIdealFontSize (font, text, maxWidth, minSize, defaultSize) {
//  let currentSize = defaultSize
//  let textWidth = font.widthOfTextAtSize(text, defaultSize)
//
//  while (textWidth > maxWidth && currentSize > minSize) {
//    textWidth = font.widthOfTextAtSize(text, --currentSize)
//  }
//
//  return textWidth > maxWidth ? null : currentSize

    do {
        try pdfDoc.dataRepresentation()?.write(to: pdfBase)
        print("hello")
    } catch let error {
        print(error.localizedDescription)
    }
}


extension PDFPage {
    func draw(text: String, x: CGFloat,  y: CGFloat, fontSize: CGFloat = 11,  font: UIFont = font) {

      let textAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: font]

      let attributedTitle = NSAttributedString(
        string: text,
        attributes: textAttributes
      )

      let textStringSize = attributedTitle.size()

      let titleStringRect = CGRect(
        x: x,
        y: y,
        width: ceil(textStringSize.width),
        height: ceil(textStringSize.height)
      )

      let textAnnotation = PDFAnnotation(bounds: titleStringRect, forType: .freeText, withProperties: nil)
        textAnnotation.contents =  text
        textAnnotation.font = font
        textAnnotation.fontColor = .black
        textAnnotation.color = .clear
        textAnnotation.backgroundColor = .clear
        self.addAnnotation(textAnnotation)
    }

    func draw(image: UIImage, x: CGFloat,  y: CGFloat, width: CGFloat, height: CGFloat) {

        let imageBounds = CGRect(
          x: x,
          y: y,
          width: width,
          height: height
        )

        let imageStamp = ImageStampAnnotation(with: image,  forBounds: imageBounds, withProperties: nil)
        self.addAnnotation(imageStamp)
    }
}
func drawText(text: String, x: CGFloat,  y: CGFloat, font: UIFont = font, to pdf: PDFDocument) {

  let textAttributes: [NSAttributedString.Key: Any] =
    [NSAttributedString.Key.font: font]

  let attributedTitle = NSAttributedString(
    string: text,
    attributes: textAttributes
  )

  let textStringSize = attributedTitle.size()

  let titleStringRect = CGRect(
    x: x,
    y: y,
    width: ceil(textStringSize.width),
    height: ceil(textStringSize.height)
  )

  print(textStringSize.width)
    print(textStringSize.height)
  let page = pdf.page(at: 0)

  let textAnnotation = PDFAnnotation(bounds: titleStringRect, forType: .freeText, withProperties: nil)
    textAnnotation.contents =  text
    textAnnotation.font = font
    textAnnotation.fontColor = .black
    textAnnotation.color = .clear
    textAnnotation.backgroundColor = .clear
    page?.addAnnotation(textAnnotation)
}

