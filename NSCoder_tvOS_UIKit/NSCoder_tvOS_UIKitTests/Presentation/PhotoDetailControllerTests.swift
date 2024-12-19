//
//  PhotoDetailControllerTests.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 10/11/24.
//

import UIKit
import Testing
@testable import NSCoder_tvOS_UIKit

@MainActor
struct PhotoDetailControllerTests {
    
    @Test(.tags(.presentation))
    func viewDidLoad() async throws {
        // Gicen
        let photo = MockData.mockPhoto()!.mapToPhoto()
        let sut = PhotoDetailController(photo: photo)

        // When
         sut.loadViewIfNeeded()
        
        //Then
        try #require(sut.imgView != nil)
        try #require(sut.lbUsername != nil)
        try #require(sut.lbTwitterAcoount != nil)
        try #require(sut.imgView != nil)

        #expect(sut.lbUsername.text  == photo.userName)
        #expect(sut.lbTwitterAcoount.text  == photo.userTwitter)
    }

}
