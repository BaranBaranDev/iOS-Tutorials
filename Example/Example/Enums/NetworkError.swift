//
//  NetworkError.swift
//  Example
//
//  Created by Baran Baran on 29.04.2024.
//

import Foundation


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(reason: String)
}

