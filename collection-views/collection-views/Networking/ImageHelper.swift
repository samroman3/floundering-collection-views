//
//  ImageHelper.swift
//  collection-views
//
//  Created by David Rifkin on 9/26/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ImageHelper {
    
    // MARK: - Static Properties
    
    static let shared = ImageHelper()
    
    // MARK: - Instance Methods
    
    func getImage(urlStr: String, completionHandler: @escaping (Result<UIImage, AppError>) -> ()) {
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(.badURL))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noDataReceived))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(.notAnImage))
                return
            }
            
            completionHandler(.success(image))
            }.resume()
    }
    
    
    
    
    func fetchFullSizeImage(elementName: String, elementID: Int, completionHandler: @escaping (Result<UIImage,AppError>) -> ()) {
            
            var urlStr = ""
            let name = elementName.lowercased()
            if elementID < 90  {
                urlStr = "http://images-of-elements.com/\(name).jpg"
            } else {
                urlStr = "https://thecoffeeclubme.com/wp-content/uploads/woocommerce-placeholder-1170x1170.png"
                
            }
            guard let url = URL(string: urlStr) else { return }
            NetworkHelper.manager.performDataTask(withUrl: url , andMethod: HTTPMethod.get) { (result) in
                switch result {
                case .failure(let error):
                    print(url)
                    completionHandler(.failure(error))
                case .success(let data):
                    guard let image = UIImage(data: data) else {completionHandler(.failure(.notAnImage))
                        print(url)
                        return
                    }
                    completionHandler(.success(image))
                }
            }
        }
    
    
    // MARK: - Private Properties and Initializers
    
    private init() {}
}

