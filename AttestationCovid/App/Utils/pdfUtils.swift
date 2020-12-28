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

let sizeFont = CGFloat(20.0)
let font =  UIFont(name: "HelveticaNeue-Thin", size: sizeFont)!

func generatePdf(profile: Profile, reasons: [Raison], pdfBase: Data) {
    let dateFormater = DateFormatter()
    dateFormater.dateStyle = .short
    dateFormater.timeStyle = .short
    dateFormater.locale = Locale(identifier: "FR.fr")

    let creationInstant = Date()

    let creationDate = dateFormater.string(from: creationInstant)

    dateFormater.dateFormat = "hh:mm"
    let creationHour = dateFormater.string(from: creationInstant)
//    .toLocaleTimeString('fr-FR', { hour: '2-digit', minute: '2-digit' })
//    .replace(':', 'h')

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
//  .join(";\n")
//
    let pdfDoc = PDFDocument(data: pdfBase)!

//  let existingPdfBytes = await fetch(pdfBase).then((res) => res.arrayBuffer())
//
//  const pdfDoc = await PDFDocument.load(existingPdfBytes)
//
//  // set pdf metadata
    let pdfMetaData = [
        kCGPDFContextTitle: "COVID-19 - Déclaration de déplacement",
       kCGPDFContextSubject: "Attestation de déplacement dérogatoire",
        kCGPDFContextKeywords: "covid19,covid-19,attestation,déclaration,déplacement,officielle,gouvernement"
    ]

    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = pdfMetaData as [String: Any]


//  pdfDoc.setTitle('COVID-19 - Déclaration de déplacement')
//  pdfDoc.setSubject('Attestation de déplacement dérogatoire')
//  pdfDoc.setKeywords([
//    'covid19',
//    'covid-19',
//    'attestation',
//    'déclaration',
//    'déplacement',
//    'officielle',
//    'gouvernement',
//  ])
//  pdfDoc.setProducer('DNUM/SDIT')
//  pdfDoc.setCreator('')
//  pdfDoc.setAuthor("Ministère de l'intérieur")
//
//  const page1 = pdfDoc.getPages()[0]
//

//  const font = await pdfDoc.embedFont(StandardFonts.Helvetica)
//  const drawText = (text, x, y, size = 11) => {
//    page1.drawText(text, { x, y, size, font })
//  }
//
    drawText(text: "\(firstname) \(lastname)", x: 119, y: 665, font: font, to: pdfDoc)
    drawText(text: "01/02/1994", x: 119, y: 645, font: font, to: pdfDoc)
    drawText(text: placeofbirth, x: 312, y: 645, font: font, to: pdfDoc)
    drawText(text: "\(address) \(zipcode) \(city)", x: 133, y: 625, font: font, to: pdfDoc)
//  drawText(`${firstname} ${lastname}`, 119, 665)
//  drawText(birthday, 119, 645)
//  drawText(placeofbirth, 312, 645)
//  drawText(`${address} ${zipcode} ${city}`, 133, 625)
//
    reasons.forEach {
        drawText(text: "x", x: 73, y: CGFloat(ys[$0.rawValue]!), font: font , to: pdfDoc)
    }
//  reasons
//    .split(', ')
//    .forEach(reason => {
//      drawText('x', 73, ys[reason], 12)
//    })
//
//  let locationSize = getIdealFontSize(font, profile.city, 83, 7, 11)
//
//  if (!locationSize) {
//    alert(
//      'Le nom de la ville risque de ne pas être affiché correctement en raison de sa longueur. ' +
//        'Essayez d\'utiliser des abréviations ("Saint" en "St." par exemple) quand cela est possible.',
//    )
//    locationSize = 7
//  }
//
//  drawText(profile.city, 105, 286, locationSize)
//  drawText(`${profile.datesortie}`, 91, 267, 11)
//  drawText(`${profile.heuresortie}`, 312, 267, 11)
//
//  // const shortCreationDate = `${creationDate.split('/')[0]}/${
//  //   creationDate.split('/')[1]
//  // }`
//  // drawText(shortCreationDate, 314, 189, locationSize)
//
//  // // Date création
//  // drawText('Date de création:', 479, 130, 6)
//  // drawText(`${creationDate} à ${creationHour}`, 470, 124, 6)
//
//  const qrTitle1 = 'QR-code contenant les informations '
//  const qrTitle2 = 'de votre attestation numérique'
//
//  const generatedQR = await generateQR(data)
//
//  const qrImage = await pdfDoc.embedPng(generatedQR)
//
//  page1.drawText(qrTitle1 + '\n' + qrTitle2, { x: 440, y: 230, size: 6, font, lineHeight: 10, color: rgb(1, 1, 1) })
//
//  page1.drawImage(qrImage, {
//    x: page1.getWidth() - 156,
//    y: 125,
//    width: 92,
//    height: 92,
//  })
//
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
    width: textStringSize.width,
    height: textStringSize.height
  )

  print(textStringSize.width)
    print(textStringSize.height)
  let page = pdf.page(at: 0)

  let textAnnotation = PDFAnnotation(bounds: titleStringRect, forType: .text, withProperties: nil)
    textAnnotation.contents =  text
    textAnnotation.font = font
    textAnnotation.color = .red
    textAnnotation.backgroundColor = .red
    textAnnotation.fontColor = .red
    page?.addAnnotation(textAnnotation)
}

