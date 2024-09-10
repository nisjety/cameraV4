//
//  NightModeManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import AVFoundation

final class NightModeManager {

    func enableNightMode(for device: AVCaptureDevice) {
        guard isNightModeSupported(for: device) else {
            print("Night Mode not supported on \(device.localizedName)")
            return
        }

        do {
            try device.lockForConfiguration()
            device.exposureMode = .continuousAutoExposure

            if device.isLowLightBoostSupported {
                // No need to manually enable low light boost; just let the system manage it.
                print("Low Light Boost is supported and will be used if necessary on \(device.localizedName)")
            }

            device.unlockForConfiguration()
        } catch {
            print("Failed to configure Night Mode on \(device.localizedName): \(error)")
        }
    }

    func isNightModeSupported(for device: AVCaptureDevice) -> Bool {
        return device.isLowLightBoostSupported
    }
}
