//
//  NSCPhoto.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 8/11/24.
//

public struct NSCPhoto: Identifiable, Hashable, Sendable {
    
    public let id: String
    public let urlThumbnail: String?
    public let urlImage: String?
    public let userName: String?
    public let userTwitter: String?
    
    init(id: String, urlThumbnail: String?, urlImage: String?, userName: String?, userTwitter: String?) {
        self.id = id
        self.urlThumbnail = urlThumbnail
        self.urlImage = urlImage
        self.userName = userName
        self.userTwitter = userTwitter
    }
}
