import Foundation
import Plot
import Publish

// configuration for the website
struct Bapfs: Website {
    enum SectionID: String, WebsiteSectionID {
        // sections
        case games
//        case conventions
        case new_players
        case resources
        case news
        case contact
    }

    struct ItemMetadata: WebsiteItemMetadata {
        
    }

    // configure the website:
    var url = URL(string: "https://bayareapathfinder.com")!
    var name = "Bay Area Organized Play"
    var description = "Bay Area Organized Play"
    var language: Language { .english }
    var imagePath: Path? { "/images/logo" }
}

// Add all markdown, copy compiled css to Output folder, generate webdite.
try Bapfs().publish(using: [
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .Bapfs),
    .generateSiteMap()
])
