//
//  UnsplashRequestBuilder.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//
import Foundation


final class UnsplashRequestBuilder {

    private let host = "api.unsplash.com"
    private var apiKeyUnplash = "YOUR_API_KEY"
    let endPoint: UnSplashEndpoint
    let params: [String: String]?
 
    init(endPoint: UnSplashEndpoint, params: [String : String]? = nil) {
        self.endPoint = endPoint
        self.params = params
    }
    
    /// Función para obtener la url del request
    /// - Parameter endoPoint: endpoint para el que se crea la url
    /// - Returns: La url a partirr de URLComponents
    private func url() throws(UnsplashError) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = self.host
        components.path = endPoint.path()
        components.queryItems = self.queryParamas()
        if let url = components.url {
            return url
        } else {
            throw UnsplashError.badUrl
        }
    }
    
    private func queryParamas(page: Int = 1) -> [URLQueryItem] {
        
        let queryItems = [URLQueryItem(name: "page", value: "\(page)"),
                          URLQueryItem(name: "per_page", value: "30"),
                          URLQueryItem(name: "utm_source", value: "Poster_Maker"),
                          URLQueryItem(name: "utm_medium", value: "referral"),
                          URLQueryItem(name: "utm_campaign", value: "api-credit")]
        return queryItems
    }

    
    private func setHeaders(url: URL) throws(UnsplashError) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        if endPoint.authorizationRequired() {
            guard !apiKeyUnplash.isEmpty, apiKeyUnplash != "YOUR_API_KEY" else {
                throw UnsplashError.apikeyMissing
            }
            urlRequest.setValue("Client-ID \(apiKeyUnplash)", forHTTPHeaderField: "Authorization")
        }
        if let params {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    func build() throws -> URLRequest {
        let url = try self.url()
        var request = try setHeaders(url: url)
        request.httpMethod = endPoint.httpMethod()
        return request
    }
}
