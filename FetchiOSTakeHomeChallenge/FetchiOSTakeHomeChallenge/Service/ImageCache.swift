//
//  ImageCache.swift
//  FetchiOSTakeHomeChallenge
//
//  Created by Nick Dimitrakas on 1/28/25.
//

import UIKit

actor ImageCache {
    private var cache = NSCache<NSURL, UIImage>()
    
    func loadImage(from url: URL) async -> UIImage? {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                cache.setObject(image, forKey: url as NSURL)
                return image
            }
        } catch {
            print("Failed to load image: \(error.localizedDescription)")
        }
        return nil
    }
}
