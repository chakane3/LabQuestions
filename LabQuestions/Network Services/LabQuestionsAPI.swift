//
//  LabQuestionsAPI.swift
//  LabQuestions
//
//  Created by Chakane Shegog on 11/10/21.
//

import Foundation

struct LabQuestionsAPIClient {
    
    static func fetchQuestions(completion: @escaping (Result<[Question], AppError>) -> ()) {
        let labEndpointURLString = "https://5df04c1302b2d90014e1bd66.mockapi.io/questions"
        
        
        // create a URL from the endpoint string
        guard let url = URL(string: labEndpointURLString) else {
            completion(.failure(.badURL(labEndpointURLString)))
            return
        }
        
        // make a url request object to pass to the network helper
        
    }
}
