//
//  ImageCache.swift
//  FetchiOSTakeHomeChallenge
//
//  Created by Nick Dimitrakas on 1/28/25.
//

import Foundation
import UIKit
import CryptoKit

final class ImageCache {
    static let shared = ImageCache()
    
    private let fileManager = FileManager.default
    private lazy var cacheDirectory: URL = {
        let directory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
            .appendingPathComponent("ImageCache")
        if !fileManager.fileExists(atPath: directory.path) {
            try? fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
        }
        return directory
    }()
    
    // Fix this to not hash, just the url
    private func hashedFileName(for url: URL) -> String {
        let data = Data(url.absoluteString.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined() + ".png"
    }
    
    private func cacheFilePath(for url: URL) -> URL {
        cacheDirectory.appendingPathComponent(url.lastPathComponent)
    }
    
    func loadImage(from url: URL) -> UIImage? {
        let filePath = cacheFilePath(for: url)
        if let data = try? Data(contentsOf: filePath) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func saveImage(_ image: UIImage, for url: URL) {
        let filePath = cacheFilePath(for: url)
        if let data = image.pngData() {
            try? data.write(to: filePath)
        }
    }
}

