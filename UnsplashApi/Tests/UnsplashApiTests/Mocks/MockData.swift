//
//  MockData.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 3/11/24.
//

@testable import UnsplashApi
import Foundation

struct MockData {
    class Bar {}
    static func mockdDataPhotos() throws -> Data {
        guard let url =  Bundle.module.url(forResource: "MockPhotos", withExtension: "json") else {
            throw UnsplashError.badUrl
        }
        return try Data(contentsOf: url)
    }
    
    static func mockPhoto() -> UnsplashPhoto? {
        do {
            let data = try mockdDataPhotos()
            let decoder = JSONDecoder()
            let photo = try decoder.decode([UnsplashPhoto].self, from: data).first
            return photo
        } catch {
            return nil
        }
    }
}
