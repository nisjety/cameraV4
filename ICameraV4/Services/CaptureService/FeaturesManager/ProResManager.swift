//
//  ProResManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

final class ProResManager {

    func enableProRes(for device: AVCaptureDevice) {
        guard isProResSupported(for: device) else {
            print("ProRes not supported on \(device.localizedName)")
            return
        }

        do {
            try device.lockForConfiguration()
            // Additional ProRes configuration
            print("ProRes enabled on \(device.localizedName)")
            device.unlockForConfiguration()
        } catch {
            print("Failed to enable ProRes on \(device.localizedName): \(error)")
        }
    }

    func isProResSupported(for device: AVCaptureDevice) -> Bool {
        return device.activeFormat.isVideoStabilizationModeSupported(.cinematic)
    }
}
