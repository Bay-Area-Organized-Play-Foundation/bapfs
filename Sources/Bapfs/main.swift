import Foundation
import Plot
import Publish

// MARK: - Nodes and Attributes
public extension Node where Context == HTML.DocumentContext {
/// Add an HTML `<head>` tag within the current context, based
    /// on inferred information from the current location and `Website`
    /// implementation.
    static func head<T: Website>(
for location: Location,
on site: T,
titleSeparator: String = " | ",
stylesheetPaths: [Path] =
    ["/styles.css",
     "https://fonts.googleapis.com/css2?family=Roboto+Condensed:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&display=swap",
     "https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap"
    ],
rssFeedPath: Path? = .defaultForRSSFeed,
rssFeedTitle: String? = nil
    ) -> Node {
var title = location.title
if title.isEmpty {
            title = site.name
        } else {
            title.append(titleSeparator + site.name)
        }
var description = location.description
if description.isEmpty {
            description = site.description
        }
return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .forEach(stylesheetPaths, { .stylesheet($0) }),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .unwrap(rssFeedPath, { path in
let title = rssFeedTitle ?? "Subscribe to \(site.name)"
return .rssFeedLink(path.absoluteString, title: title)
            }),
            .unwrap(location.imagePath ?? site.imagePath, { path in
let url = site.url(for: path)
return .socialImageLink(url)
            })
        )
    }
}

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
    var imagePath: Path? { "/images/dragon_og.jpg" }
}

// Add all markdown, copy compiled css to Output folder, generate webdite.
try Bapfs().publish(using: [
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .Bapfs),
    .generateSiteMap()
])
