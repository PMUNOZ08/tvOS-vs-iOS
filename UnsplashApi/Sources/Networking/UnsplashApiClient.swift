//
//  UnsplashApiClient.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//

import Foundation

public protocol UnsplashApiClientProtocol: Sendable {
 
    func fetchTechPhotos(page: Int) async throws -> [UnsplashPhoto]
    func fetchNacPhotos(page: Int) async throws -> [UnsplashPhoto]
    func fetchIphonePhotos(page: Int) async throws -> [UnsplashPhoto]
    func fetchMacintoshPhotos(page: Int) async throws -> [UnsplashPhoto]
    func fetchAppleTVPhotos(page: Int) async throws -> [UnsplashPhoto]
}


public actor UnsplashApiClient: UnsplashApiClientProtocol {
    
    private let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func fetchTechPhotos(page: Int = 1) async throws -> [UnsplashPhoto] {
        do {
            let requestBuilder = UnsplashRequestBuilder(endPoint: .tech)
            let request = try requestBuilder.build()
            return try await makeRequest(request: request)
        } catch {
            throw error
        }
    }
    
    public func fetchNacPhotos(page: Int = 1) async throws -> [UnsplashPhoto] {
        do {
            let requestBuilder = UnsplashRequestBuilder(endPoint: .mac)
            let request = try requestBuilder.build()
            return try await makeRequest(request: request)
        } catch {
            throw error
        }
    }
    
    public func fetchIphonePhotos(page: Int = 1) async throws -> [UnsplashPhoto] {
        do {
            let requestBuilder = UnsplashRequestBuilder(endPoint: .iphone)
            let request = try requestBuilder.build()
            return try await makeRequest(request: request)
        } catch {
            throw error
        }
    }
    
    public func fetchMacintoshPhotos(page: Int = 1) async throws -> [UnsplashPhoto] {
        do {
            let requestBuilder = UnsplashRequestBuilder(endPoint: .macintosh)
            let request = try requestBuilder.build()
            return try await makeRequest(request: request)
        } catch {
            throw error
        }
    }
    
    public func fetchAppleTVPhotos(page: Int = 1) async throws -> [UnsplashPhoto] {
        do {
            let requestBuilder = UnsplashRequestBuilder(endPoint: .appleTV)
            let request = try requestBuilder.build()
            return try await makeRequest(request: request)
        } catch {
            throw error
        }
    }
        
    func makeRequest<T: Decodable>(request: URLRequest) async throws(UnsplashError) -> T {
        let validStatus = 200...299
        
        do {
            guard let (data, response) = try await session.data(for: request) as? (Data, HTTPURLResponse),
                  validStatus.contains(response.statusCode) else {
                throw UnsplashError.networkError
            }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                debugPrint(error.localizedDescription)
                throw UnsplashError.parsingData(error: error)
            }
        } catch {
            throw UnsplashError.service(error: error)
        }
    }
}
