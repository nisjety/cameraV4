//
//  CaptureFocusAndExposureManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 15/08/2024.
//

import AVFoundation

final class CaptureFocusAndExposureManager {

    private let focusManager = CaptureFocusManager()
    private let exposureManager = CaptureExposureManager()
    private let zoomManager = CaptureZoomManager()

    func performFocusAndExposure(at devicePoint: CGPoint, on device: AVCaptureDevice, isUserInitiated: Bool) {
        do {
            try focusManager.performFocus(at: devicePoint, on: device, isUserInitiated: isUserInitiated)
            try exposureManager.performExposure(at: devicePoint, on: device, isUserInitiated: isUserInitiated)
        } catch {
            print("Unable to perform focus and exposure operation: \(error.localizedDescription)")
        }
    }

    func applyZoom(to device: AVCaptureDevice, withFactor zoomFactor: CGFloat) {
        do {
            try zoomManager.applyZoom(to: device, withFactor: zoomFactor)
        } catch {
            print("Unable to apply zoom: \(error.localizedDescription)")
        }
    }

    func smoothZoom(from startZoomFactor: CGFloat, to endZoomFactor: CGFloat, duration: TimeInterval, on device: AVCaptureDevice) {
        do {
            try zoomManager.smoothZoom(from: startZoomFactor, to: endZoomFactor, duration: duration, on: device)
        } catch {
            print("Unable to perform smooth zoom: \(error.localizedDescription)")
        }
    }
}
