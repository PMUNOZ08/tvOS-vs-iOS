//
//  CustomVideoPlayer.swift
//  NSCoder_tvOS_SwiftUI
//
//  Created by Pedro on 10/11/24.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer: View {
    
    let video1 = "https://devstreaming-cdn.apple.com/videos/streaming/examples/adv_dv_atmos/main.m3u8"
   
    var body: some View {
        if let player = createPlayer() {
            VideoPlayer(player: player)
                .onAppear(perform: {
                    player.play()
                })
        } else {
            Text("Error initializing player")
        }
    }
    
    func createPlayer() -> AVPlayer? {
        let urlStr = video1
        if let url = URL(string: urlStr) {
            let playerItem = AVPlayerItem(url: url)
            let player = AVPlayer(playerItem: playerItem)
            return player
        } else {
            return nil
        }
    }
}

#Preview {
    CustomVideoPlayer()
}
