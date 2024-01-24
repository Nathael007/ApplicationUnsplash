//
//  FeedState.swift
//  UnsplashApp
//
//  Created by Nathael MEUNIER on 24/01/2024.
//

import Foundation

class FeedState: ObservableObject {
    @Published var homeFeed: [UnsplashPhoto]?

    private let unsplashAPI = UnsplashAPI()
    
    // Fetch home feed doit utiliser la fonction feedUrl de UnsplashAPI
    // Puis assigner le résultat de l'appel réseau à la variable homeFeed
    func fetchHomeFeed() async {
        do {
            let url = unsplashAPI.feedUrl()
            let request = URLRequest(url: url!)
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let deserializedData = try? JSONDecoder().decode([UnsplashPhoto].self, from: data) {
                await MainActor.run{
                    homeFeed = deserializedData
                }
            } else {
                print("Failed to decode JSON data")
            }
        } catch {
            print("Error fetching home feed: \(error)")
        }
    }
}


