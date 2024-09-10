//
//  LogVideoManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

final class LogVideoManager {

    func enableLogVideoRecording(for device: AVCaptureDevice) {
        guard isLogVideoSupported(for: device) else {
            print("Log Video not supported on \(device.localizedName)")
            return
        }
        
        do {
            try device.lockForConfiguration()
            // Additional settings for Log video recording
            print("Log Video recording enabled on \(device.localizedName)")
            device.unlockForConfiguration()
        } catch {
            print("Failed to enable Log Video on \(device.localizedName): \(error)")
        }
    }
    
    func isLogVideoSupported(for device: AVCaptureDevice) -> Bool {
        // Check if the device supports Log video recording (example logic)
        return true // Replace with actual logic
    }
}
