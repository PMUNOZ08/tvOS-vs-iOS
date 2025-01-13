//
//  PhotosRow.swift
//  NSCoder_tvOS_SwiftUI
//
//  Created by Pedro on 24/11/24.
//
import SwiftUI
import Kingfisher
import NSCoder_tvOS_Domain

struct PhotosRow: View {
    
    var sectionPhotos: [NSCPhoto]
    @State private var photo: NSCPhoto?
    @FocusState private var focused: String?
    
    var body: some View {
        ScrollView(.horizontal){
            LazyHStack{
                ForEach(sectionPhotos){ photo in
                    Button {
                        self.photo = photo
                    } label: {
                        PhotoView(photo: photo)
                            .frame(width: 420, height: 235)
                            .hoverEffect(.highlight)
                    }
                    .buttonStyle(.card)
                    .focused($focused, equals: photo.id)
                }
            }
        }
        .scrollClipDisabled(true)
        .sheet(item: $photo, onDismiss: {
            self.photo = nil
            focused = "cGkz-4Vy1qs"
        }, content: { photo in
            PhotoDetailView(photo: photo)
        })
        .onAppear(perform: {
            focused = "cGkz-4Vy1qs"
        })
    }
}


struct PhotoView: View {
    @State private var photo: NSCPhoto
    @Environment(\.isFocused) var isFocused
    
    init(photo: NSCPhoto) {
        self.photo = photo
    }
    var body: some View {
        KFImage.init(URL(string: photo.urlThumbnail ?? ""))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .opacity(isFocused ? 1 : 0.6)
    }
}
