//
//  NSCoder_tvOS_UIKitTests.swift
//  NSCoder_tvOS_UIKitTests
//
//  Created by Pedro on 2/11/24.
//

import Testing
@testable import NSCoder_tvOS_Domain
import Foundation

class UseCaseCollections_Test {
    private var sut: UseCaseCollections!
    
    init() {
        self.sut = UseCaseCollections(apiClient: ApiClientMock())
    }
    
    deinit {
        self.sut = nil
    }
    
    @Test
    func loadPhotos() async throws {
        // Given
        var pictures: NSCPictures?
        let expectedPhoto = MockData.mockPhoto()
        
        // When
        pictures = try await sut.loadPhotos()
        
        // Then
        #expect(pictures != nil)
        #expect(pictures!.tech.count == 30)
        #expect(pictures!.mac.count == 30)
        #expect(pictures!.iphone.count == 30)
        #expect(pictures!.appleTV.count == 30)
        #expect(pictures!.mac.count == 30)
        
        let photo = try #require(pictures?.tech.first)
        #expect(photo.id == expectedPhoto?.id)
        #expect(photo.urlThumbnail == expectedPhoto?.urls?.small)
        #expect(photo.urlImage == expectedPhoto?.urls?.full)
        #expect(photo.userName == expectedPhoto?.user?.name)
        #expect(photo.userTwitter == expectedPhoto?.user?.twitterUsername)
    }
    
    @Test
    func loadPhotos_Error() async throws {
        // Given
        sut = UseCaseCollections(apiClient: ApiClientErrorMock())
        var pictures: NSCPictures?
        
        // When & Then
        await #expect(throws: URLError.self, performing: {
            pictures = try await sut.loadPhotos()
        })
        #expect(pictures == nil)
    }
}
