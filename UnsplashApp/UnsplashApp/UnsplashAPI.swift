//
//  UnsplashAPI.swift
//  UnsplashApp
//
//  Created by Nathael MEUNIER on 24/01/2024.
//
// Ce fichier doit contenir la logique spécifique à l’API Unsplash, nous y retrouverons le système d’authentification à l’API, la construction des URLs en fonction des besoins.
//

import Foundation

struct UnsplashAPI {
    private let scheme = "https"
    private let host = "api.unsplash.com"
    private let photosPath = "/photos"
    private let topicsPath = "/topics"
    private let key = ConfigurationManager.instance.plistDictionnary.clientId
        
    // Construit un objet URLComponents avec la base de l'API Unsplash pour les photos
    // Et un query item "client_id" avec la clé d'API retrouvée depuis PListManager
    func unsplashPhotosBaseUrl() -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = photosPath
        components.queryItems = [URLQueryItem(name: "client_id", value: key)]
        return components
    }
    
    func unsplashTopicsBaseUrl() -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = topicsPath
        components.queryItems = [URLQueryItem(name: "client_id", value: key)]
        return components
    }

    // Par défaut orderBy = "popular" et perPage = 10
    // Lisez la documentation de l'API pour comprendre les paramètres, vous pouvez aussi en ajouter d'autres si vous le souhaitez
    func feedUrl(orderBy: String = "popular", perPage: Int = 10, isPhotos: Bool = true) -> URL? {
        var components: URLComponents
        if isPhotos {
            components = unsplashPhotosBaseUrl()
        } else {
            components = unsplashTopicsBaseUrl()
        }
        
        components.queryItems?.append(URLQueryItem(name: "order_by", value: orderBy))
        components.queryItems?.append(URLQueryItem(name: "per_page", value: "\(perPage)"))
        
        return components.url
    }
}
