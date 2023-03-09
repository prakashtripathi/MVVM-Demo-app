//
//  EndPointType.swift
//  Youtube MVVM Products
//
//  Created by Prakash Tripathi on 06/03/23.
//

import Foundation


enum HttpMethod : String {
    
    case get = "GET"
    case post = "POST"
    
}


protocol EndPointType {
    var path : String { get }
    var baseUrl : String { get }
    var url : String? { get }
    var method : HttpMethod { get }
    var httpHeader : [String : String]? { get }
    var body : Encodable? { get }
    
}


