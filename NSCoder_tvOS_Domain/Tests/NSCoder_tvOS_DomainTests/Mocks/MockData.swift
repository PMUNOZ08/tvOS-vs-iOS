//
//  MockData.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 3/11/24.
//

import Foundation
import UnsplashApi
import NSCoder_tvOS_Domain

struct MockData {
    
    class Bar {}
    static func mockdDataPhotos() throws -> Data {
        guard let url =  Bundle.module.url(forResource: "MockPhotos", withExtension: "json") else {
            throw UnsplashError.badUrl
        }
        return try Data(contentsOf: url)
    }
    
    static func photos() throws -> [UnsplashPhoto] {
        let data = try MockData.mockdDataPhotos()
        return try JSONDecoder().decode([UnsplashPhoto].self, from: data)
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