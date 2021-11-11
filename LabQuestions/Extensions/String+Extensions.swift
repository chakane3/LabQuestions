//
//  String+Extensions.swift
//  LabQuestions
//
//  Created by Chakane Shegog on 11/10/21.
//

import Foundation

extension String {
    
    // handles date formatting
    static func getISOFormatter() -> ISO8601DateFormatter {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = .current
        isoDateFormatter.formatOptions = [
            .withInternetDateTime,
            .withFullDate,
            .withFullTime,
            .withFractionalSeconds,
            .withColonSeparatorInTimeZone
        ]
        return isoDateFormatter
    }
    
    
    static func getISOTimeStamp() -> String {
        let isoDateFormatter = getISOFormatter()
        let timestamp = isoDateFormatter.string(from: Date())
        return timestamp
    }
    
    func convertISODate() -> String {
        let isoDateformatter = String.getISOFormatter()
        guard let date = isoDateformatter.date(from: self) else {
            return self
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d yyyy, h:mm a"
        
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
