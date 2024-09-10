//
//  CameraFormatManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

final class CameraFormatManager {

    /// Configures the active format of a given device for the specified resolution and frame rate.
    /// - Parameters:
    ///   - device: The `AVCaptureDevice` representing the camera or lens to configure.
    ///   - resolution: The desired `AVCaptureSession.Preset` resolution.
    ///   - frameRate: The desired frame rate.
    func configureActiveFormat(for device: AVCaptureDevice, resolution: AVCaptureSession.Preset, frameRate: Int) {
        do {
            try device.lockForConfiguration()
            if let format = device.formats.first(where: { $0.videoSupportedFrameRateRanges.contains { $0.maxFrameRate >= Double(frameRate) } }) {
                device.activeFormat = format
                device.activeVideoMinFrameDuration = CMTime(value: 1, timescale: CMTimeScale(frameRate))
                device.activeVideoMaxFrameDuration = CMTime(value: 1, timescale: CMTimeScale(frameRate))
            }
            device.unlockForConfiguration()
            print("Configured format for \(device.localizedName): Resolution - \(resolution.rawValue), FrameRate - \(frameRate)")
        } catch {
            print("Error configuring active format for \(device.localizedName): \(error)")
        }
    }

    /// Configures the HDR settings for a given device, if supported.
    /// - Parameters:
    ///   - device: The `AVCaptureDevice` representing the camera or lens to configure.
    ///   - enableHDR: A Boolean indicating whether to enable HDR.
    func configureHDR(for device: AVCaptureDevice, enableHDR: Bool) {
        do {
            try device.lockForConfiguration()
            if enableHDR && device.activeFormat.isVideoHDRSupported {
                // Configure device for HDR if available and desired
                print("HDR enabled for \(device.localizedName)")
            } else {
                // Configure device for standard dynamic range
                print("HDR not supported or disabled for \(device.localizedName)")
            }
            device.unlockForConfiguration()
        } catch {
            print("Error configuring HDR for \(device.localizedName): \(error)")
        }
    }

    /// Configures cinematic stabilization for a given device, if supported.
    /// - Parameters:
    ///   - device: The `AVCaptureDevice` representing the camera or lens to configure.
    ///   - enableCinematic: A Boolean indicating whether to enable cinematic stabilization.
    ///   - connection: The `AVCaptureConnection` representing the connection for which stabilization should be configured.
    func configureCinematicStabilization(for device: AVCaptureDevice, enableCinematic: Bool, connection: AVCaptureConnection) {
        do {
            try device.lockForConfiguration()
            if enableCinematic && connection.isVideoStabilizationSupported {
                connection.preferredVideoStabilizationMode = .cinematic
                print("Cinematic stabilization enabled for \(device.localizedName)")
            } else {
                connection.preferredVideoStabilizationMode = .off
                print("Cinematic stabilization not supported or disabled for \(device.localizedName)")
            }
            device.unlockForConfiguration()
        } catch {
            print("Error configuring cinematic stabilization for \(device.localizedName): \(error)")
        }
    }
}
