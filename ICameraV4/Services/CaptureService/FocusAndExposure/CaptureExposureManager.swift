//
//  CaptureExposureManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

final class CaptureExposureManager {

    func performExposure(at devicePoint: CGPoint, on device: AVCaptureDevice, isUserInitiated: Bool) throws {
        try device.lockForConfiguration()

        let exposureMode: AVCaptureDevice.ExposureMode = isUserInitiated ? .autoExpose : .continuousAutoExposure
        if device.isExposurePointOfInterestSupported && device.isExposureModeSupported(exposureMode) {
            device.exposurePointOfInterest = devicePoint
            device.exposureMode = exposureMode
        }

        device.unlockForConfiguration()
    }
}
