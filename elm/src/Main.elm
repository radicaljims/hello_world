import Html exposing (div, text)

-- 1 - Everything in Elm has a type, but
-- nothing needs a type annotation.
-- main : Html.Html a
main =
    -- 2 - HTML is represented inside of ELm via the
    -- 'Html' library. This library provides a series of
    -- composable functions for generating HTML.
    -- Elm's immutability couples nicely with the concept
    -- of a virtual DOM. In fact Elm has pretty much the fastest
    -- HTML rendering out there!
    -- http://elm-lang.org/blog/blazing-fast-html-round-two
    div
      -- this would be a list of style attributes, if we had any
      []
      -- this is a list of child nodes
      [text "Hello, world!"]

-- When run through the Elm Reactor, the main function above
-- yields approximately the following html:
-- <html>
--   <head>
--   <meta charset="UTF-8">
--   <title>~/src/Main.elm</title>
--   <style type="text/css">
--     @import url(http://fonts.googleapis.com/css?family=Source+Sans+Pro);
--     html, head, body {
--       margin: 0;
--       height: 100%;
--     }
--   </style>
--   </head>
--   <body>
--     <script src="chrome-extension://hhojmcideegachlhfilpfhgknjm/web_accessible_resources/index.jsg"></script>
--     <div>Hello, world!</div>
--   </body>
-- </html>
