//
//  CaptureFocusManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

final class CaptureFocusManager {

    func performFocus(at devicePoint: CGPoint, on device: AVCaptureDevice, isUserInitiated: Bool) throws {
        try device.lockForConfiguration()

        let focusMode: AVCaptureDevice.FocusMode = isUserInitiated ? .autoFocus : .continuousAutoFocus
        if device.isFocusPointOfInterestSupported && device.isFocusModeSupported(focusMode) {
            device.focusPointOfInterest = devicePoint
            device.focusMode = focusMode
        }
        
        device.isSubjectAreaChangeMonitoringEnabled = isUserInitiated
        device.unlockForConfiguration()
    }
}
