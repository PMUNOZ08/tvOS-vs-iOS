//
//  ButtonsContollerTests.swift
//  NSCoder_tvOS_UIKitTests
//
//  Created by Pedro on 10/11/24.
//

import AVKit
import Testing
@testable import NSCoder_tvOS_UIKit

@MainActor
struct ButtonsContollerTests {
    
    private let sut = ButtonsController()

    @Test(.tags(.presentation))
    func viewDidLoad() async throws {
        // When
         sut.loadViewIfNeeded()
        
        //Then
        try #require(sut.btnOne != nil)
        try #require(sut.btnTwo != nil)
        try #require(sut.focusView != nil)
        try #require(sut.imgView != nil)
        try #require(sut.topLabelConstraint != nil)
        
        #expect(AVAudioSession.sharedInstance().category == .playback)
        #expect(AVAudioSession.sharedInstance().mode == .moviePlayback)
    }

}
