//
//  ImageLoader.swift
//  FetchiOSTakeHomeChallenge
//
//  Created by Nick Dimitrakas on 1/28/25.
//

import UIKit

protocol ImageLoader {
    func loadImage(from url: URL) async -> UIImage?
}
