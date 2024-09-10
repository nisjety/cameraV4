//
//  ManualControlsManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 03/09/2024.
//

import Foundation
import AVFoundation

final class ManualControlsManager {

    // Updates manual controls like ISO, shutter speed, and white balance on the AVCaptureDevice
    func updateControls(_ controls: ManualControls, for device: AVCaptureDevice) {
        do {
            try device.lockForConfiguration()
            
            // Adjust ISO
            if device.isExposureModeSupported(.custom) {
                let minISO = device.activeFormat.minISO
                let maxISO = device.activeFormat.maxISO
                device.setExposureModeCustom(duration: AVCaptureDevice.currentExposureDuration, iso: controls.iso.clamped(to: minISO...maxISO), completionHandler: nil)
            }
            
            // Adjust Shutter Speed
            if device.isExposureModeSupported(.custom) {
                let minDuration = device.activeFormat.minExposureDuration
                let maxDuration = device.activeFormat.maxExposureDuration
                let duration = CMTime(seconds: Double(controls.shutterSpeed), preferredTimescale: CMTimeScale(NSEC_PER_SEC))
                device.setExposureModeCustom(duration: duration.clamped(to: minDuration...maxDuration), iso: device.iso, completionHandler: nil)
            }
            
            // Adjust White Balance
            if device.isWhiteBalanceModeSupported(.locked) {
                let temperatureAndTint = AVCaptureDevice.WhiteBalanceTemperatureAndTintValues(temperature: controls.whiteBalance, tint: 0)
                let whiteBalanceGains = device.deviceWhiteBalanceGains(for: temperatureAndTint)
                device.setWhiteBalanceModeLocked(with: whiteBalanceGains, completionHandler: nil)
            }
            
            device.unlockForConfiguration()
        } catch {
            print("Failed to apply manual controls: \(error.localizedDescription)")
        }
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
