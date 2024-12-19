//
//  NSCPictures.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 3/11/24.
//

public struct NSCPictures: Sendable {
    public let tech: [NSCPhoto]
    public let mac: [NSCPhoto]
    public let iphone: [NSCPhoto]
    public let appleTV: [NSCPhoto]
    public let macintosh: [NSCPhoto]
    
    public init(tech: [NSCPhoto] = [], mac: [NSCPhoto] = [], iphone: [NSCPhoto] = [], appleTV: [NSCPhoto] = [], macintosh: [NSCPhoto] = []) {
        self.tech = tech
        self.mac = mac
        self.iphone = iphone
        self.appleTV = appleTV
        self.macintosh = macintosh
    }
}
