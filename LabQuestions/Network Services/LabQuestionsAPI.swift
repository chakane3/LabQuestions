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
        // urlrequest encapulates 2 properties of a load request, the url to load and the policies used to load it
        let request = URLRequest(url: url)
        
//      // set the http methods, e.g GET, POST, DELETE, PUT, UPDATE
        // request.httpMethod = "POST"
        // request.httpBody = data // the http body expects some data
        
//        // this is required when posting, so we inform the POST request of the data type if we dont provide the header value as "application/json"
//        // we will get a decoding error when attempting to decode the JSON
//        request.setValue("appication/json", forHTTPHeaderField: "content-type")
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                
            case .success(let data):
                // construct our [Question] array
                do {
                    // JSONDcoder() is used to convert web data to swift models
                    // JSONEncoder() is used to convert swift model to web data
                    let questions = try JSONDecoder().decode([Question].self, from: data)
                    completion(.success(questions))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
