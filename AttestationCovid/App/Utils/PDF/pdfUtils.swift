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
let font =  UIFont(name: "HelveticaNeue-Thin", size: sizeFont)!
//let font = UIFont.systemFont(ofSize: 11)

func generatePdf(profilPDF: ProfilPDF, reasons: [RaisonPDF]) -> Data? {
    let pdfBase = Bundle.main.url(forResource: "attestation", withExtension: "pdf", subdirectory: nil, localization: nil)!

    let dateFormater = DateFormatter()
    dateFormater.dateStyle = .short
    dateFormater.timeStyle = .short
    dateFormater.locale = Locale(identifier: "FR.fr")

    let creationInstant = Date()

    let creationDate = creationInstant.getDate()

    let creationHour = creationInstant.getHours()

    let lastname = profilPDF.profil.lastName
    let firstname = profilPDF.profil.firstName
    let birthday = profilPDF.profil.birthday
    let placeofbirth = profilPDF.profil.birthPlace
    let address = profilPDF.profil.address
    let zipcode = profilPDF.profil.zipcode
    let city = profilPDF.profil.locality
    let datesortie = profilPDF.datesortie
    let heuresortie = profilPDF.heuresortie


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
    page1.draw(text: birthday.getDate(), x: 119, y: 645)
    page1.draw(text: placeofbirth, x: 312, y: 645)
    page1.draw(text: "\(address) \(zipcode) \(city)", x: 133, y: 625)

    reasons.forEach {
        page1.draw(text: "X", x: 72, y: CGFloat(ys[$0.rawValue]!))
    }

    page1.draw(text: profilPDF.profil.locality, x: 105, y: 286)
    page1.draw(text: profilPDF.datesortie.getDate(), x: 91, y: 267)
    page1.draw(text: profilPDF.heuresortie.getHours(), x: 312, y: 267)


    page1.draw(text: "Date de création", x: 479, y: 130)
    page1.draw(text: "\(creationDate) à \(creationHour)", x: 470, y: 124)


    let qrCode = generateQRCode(from: data)
    let bounds = pdfDoc.page(at: 0)?.bounds(for: PDFDisplayBox.mediaBox)
    let size = bounds?.size
    pdfDoc.page(at: 0)?.draw(image: qrCode, x: size!.width - 125, y:  125, width: 92, height: 92)

    let page2 = PDFPage()
    let bounds2 = pdfDoc.page(at: 0)?.bounds(for: PDFDisplayBox.mediaBox)
    let size2 = bounds2?.size
    page2.draw(image: generateQRCode(from: data), x: 50, y: size2!.height - 400, width: 300, height: 300)
    pdfDoc.insert(page2, at: 1)

    return pdfDoc.dataRepresentation()
}


extension PDFPage {

    func draw(text: String, x: CGFloat,  y: CGFloat, fontSize: CGFloat = 11,  font: UIFont = font) {

      let fontGeneral = font.withSize(fontSize)
      let textAttributes: [NSAttributedString.Key: Any] =
        [
            NSAttributedString.Key.font: fontGeneral,
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]

      let attributedTitle = NSAttributedString(
        string: text,
        attributes: textAttributes
      )

      let textStringSize = attributedTitle.size()

      let titleStringRect = CGRect(
        x: x,
        y: y - 5,
        width: ceil(textStringSize.width) + 5,
        height: ceil(textStringSize.height) + 5
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
