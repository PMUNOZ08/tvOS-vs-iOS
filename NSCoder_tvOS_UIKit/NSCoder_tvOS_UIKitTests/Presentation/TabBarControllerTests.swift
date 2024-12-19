//
//  TabBarControllerTest.swift
//  NSCoder_tvOS_UIKitTests
//
//  Created by Pedro on 10/11/24.
//

import UIKit
import Testing
@testable import NSCoder_tvOS_UIKit

extension Tag {
    // General Tags
    @Tag static var presentation: Self
}


@MainActor
struct TabBarControllerTests {
    
    private let sut = TabBarController()
    
    @Test(.tags(.presentation))
    func viewDidLoad() async throws {
       // When
        sut.loadViewIfNeeded()
        
        // Then
        #expect(sut.viewControllers?.count == 3)
        
        var nav = try #require(sut.viewControllers?[0] as? UINavigationController)
        #expect(nav.viewControllers[0] is ButtonsController)

        nav = try #require(sut.viewControllers?[1] as? UINavigationController)
        #expect(nav.viewControllers[0] is TextFiledsController)
        
        nav = try #require(sut.viewControllers?[2] as? UINavigationController)
        #expect(nav.viewControllers[0] is CollectionsController)
    }

}
