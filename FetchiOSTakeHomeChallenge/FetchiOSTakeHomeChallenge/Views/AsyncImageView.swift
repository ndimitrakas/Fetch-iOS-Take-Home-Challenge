//
//  AsyncImageView.swift
//  FetchiOSTakeHomeChallenge
//
//  Created by Nick Dimitrakas on 1/28/25.
//

import SwiftUI

struct AsyncImageView<ViewModel: ImageLoader>: View {
    let url: URL?
    let viewModel: ViewModel
    
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .task {
                        if let url = url, let fetchedImage = await viewModel.loadImage(from: url) {
                            image = fetchedImage
                        }
                    }
            }
        }
    }
}

//#Preview {
//    AsyncImageView()
//}
