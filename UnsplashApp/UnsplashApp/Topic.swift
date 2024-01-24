//
//  Topic.swift
//  UnsplashApp
//
//  Created by Nathael MEUNIER on 24/01/2024.
//

import Foundation

struct Topics: Codable, Identifiable {
    let id: String
    let slug: String?
    let title: String?
    let description: String?
    let total_photos: Int?
    let links: Links?
    let cover_photo: UnsplashPhoto?
}

struct Links: Codable {
    let it: String
    let html: String
    let photo: String

    enum CodingKeys: String, CodingKey {
        case it = "self"
        case html
        case photo
    }
}
