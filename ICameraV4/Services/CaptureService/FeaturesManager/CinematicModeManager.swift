//
//  CinematicModeManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import AVFoundation

final class CinematicModeManager {

    func enableCinematicMode(for device: AVCaptureDevice, in session: AVCaptureSession) {
        guard isCinematicModeSupported(for: device) else {
            print("Cinematic Mode not supported on \(device.localizedName)")
            return
        }
        
        do {
            try device.lockForConfiguration()
            configureCinematicStabilization(for: device, in: session)
            print("Cinematic Mode enabled on \(device.localizedName)")
            device.unlockForConfiguration()
        } catch {
            print("Failed to enable Cinematic Mode on \(device.localizedName): \(error)")
        }
    }
    
    func isCinematicModeSupported(for device: AVCaptureDevice) -> Bool {
        return device.activeFormat.isVideoStabilizationModeSupported(.cinematic)
    }

    private func configureCinematicStabilization(for device: AVCaptureDevice, in session: AVCaptureSession) {
        for connection in session.connections {
            if connection.isVideoStabilizationSupported {
                connection.preferredVideoStabilizationMode = .cinematic
            }
        }
    }
}
