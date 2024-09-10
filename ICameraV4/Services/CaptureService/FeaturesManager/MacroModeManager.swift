//
//  MacroModeManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import AVFoundation

final class MacroModeManager {

    func enableMacroMode(for device: AVCaptureDevice) {
        guard isMacroModeSupported(for: device) else {
            print("Macro Mode not supported on \(device.localizedName)")
            return
        }
        
        do {
            try device.lockForConfiguration()
            // Configure the device for macro mode
            device.focusMode = .autoFocus
            device.isSubjectAreaChangeMonitoringEnabled = true
            print("Macro Mode enabled on \(device.localizedName)")
            device.unlockForConfiguration()
        } catch {
            print("Failed to enable Macro Mode on \(device.localizedName): \(error)")
        }
    }
    
    func isMacroModeSupported(for device: AVCaptureDevice) -> Bool {
        // Check if the device supports macro mode based on its capabilities
        return device.deviceType == .builtInUltraWideCamera && device.position == .back
    }
}
