//
//  Untitled.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//

public struct Urls: Codable, Equatable, Hashable, Sendable {
   public let raw, full, regular, small: String?
    let thumb, smallS3: String?
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
