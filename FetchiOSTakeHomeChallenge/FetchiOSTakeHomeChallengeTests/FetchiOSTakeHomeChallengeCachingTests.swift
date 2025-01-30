//
//  FetchiOSTakeHomeChallengeCachingTests.swift
//  FetchiOSTakeHomeChallenge
//
//  Created by Nick Dimitrakas on 1/29/25.
//

import Testing
@testable import FetchiOSTakeHomeChallenge
import Foundation
import UIKit

struct FetchiOSTakeHomeChallengeCachingTests {
    
    let imageCache = ImageCache()
    let testURL = URL(string: "https://some.url/image.jpg")!

    @Test func testSaveAndLoadImage() async {
        let image = UIImage(systemName: "star")!

        imageCache.saveImage(image, for: testURL)
        let cachedImage = imageCache.loadImage(from: testURL)

        #expect(cachedImage != nil)
    }
}
