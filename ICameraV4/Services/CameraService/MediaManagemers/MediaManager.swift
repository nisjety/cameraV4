//
//  MediaManager.swift
//  ICameraV4
//
//  Created by Ima Da Costa on 18/08/2024.
//

import Foundation
import AVFoundation

final class MediaManager {

    let mediaLibrary = MediaLibrary()

    func save(photo: Photo) async throws {
        try await mediaLibrary.save(photo: photo)
    }

    func save(movie: Movie) async throws {
        try await mediaLibrary.save(movie: movie)
    }
}
