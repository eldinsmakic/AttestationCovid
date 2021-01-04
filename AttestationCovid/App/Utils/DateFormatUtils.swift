//
//  DateFormatUtils.swift
//  AttestationCovid
//
//  Created by eldin smakic on 04/01/2021.
//

import Foundation

public extension Date {

    func getHours() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "hh:mm"

        return dateFormater.string(from: self)
    }

    func getDate() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"

        return dateFormater.string(from: self)
    }
}
