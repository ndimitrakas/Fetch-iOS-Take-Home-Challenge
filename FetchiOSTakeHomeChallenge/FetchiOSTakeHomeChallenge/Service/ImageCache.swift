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
    
    private func encodeFileName(for url: URL) -> String {
        let encodedString = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
        return encodedString + ".png"
    }
    
    private func cacheFilePath(for url: URL) -> URL {
        cacheDirectory.appendingPathComponent(encodeFileName(for: url))
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

