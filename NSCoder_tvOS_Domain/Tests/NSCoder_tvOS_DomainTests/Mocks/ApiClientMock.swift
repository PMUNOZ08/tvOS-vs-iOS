//
//  ApiClientMock.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 8/11/24.
//

import Foundation
import UnsplashApi

@testable import NSCoder_tvOS_Domain

struct ApiClientMock: UnsplashApiClientProtocol {
    func fetchTechPhotos(page: Int) async throws -> [UnsplashApi.UnsplashPhoto] {
        try MockData.photos()
    }
    
    func fetchNacPhotos(page: Int) async throws -> [UnsplashApi.UnsplashPhoto] {
        try MockData.photos()
    }
    
    func fetchIphonePhotos(page: Int) async throws -> [UnsplashApi.UnsplashPhoto] {
        try MockData.photos()
    }
    
    func fetchMacintoshPhotos(page: Int) async throws -> [UnsplashApi.UnsplashPhoto] {
        try MockData.photos()
    }
    
    func fetchAppleTVPhotos(page: Int) async throws -> [UnsplashApi.UnsplashPhoto] {
        try MockData.photos()
    }
    
}

struct ApiClientErrorMock: UnsplashApiClientProtocol {
    func fetchTechPhotos(page: Int) async throws -> [UnsplashApi.UnsplashPhoto] {
        throw URLError(.badServerResponse)
    }
    
    func fetchNacPhotos(page: Int) async throws -> [UnsplashApi.UnsplashPhoto] {
        throw URLError(.badServerResponse)
    }
    
    func fetchIphonePhotos(page: Int) async throws -> [UnsplashApi.UnsplashPhoto] {
        throw URLError(.badServerResponse)
    }
    
    func fetchMacintoshPhotos(page: Int) async throws -> [UnsplashApi.UnsplashPhoto] {
        throw URLError(.badServerResponse)
    }
    
    func fetchAppleTVPhotos(page: Int) async throws -> [UnsplashApi.UnsplashPhoto] {
        throw URLError(.badServerResponse)
    }
    
    
    
}
