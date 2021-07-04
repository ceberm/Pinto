//
//  Utilities.swift
//  TopinApp
//
//  Created by Cesar on 3/7/21.
//

import Foundation
import SwiftUI

func downsample(imageAt imageName: String,
                to pointSize: CGSize,
                scale: CGFloat = UIScreen.main.scale) -> UIImage? {
    
    let imageURL = URL.fromLocalImage(named: imageName)

    // Create an CGImageSource that represent an image
    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
    let imageSource = CGImageSourceCreateWithURL(imageURL! as CFURL, imageSourceOptions)
    
    // Calculate the desired dimension
    let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
    
    // Perform downsampling
    let downsampleOptions = [
        kCGImageSourceCreateThumbnailFromImageAlways: true,
        kCGImageSourceShouldCacheImmediately: true,
        kCGImageSourceCreateThumbnailWithTransform: true,
        kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
    ] as CFDictionary
    
    let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource!, 0, downsampleOptions)
    
    // Return the downsampled image as UIImage
    return UIImage(cgImage: downsampledImage!)
}


extension URL {
    /// Get the URL in the local image (asset)
    static func fromLocalImage(named name: String) -> URL? {
        
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path
        
        guard fileManager.fileExists(atPath: path) else {
            guard
                let image = UIImage(named: name),
                let data = image.pngData()
                else { return nil }
            /// Realize the path url by writing image data
            fileManager.createFile(atPath: path, contents: data, attributes: nil)
            return url
        }
        return url
    }
}
