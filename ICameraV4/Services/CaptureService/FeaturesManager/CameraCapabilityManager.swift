//
//  CameraCapabilityManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import AVFoundation

final class CameraCapabilityManager {

    func capabilities(for device: AVCaptureDevice) -> [String: Any] {
        var capabilities: [String: Any] = [:]
        capabilities["Max Zoom Factor"] = device.activeFormat.videoMaxZoomFactor
        capabilities["Low Light Boost Supported"] = device.isLowLightBoostSupported
        capabilities["Video Stabilization Modes"] = device.activeFormat.videoSupportedFrameRateRanges.map { $0.minFrameRate }
        capabilities["HDR Supported"] = device.activeFormat.isVideoHDRSupported
        capabilities["Depth Data Capture Supported"] = !device.activeFormat.supportedDepthDataFormats.isEmpty
        capabilities["ProRAW Supported"] = isProRAWSupported(for: device)
        capabilities["ProRes Supported"] = isProResSupported(for: device)
        capabilities["Cinematic Mode Supported"] = isCinematicModeSupported(for: device)
        capabilities["Macro Mode Supported"] = isMacroModeSupported(for: device)
        capabilities["LiDAR Supported"] = isLiDARAvailable(for: device)
        capabilities["Portrait Mode Supported"] = isPortraitModeSupported(for: device)
        capabilities["Log Video Supported"] = isLogVideoSupported(for: device)
        return capabilities
    }

    func isProRAWSupported(for device: AVCaptureDevice) -> Bool {
        return device.isProRAWSupported
    }

    func isProResSupported(for device: AVCaptureDevice) -> Bool {
        return device.activeFormat.isVideoStabilizationModeSupported(.cinematic)
    }

    func isCinematicModeSupported(for device: AVCaptureDevice) -> Bool {
        return device.activeFormat.isVideoStabilizationModeSupported(.cinematic)
    }

    func isMacroModeSupported(for device: AVCaptureDevice) -> Bool {
        // Replace the use of minFocusDistance with logic based on the device capabilities
        return device.isFocusPointOfInterestSupported && device.supportsSessionPreset(.photo)
    }

    func isLiDARAvailable(for device: AVCaptureDevice) -> Bool {
        return !device.activeFormat.supportedDepthDataFormats.isEmpty
    }

    func isPortraitModeSupported(for device: AVCaptureDevice) -> Bool {
        // Add the actual logic to check if the device supports Portrait Mode
        return true // Example logic, replace with actual implementation
    }

    func isLowLightBoostSupported(for device: AVCaptureDevice) -> Bool {
        return device.isLowLightBoostSupported
    }

    func isLogVideoSupported(for device: AVCaptureDevice) -> Bool {
        // Implement actual check for Log Video support
        return true // Placeholder logic
    }

    func isHDRSupported(for device: AVCaptureDevice) -> Bool {
        // Implement actual check for HDR support
        return device.activeFormat.isVideoHDRSupported
    }
}
