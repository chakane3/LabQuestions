//
//  UIImageView+Extensions.swift
//  LabQuestions
//
//  Created by Chakane Shegog on 11/10/21.
//

import UIKit

// here we have an extension in UIImageView to help us get a
// UIImage using our URLSession wrapper class (network helper)

extension UIImageView {
    func getImage(with urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        // UIActivityIndicatoeView is used to indicate to the user that a download is in progress
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .orange
        activityIndicator.startAnimating()
        activityIndicator.center = center
        addSubview(activityIndicator)    // we add the indicator as a subview of the image view
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) {[weak activityIndicator] (result) in
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()
            }
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }
        }
    }
}
