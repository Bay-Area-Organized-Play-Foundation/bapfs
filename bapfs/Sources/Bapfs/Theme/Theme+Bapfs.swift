/**
 BAPFS Theme
*/
import Plot
import Publish


public extension Theme {
    static var Bapfs: Self {
        Theme(
            htmlFactory: BapfsHTMLFactory(),
            resourcePaths: [
            ] // no need for pathhs since we're compiling sass into Resources folder and copying that over in main
        )
    }
}

private struct BapfsHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site,
                stylesheetPaths:
                    ["/styles.css",
                     "https://fonts.googleapis.com/css2?family=Roboto+Condensed:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&display=swap",
                     "https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap"
                    ]
            ),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .section(.id("home_hero"),
                         .article(
                            .h2("Welcome to the Bay!"),
                            .img(.id("d20"), .src("/images/d20.svg")),
                            .h4("Organized Play in the Caligornia Bay Area"),
                            .a(.class("base_button"),
                               .href("/events/"),
                               .text("Find a Game")
                            ) // a.base_button
                        )
                    ), // section#home_hero
                    .section(.class("section_wrapper"),
                        .article(.class("span12"),
                            .contentBody(index.body)
                         ) // article
                    ), // section.section_wrapper
                    .itemList(
                        for: context.allItems(
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    ) // itemlist
                ), // div.wrapper
                .footer(for: context.site),
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
            ) // body
        ) // html
    }
    
    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
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
                       .a(.class(""), .href(item.path),
                       .div(
                            .h5("Read Now"),
                            .tagList(for: item, on: site)
                        ) // div
                    ) // a.itemListLink
                ) // article.span6
            } // forEach
        ) // sectino
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
        return .h2("Here's your form")
    } // node
    
    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .section(.class("section_wrapper"),
                .article(.class("span12"),
                    .p(
                        .text("&copy; 2020 San Francisco Organized Play")
                    )
                ), // article.span12
                .article(.class("span4"),
                    .p(
                        .class("footer-legal"),
                        .text("This promotional notice uses trademarks and/or copyrights owned by Paizo Publishing, LLC, which are under Paizo's community use policy. We are expressly prohibited from charging you to use or access this content. This promotional notice is not published, endorsed, or specifically approved by Paizo Publishing. For more information about Paizo's Community Use Policy, please visit paizo.com/ paizo/ about/ communityuse. For more information about Paizo Publishing and Paizo Products, please visit paizo.com.")
                    ) // p
                ), // article.span4
                .article(.class("span8 mailing_list_signup"),
                    .h5("Join Our Mailing List"),
                    .a(
                        .href("http://eepurl.com/gXlnpf"),
                        .text("Sign up on Mail Chimp")
                    ) // a
                ) // article.span4
            ) // section.section_wrapper
        ) // footer
    } // node
}
