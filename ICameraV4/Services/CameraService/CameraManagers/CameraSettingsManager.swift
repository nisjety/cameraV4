/*
 //  CameraSettingsManager.swift
 //  ICameraV4
 //
 //  Created by Ima Da Costa on 15/08/2024.
 //
 
 import AVFoundation
 import os
 
 class CameraSettingsManager: CameraSettingsManagerProtocol {
 private let logger = Logger(subsystem: "com.yourapp.icamera", category: "CameraSettingsManager")
 
 private var aspectRatio: AspectRatio = .ratio4x3
 private var isHDREnabled: Bool = false
 private var selectedFilter: FilterType = .none
 private var livePhotosEnabled: Bool = false
 
 // Set the aspect ratio for the capture session
 func setAspectRatio(_ ratio: AspectRatio) {
 aspectRatio = ratio
 applyAspectRatio()
 logger.info("Aspect ratio set to \(ratio).")
 }
 
 // Enable or disable HDR for the capture session
 func enableHDR(_ enabled: Bool) {
 isHDREnabled = enabled
 applyHDRSetting()
 logger.info("HDR enabled: \(enabled).")
 }
 
 // Apply a filter to the capture session
 func applyFilter(_ filter: FilterType) {
 selectedFilter = filter
 applySelectedFilter()
 logger.info("Filter applied: \(filter).")
 }
 
 // Enable or disable Live Photos for the capture session
 func enableLivePhotos(_ enabled: Bool) {
 livePhotosEnabled = enabled
 applyLivePhotosSetting()
 logger.info("Live Photos enabled: \(enabled).")
 }
 
 // MARK: - Private Methods
 
 private func applyAspectRatio() {
 // Configure the session output to match the selected aspect ratio
 // This might involve adjusting the video connection, changing presets, or cropping
 // Example: Adjusting the video connection to match the aspect ratio
 guard let videoConnection = getVideoConnection() else { return }
 switch aspectRatio {
 case .ratio16x9:
 videoConnection.videoScaleAndCropFactor = 16.0 / 9.0
 case .ratio1x1:
 videoConnection.videoScaleAndCropFactor = 1.0
 default:
 videoConnection.videoScaleAndCropFactor = 4.0 / 3.0
 }
 }
 
 private func applyHDRSetting() {
 // Adjust the session settings to enable or disable HDR
 // This might involve configuring the AVCapturePhotoSettings for HDR or changing the session preset
 // Example: Enable or disable HDR on the photo output
 guard let photoOutput = getPhotoOutput() else { return }
 photoOutput.isHighResolutionCaptureEnabled = isHDREnabled
 }
 
 private func applySelectedFilter() {
 // Apply the selected filter to the capture session
 // Filters might be applied in real-time or post-capture depending on the implementation
 // Example: Applying a CIFilter to the video output
 guard let videoConnection = getVideoConnection() else { return }
 // Assume there is a method to apply a CIFilter to the video output
 applyCIFilter(to: videoConnection, filter: selectedFilter)
 }
 
 private func applyLivePhotosSetting() {
 // Enable or disable live photos on the capture session
 // This might involve configuring the AVCapturePhotoSettings for live photos
 guard let photoOutput = getPhotoOutput() else { return }
 photoOutput.isLivePhotoCaptureEnabled = livePhotosEnabled
 }
 
 // Helper method to get the video connection
 private func getVideoConnection() -> AVCaptureConnection? {
 // Implement logic to retrieve the AVCaptureConnection from the session
 return nil // Placeholder
 }
 
 // Helper method to get the photo output
 private func getPhotoOutput() -> AVCapturePhotoOutput? {
 // Implement logic to retrieve the AVCapturePhotoOutput from the session
 return nil // Placeholder
 }
 
 // Helper method to apply CIFilter
 private func applyCIFilter(to connection: AVCaptureConnection, filter: FilterType) {
 // Implement logic to apply a CIFilter based on the selected filter type
 // This might involve creating a CIFilter and attaching it to the video output
 }
 }
 
 */
