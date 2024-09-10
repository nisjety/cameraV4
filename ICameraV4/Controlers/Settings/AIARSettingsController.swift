//
//  AIARSettingsController.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 03/09/2024.
//

import Foundation
import Foundation
import Combine

final class AIARSettingsController: ObservableObject {
    @Published var isFaceDetectionEnabled: Bool = true
    @Published var isAISceneRecognitionEnabled: Bool = false
    @Published var isAutoFocusOnFacesEnabled: Bool = true
    @Published var isYOLODetectionEnabled: Bool = false
    @Published var isVisionProcessingEnabled: Bool = false
    @Published var isDeeplabEnabled: Bool = false
    @Published var isFastViTEnabled: Bool = false
    @Published var isDepthEstimationEnabled: Bool = false
    @Published var enableARKitFeatures: Bool = false
    @Published var enablePlaneDetection: Bool = false
    @Published var enablePersonSegmentation: Bool = false

    func applyAISettings(_ settings: AIARSettings) {
        isFaceDetectionEnabled = settings.isFaceDetectionEnabled
        isAISceneRecognitionEnabled = settings.isAISceneRecognitionEnabled
        isAutoFocusOnFacesEnabled = settings.isAutoFocusOnFacesEnabled
        isYOLODetectionEnabled = settings.isYOLODetectionEnabled
        isVisionProcessingEnabled = settings.isVisionProcessingEnabled
        isDeeplabEnabled = settings.isDeeplabEnabled
        isFastViTEnabled = settings.isFastViTEnabled
        isDepthEstimationEnabled = settings.isDepthEstimationEnabled
        enableARKitFeatures = settings.enableARKitFeatures
        enablePlaneDetection = settings.enablePlaneDetection
        enablePersonSegmentation = settings.enablePersonSegmentation
    }
}
