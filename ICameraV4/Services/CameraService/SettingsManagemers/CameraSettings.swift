//
//  CameraSettings.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 18/08/2024.
//

import Foundation

struct CameraSettings {
    var enableLivePhotos: Bool = false
    var aspectRatio: AspectRatio = .fourByThree
    var selectedFilter: CameraFilter = .none
    var photographicStyle: PhotographicStyle = .standard
    var macroMode: Bool = false
    var depthControl: Float = 0.5
    var lightingIntensity: Float = 1.0
    var enableHDRVideo: Bool = false
    var cinematicMode: Bool = false
    var slowMotion: SlowMotion = .fps120
    var timeLapse: TimeLapse = .standard
    var proRAW: Bool = false
    var proResVideo: Bool = false
    var burstMode: Bool = false
    var burstCount: Int = 10
    var resolution: Resolution = .hd1080
    var frameRate: FrameRate = .fps30
    var format: Format = .jpeg
    var hdrEnabled: Bool = false
    var nightModeEnabled: Bool = false
    var cinematicModeEnabled: Bool = false
    var macroModeEnabled: Bool = false
    var audioZoom: Bool = false
    var actionMode: Bool = false
    var grid: Bool = false
    var mirrorFrontCamera: Bool = false
    var smartHDR: Bool = false
    var lensCorrection: Bool = false
    var sceneDetection: Bool = false
    var prioritizeFasterShooting: Bool = false
    var recordStereoSound: Bool = false
    var macroControl: Bool = false
    var keepSettings: Bool = false
    var burstInterval: BurstInterval = .threeSeconds

    static var defaultSettings: CameraSettings {
        CameraSettings(
            enableLivePhotos: false,
            aspectRatio: .fourByThree,
            selectedFilter: .none,
            photographicStyle: .standard,
            macroMode: false,
            depthControl: 0.5,
            lightingIntensity: 1.0,
            enableHDRVideo: false,
            cinematicMode: false,
            slowMotion: .fps120,
            timeLapse: .standard,
            proRAW: false,
            proResVideo: false,
            burstMode: false,
            burstCount: 10,
            resolution: .hd1080,
            frameRate: .fps30,
            format: .jpeg,
            hdrEnabled: false,
            nightModeEnabled: false,
            cinematicModeEnabled: false,
            macroModeEnabled: false,
            audioZoom: false,
            actionMode: false,
            grid: false,
            mirrorFrontCamera: false,
            smartHDR: false,
            lensCorrection: false,
            sceneDetection: false,
            prioritizeFasterShooting: false,
            recordStereoSound: false,
            macroControl: false,
            keepSettings: false,
            burstInterval: .threeSeconds
        )
    }

    enum AspectRatio: String, CaseIterable, Identifiable {
        case oneByOne = "1:1"
        case fourByThree = "4:3"
        case sixteenByNine = "16:9"
        
        var id: String { self.rawValue }
    }

    enum CameraFilter: String, CaseIterable, Identifiable {
        case none = "None"
        case sepia = "Sepia"
        case mono = "Mono"
        case noir = "Noir"
        case dramatic = "Dramatic"
        case vivid = "Vivid"
        
        var id: String { self.rawValue }
    }

    enum PhotographicStyle: String, CaseIterable, Identifiable {
        case standard = "Standard"
        case richContrast = "Rich Contrast"
        case vibrant = "Vibrant"
        case warm = "Warm"
        case cool = "Cool"
        
        var id: String { self.rawValue }
    }

    enum Resolution: String, CaseIterable {
        case hd1080 = "1080p"
        case hd4K = "4K"
    }

    enum FrameRate: Int, CaseIterable {
        case fps24 = 24
        case fps30 = 30
        case fps60 = 60
    }

    enum SlowMotion: String, CaseIterable, Identifiable {
        case fps120 = "1080p at 120 fps"
        case fps240 = "1080p at 240 fps"

        var id: String { self.rawValue }
    }

    enum TimeLapse: String, CaseIterable, Identifiable {
        case standard = "Standard"
        case lowLight = "Low Light"
        case nightMode = "Night Mode"
        
        var id: String { self.rawValue }
    }

    enum BurstInterval: String, CaseIterable, Identifiable {
        case twoSeconds = "2 Seconds"
        case threeSeconds = "3 Seconds"
        case fiveSeconds = "5 Seconds"
        case sevenSeconds = "7 Seconds"
        case tenSeconds = "10 Seconds"
        
        var id: String { self.rawValue }
    }

    enum TimerMode: Double, CaseIterable, Identifiable {
        case off = 0.0
        case threeSeconds = 3.0
        case tenSeconds = 10.0
        
        var id: Double { self.rawValue }
    }

    enum Format: String, CaseIterable {
        case jpeg = "JPEG"
        case heif = "HEIF"
        case proRAW = "ProRAW"
        case h264 = "H.264"
        case hevc = "HEVC"
        case proRes = "ProRes"
    }
}
