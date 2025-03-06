import Foundation

struct MeadType: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let searchTerm: String
    
    static let types = [
        MeadType(
            name: "Traditional Mead",
            description: "The purest form of mead, made with honey, water, and yeast.",
            searchTerm: "traditional mead making tutorial"
        ),
        MeadType(
            name: "Melomel",
            description: "Mead made with honey and fruit.",
            searchTerm: "fruit melomel mead recipe"
        ),
        MeadType(
            name: "Metheglin",
            description: "Spiced mead, often with herbs and spices like cinnamon, clove, or juniper.",
            searchTerm: "spiced metheglin mead recipe"
        ),
        MeadType(
            name: "Braggot",
            description: "A blend of mead and beer, made with both honey and malted grains.",
            searchTerm: "braggot mead beer recipe"
        ),
        MeadType(
            name: "Cyser",
            description: "Mead made with apple juice or cider.",
            searchTerm: "cyser apple mead recipe"
        ),
        MeadType(
            name: "Pyment",
            description: "Mead made with grapes or grape juice.",
            searchTerm: "pyment grape mead recipe"
        ),
        MeadType(
            name: "Bochet",
            description: "Mead made with caramelized or burnt honey.",
            searchTerm: "bochet caramelized honey mead"
        ),
        MeadType(
            name: "Viking Blood",
            description: "Traditional Nordic mead with cherries and hibiscus.",
            searchTerm: "viking blood mead recipe cherry hibiscus"
        )
    ]
}
