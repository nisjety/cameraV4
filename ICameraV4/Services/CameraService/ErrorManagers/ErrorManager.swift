//
//  ErrorManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 19/08/2024.
//

import Foundation

final class ErrorManager: ObservableObject {
    @Published var error: Error?

    func handleError(_ error: Error) {
        self.error = error
        // Implement UI feedback such as showing an alert or notification.
    }

    func logError(_ error: Error) {
        // Here you can log the error to a file, console, or analytics service
        print("Logged Error: \(error.localizedDescription)")
    }
}
