//
//  HighResolutionPhotoManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 15/08/2024.
//

import AVFoundation

final class HighResolutionPhotoManager {

    // Configures the session for high-quality photo capture.
    func configureHighResolutionPhotoOutput(_ photoOutput: AVCapturePhotoOutput) {
        // Set the maximum photo dimensions to utilize the highest quality available
        if #available(iOS 16.0, *) {
            photoOutput.maxPhotoDimensions = CMVideoDimensions(width: 8064, height: 6048) // 48MP
        } else {
            photoOutput.isHighResolutionCaptureEnabled = true // Deprecated in iOS 16, but used as fallback
        }

        photoOutput.isDepthDataDeliveryEnabled = photoOutput.isDepthDataDeliverySupported
        photoOutput.isPortraitEffectsMatteDeliveryEnabled = photoOutput.isPortraitEffectsMatteDeliverySupported
        
        print("High-resolution photo capture configured with max dimensions \(photoOutput.maxPhotoDimensions.width)x\(photoOutput.maxPhotoDimensions.height)")
    }
}

