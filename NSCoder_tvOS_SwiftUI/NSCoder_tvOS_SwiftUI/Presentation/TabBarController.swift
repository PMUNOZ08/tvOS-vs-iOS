//
//  ContentView.swift
//  NSCoder_tvOS_SwiftUI
//
//  Created by Pedro on 2/11/24.
//
import SwiftUI

enum Tabs: Equatable, Hashable {
    case buttons
    case textfields
    case collections
}

struct TabBarController: View {
    @State private var selection: Tabs = .buttons
    
    var body: some View {
        
        TabView(selection: $selection) {
            Tab("Buttons", systemImage: "", value: .buttons) {
                ButtonsView()
            }
            Tab("TextFields", systemImage: "", value: .textfields) {
                TextFieldsView()
            }
            Tab("Collections", systemImage: "", value: .collections) {
                CollectionsView()
            }
        }
        .tabViewStyle(.automatic)
    }
}

#Preview {
    TabBarController()
}





