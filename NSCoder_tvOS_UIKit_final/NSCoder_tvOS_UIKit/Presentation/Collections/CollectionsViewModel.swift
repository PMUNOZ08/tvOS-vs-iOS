//
//  CollectionStatus.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//

import UIKit
import UnsplashApi
import NSCoder_tvOS_Domain

enum CollectionStatus {
    case loading
    case updatedTechPhotos
    case failure
    case none
}

enum CollectionSections: Int, CaseIterable {
    case tech
    case mac
    case iphone
    case appleTV
    case macintosh
    
    func title() -> String {
        switch self {
        case .tech: return "Tech"
        case .mac: return "Mac"
        case .iphone: return "Iphone"
        case .appleTV: return "Apple TV"
        case .macintosh: return "Macintosh"
        }
    }
}

@MainActor
final class CollectionsViewModel {
    
    let useCase: UseCaseCollectionProtocol
    
    private(set) var photos: NSCPictures = .init()
    @Published var status: CollectionStatus = .none
    
    init(useCase: UseCaseCollectionProtocol = UseCaseCollections()) {
        self.useCase = useCase
    }
    
    func loadData() async{
        status = .loading
        do {
            photos = try await useCase.loadPhotos()
            status = .updatedTechPhotos
        } catch {
            status = .failure
        }
    }
    
    func photo(at index: IndexPath) -> NSCPhoto? {
        
        guard let section = CollectionSections(rawValue: index.section) else { return nil }
        
        switch section {
        case .tech:
            if index.row < photos.tech.count {
                return photos.tech[index.row]
            }
        case .mac:
            if index.row < photos.mac.count {
                return photos.mac[index.row]
            }
        case .iphone:
            if index.row < photos.iphone.count {
                return photos.iphone[index.row]
            }
        case .appleTV:
            if index.row < photos.appleTV.count {
                return photos.appleTV[index.row]
            }
        case .macintosh:
            if index.row < photos.macintosh.count {
                return photos.macintosh[index.row]
            }
        }
        return nil
    }
    
    func titleFor(section: Int) -> String? {
        guard let section = CollectionSections(rawValue: section) else { return nil }
        return section.title()
    }
}
