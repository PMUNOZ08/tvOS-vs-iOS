//
//  User.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//

public struct User: Codable, Equatable, Hashable, Sendable {
    public let id, name, twitterUsername: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case twitterUsername = "twitter_username"
    }
}
