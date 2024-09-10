//
//  CaptureZoomManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

final class CaptureZoomManager {

    func applyZoom(to device: AVCaptureDevice, withFactor zoomFactor: CGFloat) throws {
        try device.lockForConfiguration()

        let clampedZoomFactor = min(max(zoomFactor, device.minAvailableVideoZoomFactor), device.maxAvailableVideoZoomFactor)
        device.videoZoomFactor = clampedZoomFactor

        device.unlockForConfiguration()
    }

    func smoothZoom(from startZoomFactor: CGFloat, to endZoomFactor: CGFloat, duration: TimeInterval, on device: AVCaptureDevice) throws {
        try device.lockForConfiguration()

        let clampedEndZoomFactor = min(max(endZoomFactor, device.minAvailableVideoZoomFactor), device.maxAvailableVideoZoomFactor)
        device.ramp(toVideoZoomFactor: clampedEndZoomFactor, withRate: Float(clampedEndZoomFactor - startZoomFactor) / Float(duration))

        device.unlockForConfiguration()
    }
}
