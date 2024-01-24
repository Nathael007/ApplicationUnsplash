//
//  FeedState.swift
//  UnsplashApp
//
//  Created by Nathael MEUNIER on 24/01/2024.
//

import Foundation

class FeedState: ObservableObject {
    @Published var photosFeed: [UnsplashPhoto]? = []
    @Published var topicsFeed: [Topics]? = []

    private let unsplashAPI = UnsplashAPI()
    
    // Fetch home feed doit utiliser la fonction feedUrl de UnsplashAPI
    // Puis assigner le résultat de l'appel réseau à la variable homeFeed
    func fetchHomeFeed() async {
        do {
            let url = unsplashAPI.feedUrl()
            let request = URLRequest(url: url!)
            let (data, _) = try await URLSession.shared.data(for: request)
            
            do {
                let decoder = JSONDecoder()
                let decodedPhotos = try decoder.decode([UnsplashPhoto].self, from: data)
                await MainActor.run {
                    photosFeed = decodedPhotos
                }
                print("Photos decoded successfully: \(decodedPhotos)")
            } catch {
                print("Error decoding photos: \(error)")
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedTopics = try decoder.decode([Topics].self, from: data)
                await MainActor.run {
                    topicsFeed = decodedTopics
                }
                print("Topics decoded successfully: \(decodedTopics)")
            } catch {
                print("Error decoding topics: \(error)")
            }
        } catch {
            print("Error fetching feed: \(error)")
        }
    }
}


