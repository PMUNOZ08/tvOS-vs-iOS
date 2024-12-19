//
//  CollectionsViewModel_Tests.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 8/11/24.
//


import Testing
@testable import NSCoder_tvOS_UIKit
import Foundation

@MainActor
@Suite(.tags(.presentation))
class CollectionsViewModel_Tests {
    private var sut: CollectionsViewModel!
    
    init() {
        self.sut = CollectionsViewModel(useCase: UseCaseCollectionsMock())
    }
    
    deinit {
        self.sut = nil
    }
    
    @Test
    func loadData() async throws {
        // Given
        let expectedStatus = CollectionStatus.updatedTechPhotos
        
        // When
        await sut.loadData()
        
        // Then
        #expect(sut.status == expectedStatus)
    }
    
    @Test
    func loadData_Error() async throws {
        // Given
        self.sut = CollectionsViewModel(useCase: UseCaseCollectionsErrorMock())
        let expectedStatus = CollectionStatus.failure
        // When
        await sut.loadData()
        
        // Then
        #expect(sut.status == expectedStatus)
    }
    
    
    
    @Test(arguments: [IndexPath(item: 0, section: 0),
                      IndexPath(item: 0, section: 1),
                      IndexPath(item: 0, section: 2),
                      IndexPath(item: 0, section: 3),
                      IndexPath(item: 0, section: 4)
                     ])
    func photo(at index: IndexPath) async {
        // Given
        let expectedPhoto = MockData.mockPhoto()?.mapToPhoto()
        
        // When
        await sut.loadData()
        let photo = sut.photo(at: index)
        
        //Then
        #expect(photo == expectedPhoto)
    }
    
    
    
    @Test(arguments: [0, 1, 2, 3, 4])
    func titleFor(section: Int) {
        // Given
        let expectedTitles = CollectionSections.allCases.map{$0.title()}
        
        // When
        let title = sut.titleFor(section: section)
        
        // Then
        #expect(title == expectedTitles[section])
    }
}
    
