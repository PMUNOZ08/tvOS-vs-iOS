//
//  UseCaseCollections.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 8/11/24.
//

import Foundation
import UnsplashApi

public protocol UseCaseCollectionProtocol: Sendable {
    func loadPhotos() async throws -> NSCPictures
}


public struct UseCaseCollections: UseCaseCollectionProtocol, Sendable {
    
    private let apiClient: UnsplashApiClientProtocol
    
    public init(apiClient: UnsplashApiClientProtocol = UnsplashApiClient()) {
        self.apiClient = apiClient
    }
    
    public func loadPhotos() async throws -> NSCPictures {
        
        async let tech = try await apiClient.fetchTechPhotos(page: 1).map{$0.mapToPhoto()}
        async let mac = try await apiClient.fetchNacPhotos(page: 1).map{$0.mapToPhoto()}
        async let iphone = try await apiClient.fetchIphonePhotos(page: 1).map{$0.mapToPhoto()}
        async let appleTV = try await apiClient.fetchAppleTVPhotos(page: 1).map{$0.mapToPhoto()}
        async let macintosh = try await apiClient.fetchMacintoshPhotos(page: 1).map{$0.mapToPhoto()}
        
        let result = try await (tech, mac, iphone, appleTV, macintosh)
        
        let photos = NSCPictures.init(tech: result.0, mac: result.1, iphone: result.2, appleTV: result.3, macintosh: result.4)
        return photos
    }
}


public extension UnsplashPhoto {
    func mapToPhoto() -> NSCPhoto {
        return NSCPhoto(id: self.id,
                     urlThumbnail: self.urls?.small,
                     urlImage: self.urls?.full,
                     userName: self.user?.name,
                     userTwitter: self.user?.twitterUsername)
    }
}
