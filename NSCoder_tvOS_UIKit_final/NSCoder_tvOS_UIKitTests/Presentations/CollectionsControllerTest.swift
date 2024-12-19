//
//  CollectionsControllerTest.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 10/11/24.
//


import UIKit
import Testing
import NSCoder_tvOS_Domain
@testable import NSCoder_tvOS_UIKit

@MainActor
@Suite(.tags(.presentation))
struct CollectionsControllerTest {
    
    @Test
    func viewDidLoad() async throws {
        // GiVen
        let viewModel = CollectionsViewModel(useCase: UseCaseCollectionsMock())
        let sut = CollectionsController(viewModel: viewModel)
        typealias DataSource = UICollectionViewDiffableDataSource<CollectionSections, NSCPhoto>

        // When
         sut.loadViewIfNeeded()
        
        //Then
        try #require(sut.collectionView != nil)
        try #require(sut.collectionView.delegate != nil)
        try #require(sut.collectionView.dataSource != nil)
        
        #expect(sut.headerElementKind  == "header-element-kind")
        #expect(sut.collectionView.dataSource is DataSource)
    }
    
    @Test
    func loadData() async throws {
        // Given
        let viewModel = CollectionsViewModel(useCase: UseCaseCollectionsMock())
        let sut = CollectionsController(viewModel: viewModel)
        typealias DataSource = UICollectionViewDiffableDataSource<CollectionSections, NSCPhoto>
        
        // When
        sut.loadViewIfNeeded()
        sut.viewWillAppear(false)
        
        //Then
        try #require(sut.collectionView != nil)
        let dataSource = try #require(sut.collectionView.dataSource as? DataSource)
        try await Task.sleep(for: .seconds(1))
        #expect(dataSource.snapshot().sectionIdentifiers.count == 5)
    }
}

