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
            ]
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
                            .h4("Pathfinder &amp; Starfinder Society games in San Francisco Bay Area"),
                            .a(.class("base_button"), .href("/events/"), .text("Find a Game"))
                        )
                    ),
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

                        <script type="text/javascript">
                        $(window).scroll(function() {
                          var scroll = $(window).scrollTop();
                          if (scroll >= 100) {
                              $("#fixed_nav").addClass("shrink-nav");
                          } else {
                              $("#fixedNav").removeClass("shrink-nav");
                          }
                        });
                        </script>
                    """)
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .header(for: context, selectedSection: section.id),
                .wrapper(
                    .section(.class("section_wrapper"),
                             .article(.class("span12 post"), .contentBody(section.body))
                    ),
                    .itemList(for: section.items, on: context.site)
                ),
                .footer(for: context.site)
            )
        )
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
                        .article(
                            .class("span12 post"),
                            (
                                .contentBody(item.body)
                            ),
                            .hr(),
                            .p("Tagged with: "),
                            .tagList(for: item, on: context.site)
                        )
                    )
                ),
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
            )
        )
    }

    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1("Browse all tags"),
                    .ul(
                        .class("all-tags"),
                        .forEach(page.tags.sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .footer(for: context.site)
            )
        )
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
                            ),
                            .a(
                                .href(context.site.tagListPath)
                            ),
                            .itemList(
                                for: context.items(
                                    taggedWith: page.tag,
                                    sortedBy: \.date,
                                    order: .descending
                                ),
                                on: context.site
                            )
                        )
                    )
                ),
                .footer(for: context.site)
            )
        )
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
        )
    }

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
                        )
                    ) // a.itemListLink
                ) // article.span6
            }
        )
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .p(.class("tag-list"),  .forEach(item.tags) { tag in
            .a(
                .href(site.path(for: tag)),
                .text(tag.string)
            )
        })
    }

    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("&copy; 2020 San Francisco Organized Play")
            ),
            .p(
                .class("footer-legal"),
                .text("This promotional notice uses trademarks and/or copyrights owned by Paizo Publishing, LLC, which are under Paizo's community use policy. We are expressly prohibited from charging you to use or access this content. This promotional notice is not published, endorsed, or specifically approved by Paizo Publishing. For more information about Paizo's Community Use Policy, please visit paizo.com/ paizo/ about/ communityuse. For more information about Paizo Publishing and Paizo Products, please visit paizo.com.")
            )
        )
    }
}
