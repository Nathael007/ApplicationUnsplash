//
//  ContentView.swift
//  UnsplashApp
//
//  Created by Nathael MEUNIER on 23/01/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var photoFeedState = FeedState()

    func loadPhotoData() async {
        await photoFeedState.fetchHomeFeed()
    }

    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    Task {
                        await loadPhotoData()
                    }
                }, label: {
                    Text("Load Data")
                })
                ScrollView(.horizontal) {
                    LazyHStack {
                        if let feedTopics = photoFeedState.photosFeed {
                            ForEach(feedTopics) { topic in
                                VStack {
                                    if let unwrappedImageTopics = topic.urls?.regular {
                                        AsyncImage(url: URL(string: unwrappedImageTopics)) { topic in
                                            topic.centerCropped()
                                        } placeholder: {
                                            if let colorString = topic.color {
                                                if let unwrappedColor = Color(hex: colorString) {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(unwrappedColor)
                                                        .frame(width: 150)
                                                } else {
                                                    ProgressView()
                                                        .frame(width: 150)
                                                }
                                            } else {
                                                ProgressView()
                                                    .frame(width: 150)
                                            }
                                        }
                                        .frame(width: 150)
                                        .cornerRadius(12)
                                    }
                                    Text(topic.user?.name ?? "")
                                }
                            }
                        }
                        else {
                            ForEach(0..<12) { _ in
                                Rectangle()
                                    .redacted(reason: .placeholder)
                                    .frame(width: 150)
                                    .cornerRadius(12)
                                    .foregroundColor(Color.gray.opacity(0.3))
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                }
                .padding(.vertical, 5)
                .frame(height: 100)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 8), GridItem(.flexible())]) {
                        if let feedPhoto = photoFeedState.photosFeed {
                            ForEach(feedPhoto) { image in
                                if let unwrappedImage = image.urls?.regular {
                                    AsyncImage(url: URL(string: unwrappedImage)) { image in
                                        image.centerCropped()
                                    } placeholder: {
                                        if let colorString = image.color {
                                            if let unwrappedColor = Color(hex: colorString) {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(unwrappedColor)
                                                    .frame(height: 150)
                                            } else {
                                                // Gestion des erreurs lors de la conversion de la couleur
                                                ProgressView()
                                                    .frame(height: 150)
                                            }
                                        } else {
                                            // Aucune couleur fournie, affichez le placeholder
                                            ProgressView()
                                                .frame(height: 150)
                                        }
                                    }
                                    .frame(height: 150)
                                    .cornerRadius(12)
                                }
                            }
                        }
                        else {
                            ForEach(0..<12) { _ in
                                Rectangle()
                                    .redacted(reason: .placeholder)
                                    .frame(height: 150)
                                    .cornerRadius(12)
                                    .foregroundColor(Color.gray.opacity(0.3))
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .navigationTitle("Feed")
                }
            }
        }
    }
}



extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        self.init(
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0
        )
    }
}

// Définition d'une extension pour le type SwiftUI 'Image'
extension Image {
    // Définition de la fonction 'centerCropped' qui retourne une vue générique conforme à 'View'
    func centerCropped() -> some View {
        // Utilisation de GeometryReader pour obtenir des informations sur l'espace de disposition disponible
        GeometryReader { geo in
            // L'image sur laquelle cette extension est appliquée
            self
                // Rendre l'image redimensionnable
                .resizable()
                // Mise à l'échelle de l'image pour remplir complètement le cadre
                .scaledToFill()
                // Définir la taille du cadre de l'image sur la taille de la vue parente
                .frame(width: geo.size.width, height: geo.size.height)
                // Clipper l'image pour éviter tout débordement
                .clipped()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}


