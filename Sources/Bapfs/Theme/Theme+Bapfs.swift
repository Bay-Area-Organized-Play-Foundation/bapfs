/**
 BAPFS Theme
*/
import Foundation
import Plot
import Publish

public extension Theme {
    static var Bapfs: Self {
        Theme(
            htmlFactory: BapfsHTMLFactory(),
            resourcePaths: [
            ] // no need for paths since we're compiling sass into Resources folder and copying that over in main
        )
    }
}
private struct BapfsHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .section(.id("home_hero"),
                         .article(
                            .h2("Welcome to Org Play!"),
                            .a(.class("base_button"),
                               .href("/games/"),
                               .text("Find a Game")
                            ) // a.base_button
                        )
                    ), // section#home_hero
                    .section(.class("section_wrapper"),
                        .article(.class("span12 post"),
                            .contentBody(index.body)
                         ) // article
                    ), // section.section_wrapper
                    .article(
                        .h2("Recent Articles")
                    ),
                    .itemList(
                        for: context.allItems(
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    ) // itemlist
                ), // div.wrapper
                .footer(for: context.site)
            ) // body
        ) // html
    }

    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        switch section.id.rawValue {
        case "games":
            return HTML(
                .lang(context.site.language),
                .head(for: section, on: context.site),
                .body(
                    .header(for: context, selectedSection: section.id),
                    .wrapper(
                        .section(.id("games_hero"),
                             .article(
                                .h2("Games")
                            )
                        ), // games_hero
                        .section(.class("section_wrapper"),
                            .article(.class("span12 post"),
                                .contentBody(section.body)
                            ) // article.span12 post
                        ),
                        .itemList(for: section.items, on: context.site)
                    ), // wrapper
                    .footer(
                        for: context.site
                    ) // footer
                ) // body
            ) // html
        case "new_players":
            return HTML(
                .lang(context.site.language),
                .head(for: section, on: context.site),
                .body(
                    .header(for: context, selectedSection: section.id),
                    .wrapper(
                        .section(.id("new_hero"),
                             .article(
                                .h2("Beginning your Journey")
                            )
                        ), // games_hero
                        .section(.class("section_wrapper"),
                            .article(.class("span12 post"),
                                .contentBody(section.body)
                            ) // article.span12 post
                        ),
                        .itemList(for: section.items, on: context.site)
                    ), // wrapper
                    .footer(
                        for: context.site
                    ) // footer
                ) // body
            ) // html
        case "resources":
            return HTML(
                .lang(context.site.language),
                .head(for: section, on: context.site),
                .body(
                    .header(for: context, selectedSection: section.id),
                    .wrapper(
                        .section(.id("resource_hero"),
                             .article(
                                .h2("Resources")
                            )
                        ), // games_hero
                        .section(.class("section_wrapper"),
                            .article(.class("span12 post"),
                                .contentBody(section.body)
                            ) // article.span12 post
                        ),
                        .itemList(
                            for: Array(
                                context.allItems(
                                    sortedBy: \.date,
                                    order: .descending
                                ).filter { $0.sectionID.rawValue  == "resources" }
                            ),
                            on: context.site
                        ) // itemlist
                    ), // wrapper
                    .footer(
                        for: context.site
                    ) // footer
                ) // body
            ) // html
        case "news":
            return HTML(
                .lang(context.site.language),
                .head(for: section, on: context.site),
                .body(
                    .header(for: context, selectedSection: section.id),
                    .wrapper(
                        .section(.id("news_hero"),
                             .article(
                                .h2("News")
                            )
                        ), // games_hero
                        .section(.class("section_wrapper"),
                            .article(.class("span12 post"),
                                .contentBody(section.body)
                            ) // article.span12 post
                        ),
                        .itemList(
                            for: Array(
                                context.allItems(
                                    sortedBy: \.date,
                                    order: .descending
                                ).filter { $0.sectionID.rawValue  == "news" }
                            ),
                            on: context.site
                        ) // itemlist
                    ), // wrapper
                    .footer(
                        for: context.site
                    ) // footer
                ) // body
            ) // html
        case "contact":
            return HTML(
                .lang(context.site.language),
                .head(for: section, on: context.site),
                .body(
                    .header(for: context, selectedSection: section.id),
                    .wrapper(
                        .section(.id("contact_hero"),
                             .article(
                                .h2("Contact Us")
                            )
                        ), // games_hero
                        .section(.class("section_wrapper"),
                            .article(.class("span12 post"),
                                .contentBody(section.body)
                            ) // article.span12 post
                        ),
                        .itemList(for: section.items, on: context.site)
                    ), // wrapper
                    .footer(
                        for: context.site
                    ) // footer
                ) // body
            ) // html
        default:
            return HTML(
                .lang(context.site.language),
                .head(for: section, on: context.site),
                .body(
                    .header(for: context, selectedSection: section.id),
                    .wrapper(
                        .section(.class("section_wrapper"),
                            .article(.class("span12 post"),
                                .contentBody(section.body)
                            ) // article.span12 post
                        ),
                        .itemList(for: section.items, on: context.site)
                    ), // wrapper
                    .footer(
                        for: context.site
                    ) // footer
                ) // body
            ) // html
        }
    }

    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .wrapper(
                    .section(.class("section_wrapper"),
                        .article(.class("span12 post"),
                            (.contentBody(item.body)),
                            .hr(),
                            .p("Tagged with: "),
                            .tagList(for: item, on: context.site)
                        ) // article .span12 post
                    ) // section.seciton_wrapper
                ), // wrapper
                .footer(for: context.site)
            )
        )
    }
    
    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(.contentBody(page.body)),
                .footer(for: context.site)
            ) // body
        ) // html
    }
    
    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1("Browse all tags"),
                    .ul(.class("all-tags"),
                        .forEach(page.tags.sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                ) // a
                            ) // li.tag
                        } // forEach
                    ) // ul.all-tags
                ), // wrapper
                .footer(for: context.site)
            ) // body
        ) // html
    }

    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .section(.class("section_wrapper"),
                        .article(.class("span12 tagFilterIndex"),
                            .h1(
                                "Tagged with: ",
                                .span(.class("tag"), .text(page.tag.string))
                            ), // h1
                            .a(
                                .href(context.site.tagListPath)
                            ), // a
                            .itemList(
                                for: context.items(
                                    taggedWith: page.tag,
                                    sortedBy: \.date,
                                    order: .descending
                                ), // for
                                on: context.site
                            ) // itemList
                        ) // article.span12tagFilterIndex
                    ) // section .section_wrapper
                ), // wrapper
                .footer(for: context.site)
            )
        ) // html
    }
}

private extension Node where Context == HTML.BodyContext { static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }

    static func header<T: Website>( for context: PublishingContext<T>, selectedSection: T.SectionID? ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
            .div(.class("menu_toggler"),
                .span(.class("open_close"))
            ), // .menu_toggler
            .nav(.id("fixed_nav"),
                 .a(.class("logo hide_medium_up"), .href("/"), .text(context.site.name)),
                 .div(.class("menu"),
                    .a(.class("logo hide_small_only"), .href("/"), .text(context.site.name)),
                    .ul(.forEach(sectionIDs) { section in
                      .li(.a(
                          .class(section == selectedSection ? "selected" : ""),
                          .href(context.sections[section].path),
                          .text(context.sections[section].title)
                      )) // li
                    }) // ul
                ) // .menu
            ) // #fixed_nav
        ) // header
    } // node
    
    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .section(.class("section_wrapper"),
            .forEach(items) { item in
                .article(.class("span6 itemList"),
                       .h4(.text(item.title)),
                       .p(.text(item.description)),
                       .p(.em(.text(DateFormatter.localizedString(from: item.date, dateStyle: .medium, timeStyle: .none)))),
                       .a(.class(""), .href(item.path),
                       .div(
                        .h5("Read Now"),
                        .p("Categories:"),
                            .tagList(for: item, on: site)
                        ) // div
                    ) // a.itemListLink
                ) // article.span6
            } // forEach
        ) // section
    } // node

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .p(.class("tag-list"),
            .forEach(item.tags) { tag in
                .a(
                    .href(site.path(for: tag)),
                    .text(tag.string)
                ) // a
            } // forEach
        ) //p.tag-list
    } // node

    static func contactForm<T: Website>(for site: T) -> Node {
        return .h2("Drop form here later")
    } // node
    
    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .section(.class("section_wrapper"),
                .article(.class("span12 mailing_list_signup"),
                     .h5("Join our Communities:"),
                     .p(.class("social-link"),
                         .a(
                            .href("https://discord.gg/Qj753NEXJm"),
                            .text("Discord")
                         ) // a
                     ), // p
                     .p(.class("social-link"),
                         .a(
                            .href("https://join.slack.com/t/pathfindersociety/shared_invite/zt-qkh9iw6e-lW1UCYsbRmMSH5wlI_FwOg"),
                            .text("Slack")
                         ) // a
                     ), // p
                     .p(.class("social-link last"),
                         .a(
                            .href("https://www.facebook.com/groups/OaktownPathfinderSociety"),
                            .text("Facebook")
                         ) // a
                     ) // p
                ),
                .article(.class("span12 mailing_list_signup"),
                    .h5("Join Our Mailing List:"),
                    .a(.class("button"),
                        .href("http://eepurl.com/gXlnpf"),
                        .text("Sign up on Mail Chimp")
                    ) // a
                ),
                .article(.class("span12 mailing_list_signup"),
                    .h5("@ 2021 San Francisco Organized Play"),
                    .p(
                        .class("footer-legal"),
                        .text("This promotional notice uses trademarks and/or copyrights owned by Paizo Publishing, LLC, which are under Paizo's community use policy. We are expressly prohibited from charging you to use or access this content. This promotional notice is not published, endorsed, or specifically approved by Paizo Publishing. For more information about Paizo's Community Use Policy, please visit paizo.com/ paizo/ about/ communityuse. For more information about Paizo Publishing and Paizo Products, please visit paizo.com.")
                    ) // p
                ) // article.span12
            ), // section.section_wrapper
            .raw("""
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
                    <script type="text/javascript">
                    const toggler = document.querySelector('.menu_toggler');
                    const menu    = document.querySelector('.menu');

                    /*
                     * Toggles on and off the 'active' class on the menu
                     * and the toggler button.
                     */
                    toggler.addEventListener('click', () => {
                      toggler.classList.toggle('active');
                      menu.classList.toggle('active');
                    })
                    </script>
                """) // raw -- Jam in some libs and simple js
        ) // footer
    } // node
}
