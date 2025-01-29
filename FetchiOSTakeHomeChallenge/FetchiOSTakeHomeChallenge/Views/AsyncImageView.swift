//
//  AsyncImageView.swift
//  FetchiOSTakeHomeChallenge
//
//  Created by Nick Dimitrakas on 1/28/25.
//

import SwiftUI

struct AsyncImageView: View {
    @State private var image: UIImage?
    @State private var isLoading = false
    let url: URL?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if isLoading {
                ProgressView()
            } else {
                Color.gray.opacity(0.3)
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let url = url, !isLoading else { return }
        isLoading = true
        
        if let cachedImage = ImageCache.shared.loadImage(from: url) {
            image = cachedImage
            isLoading = false
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let fetchedImage = UIImage(data: data) {
                    image = fetchedImage
                    ImageCache.shared.saveImage(fetchedImage, for: url)
                }
            } catch {
                print("Failed to load image from URL: \(error)")
            }
            isLoading = false
        }
    }
}

