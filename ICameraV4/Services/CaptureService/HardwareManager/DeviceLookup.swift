//
//  DeviceLookup.swift
//  iCameraV3
//
//  Created by Ima Da Costa on 03/08/2024.
//

import Foundation
import AVFoundation

final class DeviceLookup {

    private let frontCameraDiscoverySession: AVCaptureDevice.DiscoverySession
    private let backCameraDiscoverySession: AVCaptureDevice.DiscoverySession
    private let externalCameraDiscoverySession: AVCaptureDevice.DiscoverySession
    private let lidarDiscoverySession: AVCaptureDevice.DiscoverySession  // LiDAR-specific discovery session

    init() {
        backCameraDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInDualCamera, .builtInWideAngleCamera, .builtInTelephotoCamera, .builtInLiDARDepthCamera],
            mediaType: .video,
            position: .back
        )
        frontCameraDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInTrueDepthCamera, .builtInWideAngleCamera],
            mediaType: .video,
            position: .front
        )
        externalCameraDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.external],
            mediaType: .video,
            position: .unspecified
        )
        lidarDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInLiDARDepthCamera],
            mediaType: .video,
            position: .back
        )

        if AVCaptureDevice.systemPreferredCamera == nil {
            AVCaptureDevice.userPreferredCamera = backCameraDiscoverySession.devices.first ?? frontCameraDiscoverySession.devices.first
        }
    }
    
    // MARK: - Default Devices
    
    var defaultCamera: AVCaptureDevice {
        get throws {
            guard let videoDevice = AVCaptureDevice.systemPreferredCamera ?? frontCameraDiscoverySession.devices.first ?? backCameraDiscoverySession.devices.first else {
                throw CameraError.videoDeviceUnavailable
            }
            return videoDevice
        }
    }
    
    var defaultMic: AVCaptureDevice {
        get throws {
            guard let audioDevice = AVCaptureDevice.default(for: .audio) else {
                throw CameraError.audioDeviceUnavailable
            }
            return audioDevice
        }
    }
    
    // MARK: - Device Lists
    
    var cameras: [AVCaptureDevice] {
        var cameras: [AVCaptureDevice] = []
        cameras.append(contentsOf: backCameraDiscoverySession.devices)
        cameras.append(contentsOf: frontCameraDiscoverySession.devices)
        cameras.append(contentsOf: externalCameraDiscoverySession.devices)
        
#if !targetEnvironment(simulator)
        if cameras.isEmpty {
            fatalError("No camera devices are found on this system.")
        }
#endif
        return cameras
    }
    
    var lidarDevices: [AVCaptureDevice] {
        return lidarDiscoverySession.devices
    }

    // MARK: - Device by Position
    
    func camera(at position: AVCaptureDevice.Position) throws -> AVCaptureDevice {
        let discoverySession: AVCaptureDevice.DiscoverySession
        switch position {
        case .front:
            discoverySession = frontCameraDiscoverySession
        case .back:
            discoverySession = backCameraDiscoverySession
        default:
            throw CameraError.videoDeviceUnavailable
        }
        guard let camera = discoverySession.devices.first else {
            throw CameraError.videoDeviceUnavailable
        }
        return camera
    }

    // MARK: - LiDAR Availability
    
    func isLiDARAvailable(for device: AVCaptureDevice) -> Bool {
        return lidarDiscoverySession.devices.contains(device)
    }
}
