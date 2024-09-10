//
//  ProRAWManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

final class ProRAWManager {

    func enableProRAW(for device: AVCaptureDevice) {
        guard isProRAWSupported(for: device) else {
            print("ProRAW not supported on \(device.localizedName)")
            return
        }

        do {
            try device.lockForConfiguration()
            // Additional ProRAW configuration
            print("ProRAW enabled on \(device.localizedName)")
            device.unlockForConfiguration()
        } catch {
            print("Failed to enable ProRAW on \(device.localizedName): \(error)")
        }
    }

    func isProRAWSupported(for device: AVCaptureDevice) -> Bool {
        return device.isProRAWSupported
    }
}
