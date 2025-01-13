//
//  CollectionsView.swift
//  NSCoder_tvOS_SwiftUI
//
//  Created by Pedro on 10/11/24.
//

import SwiftUI
import Kingfisher
import NSCoder_tvOS_Domain

struct CollectionsView: View {
    
    @State private var viewModel: CollectionsViewModel
    
    init(viewModel: CollectionsViewModel = .init()) {
        self.viewModel = viewModel
    }
    var body: some View {
        ZStack {
            Color.init(uiColor: .tertiaryLabel)
                .ignoresSafeArea()
            ScrollView{
                ForEach(CollectionSections.allCases, id: \.self){ section in
                    VStack(alignment: .leading){
                        Text("\(viewModel.titleFor(section: section.rawValue) ?? "No title")")
                            .font(.title3)
                        PhotosRow(sectionPhotos: viewModel.photosFor(section: section))
                    }
                }
            }
        }
        .task {
            await viewModel.loadData()
        }
    }
}

#Preview {
    CollectionsView()
}
