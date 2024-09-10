//
//  HDRConfigurationManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 15/08/2024.
//

import AVFoundation

final class HDRConfigurationManager {

    // Configures the session for HDR video, if supported by the device.
    func configureHDRVideo(_ isEnabled: Bool, for device: AVCaptureDevice) {
        guard isEnabled else { return }

        for format in device.formats {
            if format.isVideoHDRSupported {
                do {
                    try device.lockForConfiguration()
                    device.activeFormat = format
                    device.unlockForConfiguration()
                    print("HDR Video configured for \(device.localizedName)")
                    return
                } catch {
                    print("Failed to configure HDR: \(error.localizedDescription)")
                }
            }
        }
    }
}
