//
//  EndPoint.swift
//  NetworkLayer
//
//  Created by Baran Baran on 3.04.2024.
//

import Foundation


// https://jsonplaceholder.typicode.com/users
// Base url : https://jsonplaceholder.typicode.com/
// EndPoint/Path : users
// Proje de birden fazla endPoint olabilir bunun için ayırmak iyidir.
// İsteği HttpMethod get post ile atarız bunun için enum içinde method oluşturalım
// users endPointi için enum yazalım ve extensions ile genişletelim. Daha güvenilir olması için protokol de yazalım. Protokol bize kuralları söyleyecek
// Protokolümüzn vereceği kuraller url de neler olacağıdır.
// EndPointProtokolümüzde baseUrl,path, HTTPMethod enumdan method, headers istek atınca key-value gönderdiğimiz yapıdır. HTTP isteklerinin ve yanıtlarının daha esnek ve güvenli olmasını sağlar. URLRequest dönen func request oluşturulur çünkü her endPoint farklı farklı endPoint alabilir isteği atıcak fonks tekrar tekrar yazmamak için bu şekilde tanımlamalar yaparız.

/* 
 EndPointProtokol Protokolü EndPointimize  uygulayalım:
- baseUrl sabittir onu ekliyip returnleyelim
- Her farklı datada path değişeceği için EndPoint enum belirtilen case'leri tek tek ele almak için switch case diyoruz
- method da aynı şekilde her biri için değişen bir ifade olduğu için switch case ile EndPoint enum caselerini alıoyoruz
- Gelelim func requeste ilk başta url kontrol ediyoruz UrlComponents ve guard kullanımıyla request tanımlayalım. Sonra bu işlem get mi post mu .. http methodunu belirtilelim case string değerine ulaşmak için rawValue demeye dikkat et. Daha sonra headers varsa kontrol et eklemeni yapıp devam et  yoksa requesti döndür

 */

import Foundation

// MARK: - EndpointProtocol
protocol EndpointProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    
    func request() -> URLRequest
}

// MARK: - HTTPMethod
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

// MARK: - Endpoint

enum Endpoint {
    case getUsers
}

extension Endpoint: EndpointProtocol {
    var baseUrl: String {
        return "https://jsonplaceholder.typicode.com/"
    }
    
    var path: String {
        switch self {
        case .getUsers: return "users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers: return .get
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    func request() -> URLRequest {
        guard let urlComponents = URLComponents(string: baseUrl + path) else {
            fatalError("URL Components Error")
        }
        guard let url = urlComponents.url else {
            fatalError("URL Error")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
