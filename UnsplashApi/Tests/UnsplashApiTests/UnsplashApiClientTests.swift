//
//  NSCoder_tvOS_UIKitTests.swift
//  NSCoder_tvOS_UIKitTests
//
//  Created by Pedro on 2/11/24.
//

import Testing
@testable import UnsplashApi
import Foundation

extension Tag {
    // General Tags
    @Tag static var service: Self
}

enum RequestHeader: String {
    case contentType = "content-type"
    case authorization = "Authorization"
}

@Suite(.tags(.service))
final class UnsplashApiClientTests {
    
    // MARK: - Properties
    var client: UnsplashApiClient!
    let query = "page=1&per_page=30&utm_source=Poster_Maker&utm_medium=referral&utm_campaign=api-credit"
    let authorization = "Client-ID "

    init() async throws {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        
        let session = URLSession(configuration: sessionConfiguration)
        self.client = UnsplashApiClient(session: session)
    }
    
    // MARK: - Deallocation
    deinit {
        self.client = nil
        MockURLProtocol.requestHandler = nil
        MockURLProtocol.error = nil
    }
    
    @Test
    func fetchTechPhotos() async throws {
        // Given
        var serviceRequest: URLRequest?
        let expectedPhoto = MockData.mockPhoto()
        MockURLProtocol.requestHandler = { request in
            serviceRequest = request
            
            let url = try #require(request.url)
            let jsonResponse = try #require(Bundle.module.url(forResource: "MockPhotos", withExtension: "json"))
            let jsonData = try Data(contentsOf: jsonResponse)
            let response = try #require(MockURLProtocol.urlResponseTest(url: url, statusCode: 200))
            
            return (response, jsonData)
        }
        
        var response: [UnsplashPhoto]?
        var errorResponse: Error?
        
        // When
        do {
            response = try await self.client.fetchTechPhotos()
        } catch {
            errorResponse = error
        }
        
        // Then
        #expect(response != nil)
        #expect(errorResponse == nil)
        let requestSentUnwrapped = try #require(serviceRequest)
        #expect(requestSentUnwrapped.httpMethod == APIHTTPMethod.get.rawValue)
        let url = try #require(requestSentUnwrapped.url)
        #expect(url.host == "api.unsplash.com")
        #expect(url.path == UnSplashEndpoint.tech.path())
        #expect(url.query == query)
        #expect(requestSentUnwrapped.value(forHTTPHeaderField: RequestHeader.contentType.rawValue) == "application/json")
        #expect(requestSentUnwrapped.value(forHTTPHeaderField: RequestHeader.authorization.rawValue)?.contains(authorization) == true)
        #expect(response?.first == expectedPhoto)
    }
    
    @Test
    func fetchTechPhotos_Error() async throws {
        // Given
        let expectedError =  NSError(domain: "es.api.unsplash", code: 501)
        MockURLProtocol.error = NSError(domain: "es.api.unsplash", code: 501)
        var response: [UnsplashPhoto]?
        var errorResponse: Error?
        
        // When
        do {
            response = try await self.client.fetchTechPhotos()
        } catch {
            errorResponse = error
        }
        
        // Then
        #expect(response == nil)
        #expect(errorResponse != nil)
        #expect(errorResponse?.localizedDescription == UnsplashError.service(error: expectedError).localizedDescription)
    }
    
    @Test
    func fetchMacPhotos() async throws {
        // Given
        var serviceRequest: URLRequest?
        let expectedPhoto = MockData.mockPhoto()
        MockURLProtocol.requestHandler = { request in
            serviceRequest = request
            
            let url = try #require(request.url)
            let jsonResponse = try #require(Bundle.module.url(forResource: "MockPhotos", withExtension: "json"))
            let jsonData = try Data(contentsOf: jsonResponse)
            let response = try #require(MockURLProtocol.urlResponseTest(url: url, statusCode: 200))
            
            return (response, jsonData)
        }
        
        var response: [UnsplashPhoto]?
        var errorResponse: Error?
        
        // When
        do {
            response = try await self.client.fetchNacPhotos()
        } catch {
            errorResponse = error
        }
        
        // Then
        #expect(response != nil)
        #expect(errorResponse == nil)
        let requestSentUnwrapped = try #require(serviceRequest)
        #expect(requestSentUnwrapped.httpMethod == APIHTTPMethod.get.rawValue)
        let url = try #require(requestSentUnwrapped.url)
        #expect(url.host == "api.unsplash.com")
        #expect(url.path == UnSplashEndpoint.mac.path())
        #expect(url.query == query)
        #expect(requestSentUnwrapped.value(forHTTPHeaderField: RequestHeader.contentType.rawValue) == "application/json")
        #expect(requestSentUnwrapped.value(forHTTPHeaderField: RequestHeader.authorization.rawValue)?.contains(authorization) == true)
        #expect(response?.first == expectedPhoto)
    }
    
    @Test
    func fetchMacPhotos_Error() async throws {
        // Given
        let expectedError =  NSError(domain: "es.api.unsplash", code: 501)
        MockURLProtocol.error = NSError(domain: "es.api.unsplash", code: 501)
        var response: [UnsplashPhoto]?
        var errorResponse: Error?
        
        // When
        do {
            response = try await self.client.fetchNacPhotos()
        } catch {
            errorResponse = error
        }
        
        // Then
        #expect(response == nil)
        #expect(errorResponse != nil)
        #expect(errorResponse?.localizedDescription == UnsplashError.service(error: expectedError).localizedDescription)
    }
    
    @Test
    func fetchIphonePhotos() async throws {
        // Given
        var serviceRequest: URLRequest?
        let expectedPhoto = MockData.mockPhoto()
        MockURLProtocol.requestHandler = { request in
            serviceRequest = request
            
            let url = try #require(request.url)
            let jsonResponse = try #require(Bundle.module.url(forResource: "MockPhotos", withExtension: "json"))
            let jsonData = try Data(contentsOf: jsonResponse)
            let response = try #require(MockURLProtocol.urlResponseTest(url: url, statusCode: 200))
            
            return (response, jsonData)
        }
        
        var response: [UnsplashPhoto]?
        var errorResponse: Error?
        
        // When
        do {
            response = try await self.client.fetchIphonePhotos()
        } catch {
            errorResponse = error
        }
        
        // Then
        #expect(response != nil)
        #expect(errorResponse == nil)
        let requestSentUnwrapped = try #require(serviceRequest)
        #expect(requestSentUnwrapped.httpMethod == APIHTTPMethod.get.rawValue)
        let url = try #require(requestSentUnwrapped.url)
        #expect(url.host == "api.unsplash.com")
        #expect(url.path == UnSplashEndpoint.iphone.path())
        #expect(url.query == query)
        #expect(requestSentUnwrapped.value(forHTTPHeaderField: RequestHeader.contentType.rawValue) == "application/json")
        #expect(requestSentUnwrapped.value(forHTTPHeaderField: RequestHeader.authorization.rawValue)?.contains(authorization) == true)
        #expect(response?.first == expectedPhoto)
    }
    
    @Test
    func fetchIphonePhotos_Error() async throws {
        // Given
        let expectedError =  NSError(domain: "es.api.unsplash", code: 501)
        MockURLProtocol.error = NSError(domain: "es.api.unsplash", code: 501)
        var response: [UnsplashPhoto]?
        var errorResponse: Error?
        
        // When
        do {
            response = try await self.client.fetchIphonePhotos()
        } catch {
            errorResponse = error
        }
        
        // Then
        #expect(response == nil)
        #expect(errorResponse != nil)
        #expect(errorResponse?.localizedDescription == UnsplashError.service(error: expectedError).localizedDescription)
    }
    
    @Test
    func fetchMacintoshPhotos() async throws {
        // Given
        var serviceRequest: URLRequest?
        let expectedPhoto = MockData.mockPhoto()
        MockURLProtocol.requestHandler = { request in
            serviceRequest = request
            
            let url = try #require(request.url)
            let jsonResponse = try #require(Bundle.module.url(forResource: "MockPhotos", withExtension: "json"))
            let jsonData = try Data(contentsOf: jsonResponse)
            let response = try #require(MockURLProtocol.urlResponseTest(url: url, statusCode: 200))
            
            return (response, jsonData)
        }
        
        var response: [UnsplashPhoto]?
        var errorResponse: Error?
        
        // When
        do {
            response = try await self.client.fetchMacintoshPhotos()
        } catch {
            errorResponse = error
        }
        
        // Then
        #expect(response != nil)
        #expect(errorResponse == nil)
        let requestSentUnwrapped = try #require(serviceRequest)
        #expect(requestSentUnwrapped.httpMethod == APIHTTPMethod.get.rawValue)
        let url = try #require(requestSentUnwrapped.url)
        #expect(url.host == "api.unsplash.com")
        #expect(url.path == UnSplashEndpoint.macintosh.path())
        #expect(url.query == query)
        #expect(requestSentUnwrapped.value(forHTTPHeaderField: RequestHeader.contentType.rawValue) == "application/json")
        #expect(requestSentUnwrapped.value(forHTTPHeaderField: RequestHeader.authorization.rawValue)?.contains(authorization) == true)
        #expect(response?.first == expectedPhoto)
    }
    
    @Test
    func fetchMacintoshPhotos_Error() async throws {
        // Given
        let expectedError =  NSError(domain: "es.api.unsplash", code: 501)
        MockURLProtocol.error = NSError(domain: "es.api.unsplash", code: 501)
        var response: [UnsplashPhoto]?
        var errorResponse: Error?
        
        // When
        do {
            response = try await self.client.fetchTechPhotos()
        } catch {
            errorResponse = error
        }
        
        // Then
        #expect(response == nil)
        #expect(errorResponse != nil)
        #expect(errorResponse?.localizedDescription == UnsplashError.service(error: expectedError).localizedDescription)
    }
    
    @Test
    func fetchAppleTVPhotos() async throws {
        // Given
        var serviceRequest: URLRequest?
        let expectedPhoto = MockData.mockPhoto()
        MockURLProtocol.requestHandler = { request in
            serviceRequest = request
            
            let url = try #require(request.url)
            let jsonResponse = try #require(Bundle.module.url(forResource: "MockPhotos", withExtension: "json"))
            let jsonData = try Data(contentsOf: jsonResponse)
            let response = try #require(MockURLProtocol.urlResponseTest(url: url, statusCode: 200))
            
            return (response, jsonData)
        }
        
        var response: [UnsplashPhoto]?
        var errorResponse: Error?
        
        // When
        do {
            response = try await self.client.fetchAppleTVPhotos()
        } catch {
            errorResponse = error
        }
        
        // Then
        #expect(response != nil)
        #expect(errorResponse == nil)
        let requestSentUnwrapped = try #require(serviceRequest)
        #expect(requestSentUnwrapped.httpMethod == APIHTTPMethod.get.rawValue)
        let url = try #require(requestSentUnwrapped.url)
        #expect(url.host == "api.unsplash.com")
        #expect(url.path == UnSplashEndpoint.appleTV.path())
        #expect(url.query == query)
        #expect(requestSentUnwrapped.value(forHTTPHeaderField: RequestHeader.contentType.rawValue) == "application/json")
        #expect(requestSentUnwrapped.value(forHTTPHeaderField: RequestHeader.authorization.rawValue)?.contains(authorization) == true)
        #expect(response?.first == expectedPhoto)
    }
    
    @Test
    func fetchAppleTVPhotos_Error() async throws {
        // Given
        let expectedError =  NSError(domain: "es.api.unsplash", code: 501)
        MockURLProtocol.error = NSError(domain: "es.api.unsplash", code: 501)
        var response: [UnsplashPhoto]?
        var errorResponse: Error?
        
        // When
        do {
            response = try await self.client.fetchAppleTVPhotos()
        } catch {
            errorResponse = error
        }
        
        // Then
        #expect(response == nil)
        #expect(errorResponse != nil)
        #expect(errorResponse?.localizedDescription == UnsplashError.service(error: expectedError).localizedDescription)
    }
    
}

