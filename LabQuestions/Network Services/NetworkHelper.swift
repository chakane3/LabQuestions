//
//  NetworkHelper.swift
//  LabQuestions
//
//  Created by Chakane Shegog on 11/10/21.
//

import Foundation
// network helper is a wrapper around URLSESSION
class NetworkHelper {
    // a shared instance of our class
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    // this initializer is private to enforce a singleton design
    // it also forbids anyone from creating an instance of our class
    private init() {
        session = URLSession(configuration: .default)
    }
    
    func performDataTask(with request: URLRequest, completion: @escaping (Result<Data, AppError>) -> ()) {
        // remember that theres 2 states on a dataTask, resume and suspeneded
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            // check for network client errors
            if let error = error {
                completion(.failure(.networkClientError(error)))
            }
            
            // downcast URLResponse (response) to HTTPURLResponse to get access to the status code property on HTTPURLResponse
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            // unwrap the data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // validate that the status code is in the 200 range
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            
            // capture our data
            completion(.success(data))
        }
        dataTask.resume()
    }
}
