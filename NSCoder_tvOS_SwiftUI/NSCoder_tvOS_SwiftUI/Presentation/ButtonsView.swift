//
//  ButtonsView.swift
//  NSCoder_tvOS_SwiftUI
//
//  Created by Pedro on 10/11/24.
//

import SwiftUI
import Kingfisher

struct ButtonsView: View {
    @State private var isShowingPlayer = false
    private let imageUrl = "https://images.unsplash.com/photo-1662946834880-99adabd21f80?q=80&w=3328&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    
    var body: some View {
        ZStack {
            Color(.tertiaryLabel)
                .ignoresSafeArea()
            HStack {
                VStack {
                    Button("Button One") {
                        presentPlayer()
                    }
                    
                    Spacer()
                    VStack {
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 390, height: 200)
                        
                        Text("Source: Unsplash by BoliviaInteligente")
                            .multilineTextAlignment(.center)
                            .frame(width: 390)
                            .padding(.top, 15)
                    }
                    
                }
                Spacer()
                VStack {
                    Button("Button Two") {
                        presentPlayer()
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $isShowingPlayer, content: {
                CustomVideoPlayer()
                    .ignoresSafeArea()
            })
            .padding(EdgeInsets(top: 90, leading: 90, bottom: 90, trailing: 90))
        }
    }
    
    func presentPlayer() {
        isShowingPlayer.toggle()
    }
}

#Preview {
    ButtonsView()
}
