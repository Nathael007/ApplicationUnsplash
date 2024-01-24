//
//  Image.swift
//  UnsplashApp
//
//  Created by Nathael MEUNIER on 23/01/2024.
//


struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let slug: String?
    let user: User?
    let urls: UnsplashImageUrls?

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case user
        case urls
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







