//
//  AdvancedSettings.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 04/09/2024.
//

import Foundation

struct AdvancedSettings {
    var iso: Float = 100.0
    var shutterSpeed: Double = 1/60
    var whiteBalance: WhiteBalanceMode = .auto
    var exposureCompensation: Float = 0.0
    var focusMode: FocusMode = .auto
    var manualFocusDistance: Float = 0.0
    var stabilizationMode: StabilizationMode = .auto

    static var defaultSettings: AdvancedSettings {
        AdvancedSettings(
            iso: 100.0,
            shutterSpeed: 1/60,
            whiteBalance: .auto,
            exposureCompensation: 0.0,
            focusMode: .auto,
            manualFocusDistance: 0.0,
            stabilizationMode: .auto
        )
    }

    enum WhiteBalanceMode: String, CaseIterable, Identifiable {
        case auto = "Auto"
        case daylight = "Daylight"
        case cloudy = "Cloudy"
        case tungsten = "Tungsten"
        case fluorescent = "Fluorescent"
        case custom = "Custom"
        
        var id: String { self.rawValue }
    }
    
    enum FocusMode: String, CaseIterable, Identifiable {
        case auto = "Auto"
        case manual = "Manual"
        case continuous = "Continuous"
        
        var id: String { self.rawValue }
    }
    
    enum StabilizationMode: String, CaseIterable, Identifiable {
        case off = "Off"
        case auto = "Auto"
        case standard = "Standard"
        case cinematic = "Cinematic"
        
        var id: String { self.rawValue }
    }
}
