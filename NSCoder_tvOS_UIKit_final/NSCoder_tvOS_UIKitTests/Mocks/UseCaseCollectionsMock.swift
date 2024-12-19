//
//  UseCaseCollectionsMock.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 8/11/24.
//

import Foundation
import NSCoder_tvOS_Domain
@testable import NSCoder_tvOS_UIKit

struct UseCaseCollectionsMock: UseCaseCollectionProtocol {
    func loadPhotos() throws -> NSCPictures {
        let photos = try MockData.photos().map{$0.mapToPhoto()}
        return NSCPictures(tech: photos, mac: photos, iphone: photos, appleTV: photos, macintosh: photos)
    }
}

struct UseCaseCollectionsErrorMock: UseCaseCollectionProtocol {
    func loadPhotos() throws -> NSCPictures {
        throw URLError(.badServerResponse)
    }
}
