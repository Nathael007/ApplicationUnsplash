# ApplicationUnsplash

## Exercice 

Expliquez ce qu’est LazyVGrid et pourquoi on l’utilise :
La LazyVGrid permet de créer des grilles avec un défilemment vertical. C'est un container fait pour faire des longues liste d'élément, c'est pourquoi il est approprié de l'utiliser dans la cas d'une liste d'images.


Expliquez les différents types de colonnes et pourquoi on utilise flexible ici :
Les différentes types de colonnes :
Fixed: crée une colonne de largeur fixe avec la valeur spécifiée.
Flexible: crée une colonne dont la largeur s'ajuste automatiquement en fonction de l'espace disponible.
Adaptable: crée une colonne dont la largeur s'ajuste automatiquement entre une valeur minimale et maximale en fonction de l'espace disponible.

En utilisant GridItem(.flexible()), cela nous permet d'adapter la colonne automatiquement à l'espace disponible dans la grille.

Votre grille ne doit pas être très jolie, expliquez pourquoi les images prennent toute la largeur de l’écran :


## Exercice 2

Expliquer ce que fait ce modifier ligne par ligne :

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


