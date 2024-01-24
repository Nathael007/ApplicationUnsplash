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
    // Construit un objet URLComponents avec la base de l'API Unsplash
    // Et un query item "client_id" avec la clé d'API retrouvé depuis PListManager
    func unsplashApiBaseUrl() -> URLComponents {}
    // Par défaut orderBy = "popular" et perPage = 10 -> Lisez la documentation de l'API pour comprendre les paramètres, vous pouvez aussi en ajouter d'autres si vous le souhaitez
    func feedUrl(orderBy: String = "popular", perPage: Int = 10) -> URL? {}
}

