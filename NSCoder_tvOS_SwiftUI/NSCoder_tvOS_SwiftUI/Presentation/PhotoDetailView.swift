//
//  PhotoDetailView.swift
//  NSCoder_tvOS_SwiftUI
//
//  Created by Pedro on 10/11/24.
//

import SwiftUI
import NSCoder_tvOS_Domain
import Kingfisher

struct PhotoDetailView: View {
    @State private var photo: NSCPhoto
    
    init(photo: NSCPhoto) {
        self.photo = photo
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.init(uiColor: .tertiaryLabel)
                VStack{
                    KFImage.init(URL(string: photo.urlImage ?? ""))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .clipped()
                }
                .overlay(alignment: .bottomTrailing) {
                    VStack(alignment: .leading) {
                        Text(photo.userName ?? "")
                            .font(.caption)
                        if let twitter = photo.userTwitter {
                            Text("@\(twitter)")
                                .font(.caption)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    PhotoDetailView(photo: MockData.mockPhoto()!.mapToPhoto())
}
