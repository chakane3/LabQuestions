//
//  Question.swift
//  LabQuestions
//
//  Created by Chakane Shegog on 11/10/21.
//

import Foundation

struct Question: Decodable {
    let id: String
    // let createdAt: String // creating a date stamp
    let name: String
    let avatar: String
    let title: String
    let description: String
    let labName: String
}
