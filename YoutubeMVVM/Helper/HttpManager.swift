//
//  HttpManager.swift
//  YoutubeMVVM
//
//  Created by Sarath P on 09/02/23.
//

import Foundation
import UIKit

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case message(Error?)
}

typealias ProductCompletion<T> = (Result<T, DataError>) -> Void

//Singleton Design Pattern
//Final class - Inheritance is not possible
final class APIManager {
    
    static let shared = APIManager()
    private init() {} //To prevent creating object outside
    
    /*
    func fetchProducts(completion: @escaping ProductCompletion) {
        guard let url = URL(string: Constant.API.productUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        //Uses background thread
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data, error == nil else { return }
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                //Jsondecorder convert data into Models
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch let error {
                completion(.failure(.message(error)))
            }
        }.resume()
    }
     */
    
    func request<T: Decodable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping ProductCompletion<T>
    ) {
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        //Uses background thread
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data, error == nil else { return }
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                //Jsondecorder convert data into Models
                let products = try JSONDecoder().decode(modelType, from: data)
                completion(.success(products))
            } catch let error {
                completion(.failure(.message(error)))
            }
        }.resume()
    }
}
