//
//  CameraConfigurationManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

final class CameraConfigurationManager {

    func configureForPortraitMode(device: AVCaptureDevice) {
        do {
            try device.lockForConfiguration()
            device.exposureMode = .continuousAutoExposure
            device.focusMode = .continuousAutoFocus
            device.whiteBalanceMode = .continuousAutoWhiteBalance
            if device.isSmoothAutoFocusSupported {
                device.isSmoothAutoFocusEnabled = true
            }
            device.unlockForConfiguration()
            print("Configured \(device.localizedName) for Portrait Mode")
        } catch {
            print("Failed to configure \(device.localizedName) for portrait mode: \(error)")
        }
    }

    func configureForNightMode(device: AVCaptureDevice) {
        do {
            try device.lockForConfiguration()
            device.exposureMode = .continuousAutoExposure
            // The device will automatically enable low-light boost if needed.
            if device.isLowLightBoostSupported {
                print("\(device.localizedName) supports low light boost and it will be enabled automatically when needed.")
            } else {
                print("\(device.localizedName) does not support low light boost.")
            }
            device.unlockForConfiguration()
            print("Configured \(device.localizedName) for Night Mode")
        } catch {
            print("Failed to configure \(device.localizedName) for night mode: \(error)")
        }
    }

    func configureForMacroMode(device: AVCaptureDevice) {
        do {
            try device.lockForConfiguration()
            device.focusMode = .autoFocus
            device.isSubjectAreaChangeMonitoringEnabled = true
            device.unlockForConfiguration()
            print("Configured \(device.localizedName) for Macro Mode")
        } catch {
            print("Failed to configure \(device.localizedName) for macro mode: \(error)")
        }
    }

    func adjustConfiguration(for device: AVCaptureDevice) {
        // Implement logic to adjust the camera configuration dynamically based on the environment or user settings
        print("Adjusting configuration for \(device.localizedName)")
        // Example: Adjust frame rate, resolution, or apply filters based on the current conditions
    }
}
