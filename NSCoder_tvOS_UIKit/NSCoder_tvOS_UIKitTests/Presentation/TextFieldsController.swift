//
//  TextFieldsController.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 10/11/24.
//


import UIKit
import Testing
@testable import NSCoder_tvOS_UIKit

@MainActor
struct TextFieldsControllerTests {
    
    @Test(.tags(.presentation))
    func viewDidLoad() async throws {
        // Gicen
        let sut = TextFiledsController()

        // When
         sut.loadViewIfNeeded()
        
        //Then
        try #require(sut.txtUsername != nil)
        try #require(sut.txtPassword != nil)
    }

}
