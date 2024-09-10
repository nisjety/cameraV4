//
//  CoreSettingsController.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 03/09/2024.
//

import Foundation
import AVFoundation
import Combine

/// A controller that manages the core settings of the camera.
final class CoreSettingsController: ObservableObject {

    // MARK: - Published Properties
    @Published var flashMode: AVCaptureDevice.FlashMode = .auto
    @Published var livePhotosMode: Bool = false
    @Published var exposureValue: Double = 0.0
    @Published var timer: CameraSettings.TimerMode = .off
    @Published var selectedFilter: CameraSettings.CameraFilter = .none
    @Published var photographicStyle: CameraSettings.PhotographicStyle = .standard
    @Published var macroMode: Bool = false
    @Published var portraitLightingEffect: String = "Natural Light"
    @Published var depthControl: Double = 0.0
    @Published var lightingIntensity: Double = 0.0
    @Published var videoResolution: CameraSettings.Resolution = .hd1080
    @Published var frameRate: CameraSettings.FrameRate = .fps30
    @Published var hdrVideo: Bool = false
    @Published var cinematicMode: Bool = false
    @Published var slowMotion: CameraSettings.SlowMotion = .fps120
    @Published var timeLapse: CameraSettings.TimeLapse = .standard
    @Published var audioZoom: Bool = false
    @Published var actionMode: Bool = false
    @Published var appleProRAW: Bool = false
    @Published var proResVideo: Bool = false
    @Published var format: CameraSettings.Format = .heif
    @Published var grid: Bool = false
    @Published var mirrorFrontCamera: Bool = false
    @Published var smartHDR: Bool = false
    @Published var lensCorrection: Bool = false
    @Published var sceneDetection: Bool = false
    @Published var prioritizeFasterShooting: Bool = false
    @Published var recordStereoSound: Bool = false
    @Published var macroControl: Bool = false
    @Published var keepSettings: Bool = false
    @Published var burstInterval: CameraSettings.BurstInterval = .threeSeconds
    @Published var burstCount: Int = 10

    private let userDefaultsKey = "CoreCameraSettings"

    // MARK: - Initialization
    init() {
        loadSettings()
    }

    // MARK: - Methods

    /// Apply current settings to the given AVCaptureDevice
    func applySettings(to device: AVCaptureDevice) {
        do {
            try device.lockForConfiguration()

            // Apply flash mode
            if device.isFlashAvailable {
                AVCapturePhotoSettings.flashMode = flashMode
            }

            // Apply night mode
            device.automaticallyEnablesLowLightBoostWhenAvailable = hdrVideo

            // Apply aspect ratio and HDR
            if device.isVideoHDRSupported {
                device.isVideoHDREnabled = hdrVideo
            }

            // Apply other configurations
            device.whiteBalanceMode = .continuousAutoWhiteBalance
            // Add other settings as required
            device.unlockForConfiguration()
        } catch {
            print("Failed to apply settings: \(error.localizedDescription)")
        }
    }

    /// Save current settings to UserDefaults
    func saveSettings() {
        let settings = CameraSettings(
            enableLivePhotos: livePhotosMode,
            exposureValue: exposureValue,
            timer: timer,
            selectedFilter: selectedFilter,
            photographicStyle: photographicStyle,
            macroMode: macroMode,
            portraitLightingEffect: portraitLightingEffect,
            depthControl: Float(depthControl),
            lightingIntensity: Float(lightingIntensity),
            enableHDRVideo: hdrVideo,
            cinematicMode: cinematicMode,
            slowMotion: slowMotion,
            timeLapse: timeLapse,
            audioZoom: audioZoom,
            actionMode: actionMode,
            proRAW: appleProRAW,
            proResVideo: proResVideo,
            format: format,
            grid: grid,
            mirrorFrontCamera: mirrorFrontCamera,
            smartHDR: smartHDR,
            lensCorrection: lensCorrection,
            sceneDetection: sceneDetection,
            prioritizeFasterShooting: prioritizeFasterShooting,
            recordStereoSound: recordStereoSound,
            macroControl: macroControl,
            keepSettings: keepSettings,
            burstInterval: burstInterval,
            burstCount: burstCount,
            resolution: videoResolution,
            frameRate: frameRate
        )
        do {
            let data = try JSONEncoder().encode(settings)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Failed to save settings: \(error.localizedDescription)")
        }
    }

    /// Load settings from UserDefaults or use default settings
    private func loadSettings() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            do {
                let savedSettings = try JSONDecoder().decode(CameraSettings.self, from: data)
                applySavedSettings(savedSettings)
            } catch {
                print("Failed to load saved settings: \(error.localizedDescription)")
                loadDefaultSettings()
            }
        } else {
            loadDefaultSettings()
        }
    }

    /// Apply saved settings
    private func applySavedSettings(_ settings: CameraSettings) {
        livePhotosMode = settings.enableLivePhotos
        exposureValue = settings.exposureValue
        timer = settings.timer
        selectedFilter = settings.selectedFilter
        photographicStyle = settings.photographicStyle
        macroMode = settings.macroMode
        portraitLightingEffect = settings.portraitLightingEffect
        depthControl = Double(settings.depthControl)
        lightingIntensity = Double(settings.lightingIntensity)
        hdrVideo = settings.enableHDRVideo
        cinematicMode = settings.cinematicMode
        slowMotion = settings.slowMotion
        timeLapse = settings.timeLapse
        audioZoom = settings.audioZoom
        actionMode = settings.actionMode
        appleProRAW = settings.proRAW
        proResVideo = settings.proResVideo
        format = settings.format
        grid = settings.grid
        mirrorFrontCamera = settings.mirrorFrontCamera
        smartHDR = settings.smartHDR
        lensCorrection = settings.lensCorrection
        sceneDetection = settings.sceneDetection
        prioritizeFasterShooting = settings.prioritizeFasterShooting
        recordStereoSound = settings.recordStereoSound
        macroControl = settings.macroControl
        keepSettings = settings.keepSettings
        burstInterval = settings.burstInterval
        burstCount = settings.burstCount
        videoResolution = settings.resolution
        frameRate = settings.frameRate
    }

    /// Load default settings
    private func loadDefaultSettings() {
        let defaultSettings = CameraSettings.defaultSettings
        applySavedSettings(defaultSettings)
    }
}
