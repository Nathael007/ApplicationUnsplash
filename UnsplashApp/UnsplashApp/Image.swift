//
//  Image.swift
//  UnsplashApp
//
//  Created by Nathael MEUNIER on 23/01/2024.
//

import Foundation

struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let slug: String?
    let user: User?
    let urls: UnsplashImageUrls?
    let color: String?
    let topic_submissions: Topics

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case user
        case urls
        case color
        case topic_submissions
    }
}

struct User: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct UnsplashImageUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String

    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct Topics: Codable, Coding {
    let id: String
    let Slug: String?

}

struct Links: Codable {
    let it: String
    let html: String
    let photo: String

    enum CodingKeys: String, CodingKey {
        case it = "self"
        html
        photo
    }
}
