//
//  ButtonsView.swift
//  NSCoder_tvOS_SwiftUI
//
//  Created by Pedro on 10/11/24.
//

import SwiftUI
import Kingfisher

enum FocusedElement: Int, Equatable{
    case btnOne, btnTwo, btnImage
}

struct ButtonsView: View {
    @State private var isShowingPlayer = false
    @FocusState private var focusedElement: FocusedElement?
    
    @Namespace var mainNamespace
    @Environment(\.resetFocus) var resetFocus
    
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
                    .focused($focusedElement, equals: .btnOne)
                    Spacer()
                    VStack {
                        Button {
                            resetFocus(in: mainNamespace)
                        } label: {
                                KFImage(URL(string: imageUrl))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 390, height: 200)
                                    .hoverEffect(.highlight)
                        }
                        .focused($focusedElement, equals: .btnImage)
                        Text("Source: Unsplash by BoliviaInteligente")
                            .multilineTextAlignment(.center)
                            .frame(width: 390)
                            .padding(.top, 15)
                    }
                    .buttonStyle(.card)
                }
                Spacer()
                VStack {
                    Button("Button Two") {
                        presentPlayer()
                    }
                    .focused($focusedElement, equals: .btnTwo)
                    Spacer()
                }
                .focusSection()
            }
            .focusScope(mainNamespace)
            .sheet(isPresented: $isShowingPlayer, content: {
                CustomVideoPlayer()
                    .ignoresSafeArea()
            })
            .onChange(of: focusedElement, {
                debugPrint("Focus changed \(String(describing: focusedElement))")
            })
            .padding(EdgeInsets(top: 90, leading: 90, bottom: 90, trailing: 90))
            .defaultFocus($focusedElement, .btnTwo)
        }
        .onPlayPauseCommand {
            debugPrint("Play pause button tapped")
        }
        .onMoveCommand(perform: { direction in
            if direction == .down && focusedElement == .btnTwo{
                focusedElement = .btnImage
            }
        })
    }
    
    func presentPlayer() {
        isShowingPlayer.toggle()
    }
}

#Preview {
    ButtonsView()
}
