//
//  CaptureErrorManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 27/08/2024.
//

import Foundation
import os

final class CaptureErrorManager {
    
    private let logger = Logger(subsystem: "com.icamera.ICameraV4", category: "CaptureErrorManager")
    
    /// Handles the error by logging it, notifying the user, and taking appropriate action based on the context.
    /// - Parameters:
    ///   - error: The error that occurred.
    ///   - context: A description of the context in which the error occurred.
    func handleError(_ error: Error, in context: String) {
        logError(error, context: context)
        notifyUser(of: error, context: context)
        takeAppropriateAction(for: error, context: context)
    }
    
    /// Logs the error with the specified context.
    /// - Parameters:
    ///   - error: The error to log.
    ///   - context: The context in which the error occurred.
    private func logError(_ error: Error, context: String) {
        logger.error("Error in \(context): \(error.localizedDescription)")
    }
        
    
    /// Notifies the user of the error.
    /// - Parameters:
    ///   - error: The error that occurred.
    ///   - context: The context in which the error occurred.
    private func notifyUser(of error: Error, context: String) {
        DispatchQueue.main.async {
            print("User Notification: An error occurred in \(context). Please check the details.")
        }
    }

    /// Takes appropriate action based on the type of error and context.
    /// - Parameters:
    ///   - error: The error that occurred.
    ///   - context: The context in which the error occurred.
    private func takeAppropriateAction(for error: Error, context: String) {
        if let cameraError = error as? CameraError {
            switch cameraError {
            case .setupFailed:
                handleCriticalError(error, context: context, userMessage: "Camera setup failed. Please check your camera settings.")
            case .deviceSwitchingFailed:
                handleCriticalError(error, context: context, userMessage: "Failed to switch camera device. Please try again.")
            case .inputAdditionFailed:
                handleCriticalError(error, context: context, userMessage: "Failed to add input to capture session.")
            case .outputAdditionFailed:
                handleCriticalError(error, context: context, userMessage: "Failed to add output to capture session.")
            case .addInputFailed:
                handleCriticalError(error, context: context, userMessage: "Failed to add input to capture session.")
            case .configurationFailed:
                handleCriticalError(error, context: context, userMessage: "Camera configuration failed.")
            case .deviceUnavailable:
                handleCriticalError(error, context: context, userMessage: "Camera device is unavailable.")
            case .authorizationFailed:
                handleCriticalError(error, context: context, userMessage: "Camera authorization failed.")
            case .authorizationDenied:
                handleCriticalError(error, context: context, userMessage: "Camera authorization was denied.")
            case .sessionInterrupted:
                handleCriticalError(error, context: context, userMessage: "Camera session was interrupted.")
            case .runtimeError:
                handleCriticalError(error, context: context, userMessage: "A runtime error occurred.")
            case .multiCamNotSupported:
                handleCriticalError(error, context: context, userMessage: "Multi-camera setup is not supported on this device.")
            case .videoDeviceUnavailable:
                handleCriticalError(error, context: context, userMessage: "The video device is unavailable.")
            case .audioDeviceUnavailable:
                handleCriticalError(error, context: context, userMessage: "The audio device is unavailable.")
            case .addOutputFailed:
                handleCriticalError(error, context: context, userMessage: "Failed to add output to capture session.")
            case .deviceChangeFailed:
                handleCriticalError(error, context: context, userMessage: "Failed to change camera device.")
            case .cannotAddInput:
                handleCriticalError(error, context: context, userMessage: "Failed to add the specified input to the capture session.")
            }
        } else {
            logger.error("Unhandled error in \(context): \(error.localizedDescription)")
        }
    }
    
    /// Handles critical errors by logging them, notifying the user, and potentially taking recovery actions.
    /// - Parameters:
    ///   - error: The critical error that occurred.
    ///   - context: The context in which the error occurred.
    ///   - userMessage: The message to display to the user.
    private func handleCriticalError(_ error: Error, context: String, userMessage: String) {
            logger.critical("Critical error in \(context): \(error.localizedDescription)")
            notifyUser(of: error, context: userMessage)
        }
    }
