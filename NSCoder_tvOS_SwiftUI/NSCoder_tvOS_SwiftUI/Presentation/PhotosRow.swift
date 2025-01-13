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
    
    var body: some View {
        ScrollView(.horizontal){
            LazyHStack{
                ForEach(sectionPhotos){ photo in
                    PhotoView(photo: photo)
                        .onTapGesture {
                            self.photo = photo
                        }
                }
            }
        }
        .sheet(item: $photo, onDismiss: {
            self.photo = nil
        }, content: { photo in
            PhotoDetailView(photo: photo)
        })
    }
}

struct PhotoView: View {
    @State private var photo: NSCPhoto
    
    init(photo: NSCPhoto) {
        self.photo = photo
    }
    
    var body: some View {
        KFImage.init(URL(string: photo.urlThumbnail ?? ""))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 420, height: 235)
    }
}
