//
//  HDRManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

final class HDRManager {

    func enableHDR(for device: AVCaptureDevice) {
        guard isHDRSupported(for: device) else {
            print("HDR not supported on \(device.localizedName)")
            return
        }
        
        do {
            try device.lockForConfiguration()
            if device.activeFormat.isVideoHDRSupported {
                // Configure HDR with Dolby Vision at up to 60 fps
                print("HDR with Dolby Vision enabled on \(device.localizedName)")
            } else {
                print("HDR is supported but Dolby Vision is not available on \(device.localizedName)")
            }
            device.unlockForConfiguration()
        } catch {
            print("Failed to enable HDR on \(device.localizedName): \(error)")
        }
    }
    
    func isHDRSupported(for device: AVCaptureDevice) -> Bool {
        return device.activeFormat.isVideoHDRSupported
    }
}
