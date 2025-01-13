//
//  TextFieldsView.swift
//  NSCoder_tvOS_SwiftUI
//
//  Created by Pedro on 10/11/24.
//

import SwiftUI

struct TextFieldsView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            Color.init(uiColor: .tertiaryLabel)
                .ignoresSafeArea()
            VStack(spacing: 60){
                TextField("User name", text: self.$username)
                    .textFieldLoginStyle()
     
                SecureField("Password", text: self.$password)
                    .textFieldLoginStyle()
                    .id(2)
                
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Entrar")
                        .font(.title2)
                        .frame(minWidth: 300, minHeight: 50)
                }
                .padding(.top, 50)
                .id(3)
                
            }
        }
        .alert("NSCoder tvOS", isPresented: $showAlert, actions: {
            Text("Ok")
        }, message: {
            Text("This is a sample of Alert in tvOS")
        })
    }
}
    #Preview {
        TextFieldsView()
    }
    
extension View {
    func textFieldLoginStyle() -> some View {
        modifier(TextFieldLoginStyle())
    }
}

struct TextFieldLoginStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: 500)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
    }
}
