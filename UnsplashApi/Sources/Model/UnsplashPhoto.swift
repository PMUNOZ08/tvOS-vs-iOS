//
//  UnpslashPhoto.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//


import Foundation


public struct UnsplashPhoto: Codable, Identifiable, Hashable, Sendable {

    public let id, slug: String
    let createdAt, updatedAt, promotedAt: String?
    let width, height: Int?
    let color, blurHash, description, altDescription: String?
    public let urls: Urls?
    let links: Links?
    public let user: User?
    
    enum CodingKeys: String, CodingKey {
        case id, slug
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case urls, links
        case user
    }
    
    
    func author() -> String {
        if let twitterUsername = self.user?.twitterUsername {
            return  "@\(twitterUsername)"
        }
        return  self.user?.name ?? ""
    }
}

