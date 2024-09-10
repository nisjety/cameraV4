//
//  CaptureFeaturesManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import AVFoundation

final class CaptureFeaturesManager {

    private let cameraConfigurationManager: CameraConfigurationManager
    private let cameraCapabilityManager: CameraCapabilityManager
    private let lidarManager: LidarManager
    private let macroModeManager: MacroModeManager
    private let cinematicModeManager: CinematicModeManager
    private let logVideoManager: LogVideoManager
    private let hdrManager: HDRManager
    private let nightModeManager: NightModeManager
    private let proRAWManager: ProRAWManager
    private let proResManager: ProResManager
    private let actionButtonManager: ActionButtonManager

    init(cameraConfigurationManager: CameraConfigurationManager = CameraConfigurationManager(),
         cameraCapabilityManager: CameraCapabilityManager = CameraCapabilityManager(),
         lidarManager: LidarManager = LidarManager(),
         macroModeManager: MacroModeManager = MacroModeManager(),
         cinematicModeManager: CinematicModeManager = CinematicModeManager(),
         logVideoManager: LogVideoManager = LogVideoManager(),
         hdrManager: HDRManager = HDRManager(),
         nightModeManager: NightModeManager = NightModeManager(),
         proRAWManager: ProRAWManager = ProRAWManager(),
         proResManager: ProResManager = ProResManager(),
         actionButtonManager: ActionButtonManager = ActionButtonManager()) {
        self.cameraConfigurationManager = cameraConfigurationManager
        self.cameraCapabilityManager = cameraCapabilityManager
        self.lidarManager = lidarManager
        self.macroModeManager = macroModeManager
        self.cinematicModeManager = cinematicModeManager
        self.logVideoManager = logVideoManager
        self.hdrManager = hdrManager
        self.nightModeManager = nightModeManager
        self.proRAWManager = proRAWManager
        self.proResManager = proResManager
        self.actionButtonManager = actionButtonManager
    }

    // MARK: - Feature Management

    func enableFeatureIfSupported(for device: AVCaptureDevice, in session: AVCaptureSession) {
        if cameraCapabilityManager.isMacroModeSupported(for: device) {
            macroModeManager.enableMacroMode(for: device)
            print("Macro Mode enabled for \(device.localizedName)")
        }
        
        if cameraCapabilityManager.isLiDARAvailable(for: device) {
            lidarManager.configureForDepthSensing(on: device)
            print("LiDAR enabled for \(device.localizedName)")
        }

        if cameraCapabilityManager.isLowLightBoostSupported(for: device) {
            nightModeManager.enableNightMode(for: device)
            print("Night Mode configured for \(device.localizedName)")
        }

        if cameraCapabilityManager.isPortraitModeSupported(for: device) {
            cameraConfigurationManager.configureForPortraitMode(device: device)
            print("Portrait Mode configured for \(device.localizedName)")
        }

        if cameraCapabilityManager.isCinematicModeSupported(for: device) {
            cinematicModeManager.enableCinematicMode(for: device, in: session)
            print("Cinematic Mode enabled for \(device.localizedName)")
        }

        if cameraCapabilityManager.isLogVideoSupported(for: device) {
            logVideoManager.enableLogVideoRecording(for: device)
            print("Log Video enabled for \(device.localizedName)")
        }

        if cameraCapabilityManager.isHDRSupported(for: device) {
            hdrManager.enableHDR(for: device)
            print("HDR enabled for \(device.localizedName)")
        }

        if cameraCapabilityManager.isProRAWSupported(for: device) {
            proRAWManager.enableProRAW(for: device)
            print("ProRAW enabled for \(device.localizedName)")
        }

        if cameraCapabilityManager.isProResSupported(for: device) {
            proResManager.enableProRes(for: device)
            print("ProRes enabled for \(device.localizedName)")
        }

        actionButtonManager.configureActionButton(for: .openCamera) // Example; update to your desired function
    }

    // MARK: - Adjust Configuration

    func adjustConfiguration(for device: AVCaptureDevice) {
        cameraConfigurationManager.adjustConfiguration(for: device)
        print("Adjusted configuration for \(device.localizedName)")
    }
}
