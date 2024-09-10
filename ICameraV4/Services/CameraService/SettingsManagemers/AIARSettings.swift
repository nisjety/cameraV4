//
//  AIARSettings.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 03/09/2024.
//

import Foundation

struct AIARSettings {
    var isFaceDetectionEnabled: Bool = true
    var isAISceneRecognitionEnabled: Bool = false
    var isAutoFocusOnFacesEnabled: Bool = true
    var isYOLODetectionEnabled: Bool = false
    var isVisionProcessingEnabled: Bool = false
    var isDeeplabEnabled: Bool = false
    var isFastViTEnabled: Bool = false
    var isDepthEstimationEnabled: Bool = false
    var enableARKitFeatures: Bool = false
    var enablePlaneDetection: Bool = false
    var enablePersonSegmentation: Bool = false

    static var defaultSettings: AIARSettings {
        AIARSettings(
            isFaceDetectionEnabled: true,
            isAISceneRecognitionEnabled: false,
            isAutoFocusOnFacesEnabled: true,
            isYOLODetectionEnabled: false,
            isVisionProcessingEnabled: false,
            isDeeplabEnabled: false,
            isFastViTEnabled: false,
            isDepthEstimationEnabled: false,
            enableARKitFeatures: false,
            enablePlaneDetection: false,
            enablePersonSegmentation: false
        )
    }
}
