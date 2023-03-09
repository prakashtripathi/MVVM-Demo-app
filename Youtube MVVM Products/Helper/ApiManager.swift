//
//  ApiManager.swift
//  Youtube MVVM Products
//
//  Created by Prakash Tripathi on 02/03/23.
//

import Foundation

enum DataError : Error{
    
    case invalidResponse
    case invalidURL
    case invalidDecoding
    case invalidData
    case network(_ error : Error?)
    
}


//typealias handler = (Result<[Product], DataError>) -> Void
typealias handler<T> = (Result<T, DataError>) -> Void

class ApiManager {
    static let shared = ApiManager()
    static var commonHeader : [String : String] {
        return [
            "Content-Type" : "application/json"
        ]
    }

    private init(){}
    
    func request<T : Codable>(
        modelType : T.Type,
        type : EndPointType,
        completion : @escaping handler<T>
    ){
        guard let url  = URL(string: type.url!)  else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.method.rawValue
        urlRequest.allHTTPHeaderFields = type.httpHeader
        
        if let parameter =  type.body {
            urlRequest.httpBody = try? JSONEncoder().encode(parameter)
        }

    
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data, error == nil else{
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let products = try JSONDecoder().decode(modelType, from: data)
                completion(.success(products))
            }
            catch{
                completion(.failure(.network(error)))
            }
            
            
            
        }.resume()
        
        
    }
    
    
}

//singleton class without final & private init
//Singleton - class with final keyword - not allow to inherit , private init - not allow to create object of class.


