//
//  UnSplashEndpoints.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//
enum APIHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
enum UnSplashEndpoint: String {
    
    case tech
    case tech2
    case mac
    case mac2
    case iphone
    case iphone2
    case appleTV
    case appleTV2
    case macintosh
    case macintosh2

    func path() -> String {
        switch self {
        case .tech:
            return "/collections/4887749/photos"
        case .tech2:
            return "/collections/1953805/photos"
        case .mac:
            return "/collections/10629580/photos"
        case .mac2:
            return "/collections/8435114/photos"
        case .iphone:
            return "/collections/8435087/photos"
        case .iphone2:
            return "/collections/8230428/photos"
        case .appleTV:
            return "/collections/375548/photos"
        case .appleTV2:
            return "/collections/8FiEMZf_0O8/photos"
        case .macintosh:
            return "/collections/4571450/photos"
        case .macintosh2:
            return "/collections/vY5iTiqKIBQ/photos"
        }
    }
    
    func httpMethod() -> String{
        switch self {
        default:
            return APIHTTPMethod.get.rawValue
        }
    }
    
    func authorizationRequired() -> Bool {
        switch self {
        case .tech, .tech2, .mac, .mac2, .iphone:
            return true
        case .iphone2, .appleTV, .appleTV2, .macintosh, .macintosh2:
            return true
        }
    }
}
