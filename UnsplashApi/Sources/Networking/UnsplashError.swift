//
//  UnsplashError.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//

public enum UnsplashError: Error {
    case missingData
    case networkError
    case badUrl
    case apikeyMissing
    case requestWasNil
    case service(error: Error)
    case statusCode(code: Int)
    case dataNoReceived
    case parsingData(error: Error?)
}
