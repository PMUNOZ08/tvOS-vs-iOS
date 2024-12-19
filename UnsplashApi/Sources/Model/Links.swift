//
//  Links.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//

public struct Links: Codable, Equatable, Hashable, Sendable {
    let linksSelf, html, download, downloadLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}
