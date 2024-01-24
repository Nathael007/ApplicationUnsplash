//
//  ContentView.swift
//  UnsplashApp
//
//  Created by Nathael MEUNIER on 23/01/2024.
//

import SwiftUI

let imageURLs: [String] = [
    "https://images.unsplash.com/photo-1683009427666-340595e57e43?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MXwxfGFsbHwxfHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1563473213013-de2a0133c100?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHwyfHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1490349368154-73de9c9bc37c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHwzfHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1495379572396-5f27a279ee91?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw0fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1560850038-f95de6e715b3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw1fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1695653422715-991ec3a0db7a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MXwxfGFsbHw2fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1547327132-5d20850c62b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw3fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1492724724894-7464c27d0ceb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw4fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1475694867812-f82b8696d610?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw5fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1558816280-dee9521ff364?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHwxMHx8fHx8fDF8fDE3MDM3NTk1NTF8&ixlib=rb-4.0.3&q=80&w=1080"
]


struct ContentView: View {
    @State private var imageList: [UnsplashPhoto] = []
    
    @StateObject var feedState = FeedState()

    func loadData() async {
        await feedState.fetchHomeFeed()
    }

    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    Task {
                        await loadData()
                    }
                }, label: {
                    Text("Load Data")
                })

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 8), GridItem(.flexible())]) {
                        if let feedPhoto = feedState.homeFeed {
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


