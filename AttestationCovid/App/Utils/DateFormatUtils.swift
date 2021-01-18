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
        dateFormater.dateFormat = "HH:mm"
        dateFormater.timeZone = TimeZone.current

        return dateFormater.string(from: self)
    }

    func getDate() -> String {
        let dateFormater = DateFormatter()

        dateFormater.dateFormat = "MM/dd/yyyy"
        dateFormater.timeZone = TimeZone.current

        return dateFormater.string(from: self)
    }

    func getDateAndHour() -> String {
        let dateFormater = DateFormatter()

        dateFormater.dateFormat = "HH:mm_dd_MM"
        dateFormater.timeZone = TimeZone.current

        return dateFormater.string(from: self)
    }
}
