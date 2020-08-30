import Foundation
import Plot
import Publish
import SassPublishPlugin

// configuration for the website
struct Bapfs: Website {
    enum SectionID: String, WebsiteSectionID {
        // sections
        case games
        case conventions
        case resources
        case news
        case contact
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://bayareapathfinder.com")!
    var name = "Bay Area Organized Play"
    var description = "Bay Area Organized Play"
    var language: Language { .english }
    var imagePath: Path? { "/images/logo" }
}

// Copy the Resources folder, Genertate the site and site map.
try Bapfs().publish(using: [
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .Bapfs),
    .generateSiteMap()
])
