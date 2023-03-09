//
//  ProductEndPoint.swift
//  Youtube MVVM Products
//
//  Created by Prakash Tripathi on 09/03/23.
//

import Foundation


enum EndPointItems {
    case ProductListing
    case AddProduct(Product : AddProduct)
}


extension EndPointItems : EndPointType{
    var httpHeader: [String : String]? {
            return ApiManager.commonHeader
        }
    
    
    var body: Encodable? {
        switch self {
        case .ProductListing:
            return nil
        case .AddProduct(Product: let product):
            return product
            
        }
    }
    
    var path: String {
        switch self {
        case .ProductListing:
            return "products"
        case .AddProduct:
            return "products/add"
        }
    }
    
    var baseUrl: String {
        switch self {
        case .ProductListing:
            return "https://fakestoreapi.com/"
        case .AddProduct:
            return "https://dummyjson.com/"
        }
       
    }
    
    var url: String? {
        return "\(baseUrl)\(path)"
    }
    
    var method: HttpMethod {
        switch self {
        case .ProductListing:
            return .get
        case .AddProduct:
            return .post
        }
    }
    
}
