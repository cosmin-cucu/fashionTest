//
//  NetworkService.swift
//  fashionTest
//
//  Created by Cosmin Cucu on 6/12/24.
//

import Foundation
import UIKit

protocol NetworkServicing {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}

// Network Service to handle GET requests
class NetworkService: NetworkServicing {
    private let baseURL = "https://m.fashiondays.com/mobile/9/g/women/clothing/"
    
    /// CODE SMELL, RAN OUT OF TIME -> THIS VARIABLE SHOULD BE LET (implemented with var to have UGLY service injection during testing possible)
    static var shared: NetworkServicing = NetworkService()
    
    private init() { }

    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        // Validate URL
        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        // Create URLRequest
        var request = URLRequest(url: url)
        request.setValue("ro_RO", forHTTPHeaderField: "x-mobile-app-locale")

        // Create URLSession data task
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle errors
            if let error = error {
                completion(.failure(error))
                return
            }

            // Validate HTTP response
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(.failure(NetworkError.invalidResponse(httpResponse.statusCode)))
                return
            }

            // Ensure data is received
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                // Decode the dictionary containing the products array
                let responseObject = try JSONDecoder().decode(ProductsResponse.self, from: data)
                completion(.success(responseObject.products))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    completion(nil)
                    return
                }

                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
        }
}

// Network error types
enum NetworkError: Error {
    case invalidURL
    case invalidResponse(Int)
    case noData
}
