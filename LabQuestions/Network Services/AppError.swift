//
//  AppError.swift
//  LabQuestions
//
//  Created by Chakane Shegog on 11/10/21.
//

import Foundation

enum AppError: Error {
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case encodingError(Error)
    case badStatusCode(Int)
    case badMimeType(String)
}
