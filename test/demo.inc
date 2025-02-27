  [ Para
      [ Str "This"
      , Space
      , Str "is"
      , Space
      , Str "a"
      , Space
      , Str "demo"
      , Space
      , Str "file"
      , Space
      , Str "for"
      , Space
      , Str "pandoc-crossref."
      , Space
      , Str "With"
      , Space
      , Str "this"
      , Space
      , Str "filter,"
      , Space
      , Str "you"
      , Space
      , Str "can"
      , Space
      , Str "cross-reference"
      , Space
      , Str "figures"
      , Space
      , Str "(see"
      , Space
      , Str "figs.\160\&2-4),"
      , Space
      , Str "display"
      , Space
      , Str "equations"
      , Space
      , Str "(see"
      , Space
      , Str "eq.\160\&1),"
      , Space
      , Str "tables"
      , Space
      , Str "(see"
      , Space
      , Str "tbl.\160\&1)"
      , Space
      , Str "and"
      , Space
      , Str "sections"
      , Space
      , Str "("
      , Str "secs.\160\&1,"
      , Space
      , Str "2,"
      , Space
      , Str "4.1-4.3)"
      ]
  , Para
      [ Str "For"
      , Space
      , Str "immediate"
      , Space
      , Str "example,"
      , Space
      , Str "see"
      , Space
      , Str "fig.\160\&1"
      ]
  , Para
      [ Image
          ( "fig:figure0" , [] , [] )
          [ Str "Figure"
          , Space
          , Str "#"
          , Space
          , Str "1:"
          , Space
          , Str "A"
          , Space
          , Str "figure"
          ]
          ( "img1.jpg" , "fig:" )
      ]
  , Para
      [ Str "There"
      , Space
      , Str "is"
      , Space
      , Str "also"
      , Space
      , Str "support"
      , Space
      , Str "for"
      , Space
      , Str "code"
      , Space
      , Str "blocks,"
      , Space
      , Str "for"
      , Space
      , Str "example,"
      , Space
      , Str "lsts.\160\&1-3"
      ]
  , Para
      [ Str "It\8217s"
      , Space
      , Str "possible"
      , Space
      , Str "to"
      , Space
      , Str "capitalize"
      , Space
      , Str "reference"
      , Space
      , Str "prefixes,"
      , Space
      , Str "like"
      , Space
      , Str "this:"
      , Space
      , Str "Fig.\160\&2."
      ]
  , Para
      [ Str "In"
      , Space
      , Str "case"
      , Space
      , Str "of"
      , Space
      , Str "multiple"
      , Space
      , Str "references,"
      , Space
      , Str "capitalization"
      , Space
      , Str "is"
      , Space
      , Str "determined"
      , Space
      , Str "by"
      , Space
      , Str "first"
      , Space
      , Str "reference."
      , Space
      , Str "Figs.\160\&2,"
      , Space
      , Str "3"
      , Space
      , Str "is"
      , Space
      , Str "capitalized,"
      , Space
      , Str "while"
      , Space
      , Str "figs.\160\&2,"
      , Space
      , Str "3"
      , Space
      , Str "is"
      , Space
      , Str "not."
      ]
  , Para
      [ Str "It"
      , Space
      , Str "is"
      , Space
      , Str "also"
      , Space
      , Str "possible"
      , Space
      , Str "to"
      , Space
      , Str "mix"
      , Space
      , Str "different"
      , Space
      , Str "references,"
      , Space
      , Str "like"
      , Space
      , Str "fig.\160\&2,"
      , Space
      , Str "tbl.\160\&1,"
      , Space
      , Str "lsts.\160\&1,"
      , Space
      , Str "2,"
      , Space
      , Str "figs.\160\&3,"
      , Space
      , Str "4,"
      , Space
      , Str "which"
      , Space
      , Str "will"
      , Space
      , Str "be"
      , Space
      , Str "grouped"
      , Space
      , Str "in"
      , Space
      , Str "order"
      , Space
      , Str "they"
      , Space
      , Str "are"
      , Space
      , Str "specified."
      , Space
      , Str "You"
      , Space
      , Str "can"
      , Space
      , Str "even"
      , Space
      , Str "intermix"
      , Space
      , Str "this"
      , Space
      , Str "with"
      , Space
      , Str "regular"
      , Space
      , Str "citations,"
      , Space
      , Str "although"
      , Space
      , Str "it\8217s"
      , Space
      , Str "not"
      , Space
      , Str "recommended:"
      , Space
      , Str "fig.\160\&2,"
      , Space
      , Str "tbl.\160\&1,"
      , Space
      , Cite
          [ Citation
              { citationId = "unprocessedCitation"
              , citationPrefix = []
              , citationSuffix = []
              , citationMode = NormalCitation
              , citationNoteNum = 11
              , citationHash = 0
              }
          ]
          [ Str "[@unprocessedCitation]" ]
      ]
  , Para
      [ Str "You"
      , Space
      , Str "can"
      , Space
      , Str "also"
      , Space
      , Str "have"
      , Space
      , Str "custom"
      , Space
      , Str "chapter"
      , Space
      , Str "reference"
      , Space
      , Str "labels,"
      , Space
      , Str "like"
      , Space
      , Str "sec.\160AppA.CustLab"
      ]
  , Para
      [ Str "Subfigures"
      , Space
      , Str "are"
      , Space
      , Str "supported,"
      , Space
      , Str "see"
      , Space
      , Str "figs.\160\&5,"
      , Space
      , Str "5"
      , Space
      , Str "(b)"
      ]
  , Header
      1
      ( "sec:sec1" , [] , [] )
      [ Str "Chapter" , Space , Str "1." , Space , Str "Figures" ]
  , Para
      [ Image
          ( "fig:figure1" , [] , [] )
          [ Str "Figure"
          , Space
          , Str "#"
          , Space
          , Str "2:"
          , Space
          , Str "First"
          , Space
          , Str "figure"
          ]
          ( "img1.jpg" , "fig:" )
      ]
  , Para
      [ Image
          ( "fig:figure2" , [] , [] )
          [ Str "Figure"
          , Space
          , Str "#"
          , Space
          , Str "3:"
          , Space
          , Str "Second"
          , Space
          , Str "figure"
          ]
          ( "img2.jpg" , "fig:" )
      ]
  , Para
      [ Image
          ( "fig:figure3" , [] , [] )
          [ Str "Figure"
          , Space
          , Str "#"
          , Space
          , Str "4:"
          , Space
          , Str "Third"
          , Space
          , Str "figure"
          ]
          ( "img3.jpg" , "fig:" )
      ]
  , Para
      [ Image
          ( "" , [] , [] )
          [ Str "Unlabelled" , Space , Str "image" ]
          ( "img1.jpg" , "fig:" )
      ]
  , Div
      ( "fig:subfigures" , [ "subfigures" ] , [] )
      [ Para
          [ Image ( "" , [] , [] ) [ Str "a" ] ( "img1.jpg" , "fig:" )
          ]
      , Para
          [ Image
              ( "fig:subfigureB" , [] , [] )
              [ Str "b" ]
              ( "img1.jpg" , "fig:" )
          ]
      , Para
          [ Str "Figure"
          , Space
          , Str "#"
          , Space
          , Str "5:"
          , Space
          , Str "Subfigures"
          , Space
          , Str "caption."
          , Space
          , Str "a"
          , Space
          , Str "\8212"
          , Space
          , Str "Subfigure"
          , Space
          , Str "a,"
          , Space
          , Str "b"
          , Space
          , Str "\8212"
          , Space
          , Str "Subfigure"
          , Space
          , Str "b"
          ]
      ]
  , Header
      1
      ( "sec:sec2" , [] , [] )
      [ Str "Chapter"
      , Space
      , Str "2."
      , Space
      , Str "Equations"
      ]
  , Para
      [ Str "Display"
      , Space
      , Str "equations"
      , Space
      , Str "are"
      , Space
      , Str "labelled"
      , Space
      , Str "and"
      , Space
      , Str "numbered"
      ]
  , Para
      [ Span
          ( "eq:eqn1" , [] , [] )
          [ Math DisplayMath " P_i(x) = \\sum_i a_i x^i \\qquad{(1)}"
          ]
      ]
  , Para
      [ Str "Since"
      , Space
      , Str "0.1.6.0"
      , Space
      , Str "those"
      , Space
      , Str "can"
      , Space
      , Str "also"
      , Space
      , Str "appear"
      , Space
      , Str "in"
      , Space
      , Str "the"
      , Space
      , Str "middle"
      , Space
      , Str "of"
      , Space
      , Str "paragraph"
      , SoftBreak
      , Span
          ( "eq:quadr" , [] , [] )
          [ Math DisplayMath "a x^2 + b x^2 + c = 0\\qquad{(2)}" ]
      , Space
      , Str "like"
      , Space
      , Str "this."
      ]
  , Header
      1
      ( "sec:chapter-3.-tables" , [] , [] )
      [ Str "Chapter" , Space , Str "3." , Space , Str "Tables" ]
  , Div
      ( "tbl:table1" , [] , [] )
      [ Table
          ( "" , [] , [] )
          (Caption
             Nothing
             [ Plain
                 [ Emph [ Str "Table" , Space , Str "1" ]
                 , Str ":"
                 , Space
                 , Str "Table"
                 , Space
                 , Str "example"
                 ]
             ])
          [ ( AlignLeft , ColWidthDefault )
          , ( AlignLeft , ColWidthDefault )
          ]
          (TableHead
             ( "" , [] , [] )
             [ Row
                 ( "" , [] , [] )
                 [ Cell
                     ( "" , [] , [] )
                     AlignDefault
                     (RowSpan 1)
                     (ColSpan 1)
                     [ Plain [ Str "First" , Space , Str "Header" ] ]
                 , Cell
                     ( "" , [] , [] )
                     AlignDefault
                     (RowSpan 1)
                     (ColSpan 1)
                     [ Plain [ Str "Second" , Space , Str "Header" ] ]
                 ]
             ])
          [ TableBody
              ( "" , [] , [] )
              (RowHeadColumns 0)
              []
              [ Row
                  ( "" , [] , [] )
                  [ Cell
                      ( "" , [] , [] )
                      AlignDefault
                      (RowSpan 1)
                      (ColSpan 1)
                      [ Plain [ Str "Content" , Space , Str "Cell" ] ]
                  , Cell
                      ( "" , [] , [] )
                      AlignDefault
                      (RowSpan 1)
                      (ColSpan 1)
                      [ Plain [ Str "Content" , Space , Str "Cell" ] ]
                  ]
              , Row
                  ( "" , [] , [] )
                  [ Cell
                      ( "" , [] , [] )
                      AlignDefault
                      (RowSpan 1)
                      (ColSpan 1)
                      [ Plain [ Str "Content" , Space , Str "Cell" ] ]
                  , Cell
                      ( "" , [] , [] )
                      AlignDefault
                      (RowSpan 1)
                      (ColSpan 1)
                      [ Plain [ Str "Content" , Space , Str "Cell" ] ]
                  ]
              ]
          ]
          (TableFoot ( "" , [] , [] ) [])
      ]
  , Para
      [ Str "Table"
      , Space
      , Str "without"
      , Space
      , Str "caption:"
      ]
  , Table
      ( "" , [] , [] )
      (Caption Nothing [])
      [ ( AlignLeft , ColWidthDefault )
      , ( AlignLeft , ColWidthDefault )
      ]
      (TableHead
         ( "" , [] , [] )
         [ Row
             ( "" , [] , [] )
             [ Cell
                 ( "" , [] , [] )
                 AlignDefault
                 (RowSpan 1)
                 (ColSpan 1)
                 [ Plain [ Str "First" , Space , Str "Header" ] ]
             , Cell
                 ( "" , [] , [] )
                 AlignDefault
                 (RowSpan 1)
                 (ColSpan 1)
                 [ Plain [ Str "Second" , Space , Str "Header" ] ]
             ]
         ])
      [ TableBody
          ( "" , [] , [] )
          (RowHeadColumns 0)
          []
          [ Row
              ( "" , [] , [] )
              [ Cell
                  ( "" , [] , [] )
                  AlignDefault
                  (RowSpan 1)
                  (ColSpan 1)
                  [ Plain [ Str "Content" , Space , Str "Cell" ] ]
              , Cell
                  ( "" , [] , [] )
                  AlignDefault
                  (RowSpan 1)
                  (ColSpan 1)
                  [ Plain [ Str "Content" , Space , Str "Cell" ] ]
              ]
          , Row
              ( "" , [] , [] )
              [ Cell
                  ( "" , [] , [] )
                  AlignDefault
                  (RowSpan 1)
                  (ColSpan 1)
                  [ Plain [ Str "Content" , Space , Str "Cell" ] ]
              , Cell
                  ( "" , [] , [] )
                  AlignDefault
                  (RowSpan 1)
                  (ColSpan 1)
                  [ Plain [ Str "Content" , Space , Str "Cell" ] ]
              ]
          ]
      ]
      (TableFoot ( "" , [] , [] ) [])
  , Header
      1
      ( "sec:chapter-4.-code-blocks" , [] , [] )
      [ Str "Chapter"
      , Space
      , Str "4."
      , Space
      , Str "Code"
      , Space
      , Str "blocks"
      ]
  , Para
      [ Str "There"
      , Space
      , Str "are"
      , Space
      , Str "a"
      , Space
      , Str "couple"
      , Space
      , Str "options"
      , Space
      , Str "for"
      , Space
      , Str "code"
      , Space
      , Str "block"
      , Space
      , Str "labels."
      , Space
      , Str "Those"
      , Space
      , Str "work"
      , Space
      , Str "only"
      , Space
      , Str "if"
      , Space
      , Str "code"
      , Space
      , Str "block"
      , Space
      , Str "id"
      , Space
      , Str "starts"
      , Space
      , Str "with"
      , Space
      , Code ( "" , [] , [] ) "lst:"
      , Str ","
      , Space
      , Str "e.g.\160"
      , Code ( "" , [] , [] ) "{#lst:label}"
      ]
  , Header
      2
      ( "sec:caption-attr" , [] , [] )
      [ Code ( "" , [] , [] ) "caption"
      , Space
      , Str "attribute"
      ]
  , Para
      [ Code ( "" , [] , [] ) "caption"
      , Space
      , Str "attribute"
      , Space
      , Str "will"
      , Space
      , Str "be"
      , Space
      , Str "treated"
      , Space
      , Str "as"
      , Space
      , Str "code"
      , Space
      , Str "block"
      , Space
      , Str "caption."
      , Space
      , Str "If"
      , Space
      , Str "code"
      , Space
      , Str "block"
      , Space
      , Str "has"
      , Space
      , Str "both"
      , Space
      , Str "id"
      , Space
      , Str "and"
      , Space
      , Code ( "" , [] , [] ) "caption"
      , Space
      , Str "attributes,"
      , Space
      , Str "it"
      , Space
      , Str "will"
      , Space
      , Str "be"
      , Space
      , Str "treated"
      , Space
      , Str "as"
      , Space
      , Str "numbered"
      , Space
      , Str "code"
      , Space
      , Str "block."
      ]
  , Div
      ( "lst:captionAttr" , [ "listing" , "haskell" ] , [] )
      [ Para
          [ Str "Listing"
          , Space
          , Str "1:"
          , Space
          , Str "Listing"
          , Space
          , Str "caption"
          ]
      , CodeBlock
          ( "" , [ "haskell" ] , [] )
          "main :: IO ()\nmain = putStrLn \"Hello World!\""
      ]
  , RawBlock (Format "tex") "\\pagebreak"
  , Header
      2
      ( "sec:table-capts" , [] , [] )
      [ Str "Table-style" , Space , Str "captions" ]
  , Para
      [ Str "Enabled"
      , Space
      , Str "with"
      , Space
      , Code ( "" , [] , [] ) "codeBlockCaptions"
      , Space
      , Str "metadata"
      , Space
      , Str "option."
      , Space
      , Str "If"
      , Space
      , Str "code"
      , Space
      , Str "block"
      , Space
      , Str "is"
      , Space
      , Str "immediately"
      , SoftBreak
      , Str "adjacent"
      , Space
      , Str "to"
      , Space
      , Str "paragraph,"
      , Space
      , Str "starting"
      , Space
      , Str "with"
      , Space
      , Code ( "" , [] , [] ) "Listing:"
      , Space
      , Str "or"
      , Space
      , Code ( "" , [] , [] ) ":"
      , Str ","
      , Space
      , Str "said"
      , Space
      , Str "paragraph"
      , Space
      , Str "will"
      , Space
      , Str "be"
      , SoftBreak
      , Str "treated"
      , Space
      , Str "as"
      , Space
      , Str "code"
      , Space
      , Str "block"
      , Space
      , Str "caption."
      ]
  , Div
      ( "lst:tableCaption" , [ "listing" , "haskell" ] , [] )
      [ Para
          [ Str "Listing"
          , Space
          , Str "2:"
          , Space
          , Str "Listing"
          , Space
          , Str "caption"
          ]
      , CodeBlock
          ( "" , [ "haskell" ] , [] )
          "main :: IO ()\nmain = putStrLn \"Hello World!\""
      ]
  , Header
      2
      ( "sec:wrapping-div" , [] , [] )
      [ Str "Wrapping" , Space , Str "div" ]
  , Para
      [ Str "Wrapping"
      , Space
      , Str "code"
      , Space
      , Str "block"
      , Space
      , Str "without"
      , Space
      , Str "label"
      , Space
      , Str "in"
      , Space
      , Str "a"
      , Space
      , Str "div"
      , Space
      , Str "with"
      , Space
      , Str "id"
      , Space
      , Code ( "" , [] , [] ) "lst:..."
      , Space
      , Str "and"
      , Space
      , Str "class,"
      , Space
      , Str "starting"
      , Space
      , Str "with"
      , Space
      , Code ( "" , [] , [] ) "listing"
      , Str ","
      , Space
      , Str "and"
      , Space
      , Str "adding"
      , Space
      , Str "paragraph"
      , Space
      , Str "before"
      , Space
      , Str "code"
      , Space
      , Str "block,"
      , Space
      , Str "but"
      , Space
      , Str "inside"
      , Space
      , Str "div,"
      , Space
      , Str "will"
      , Space
      , Str "treat"
      , Space
      , Str "said"
      , Space
      , Str "paragraph"
      , Space
      , Str "as"
      , Space
      , Str "code"
      , Space
      , Str "block"
      , Space
      , Str "caption."
      ]
  , Div
      ( "lst:wrappingDiv" , [ "listing" , "haskell" ] , [] )
      [ Para
          [ Str "Listing"
          , Space
          , Str "3:"
          , Space
          , Str "Listing"
          , Space
          , Str "caption"
          ]
      , CodeBlock
          ( "" , [ "haskell" ] , [] )
          "main :: IO ()\nmain = putStrLn \"Hello World!\""
      ]
  , Header
      1
      ( "sec:unnumbered-chapter." , [ "unnumbered" ] , [] )
      [ Str "Unnumbered" , Space , Str "chapter." ]
  , Para
      [ Str "This"
      , Space
      , Str "chapter"
      , Space
      , Str "doesn\8217t"
      , Space
      , Str "change"
      , Space
      , Str "chapter"
      , Space
      , Str "prefix"
      , Space
      , Str "of"
      , Space
      , Str "referenced"
      , Space
      , Str "elements,"
      , Space
      , Str "instead"
      , Space
      , Str "keeping"
      , Space
      , Str "number"
      , Space
      , Str "of"
      , Space
      , Str "previous"
      , Space
      , Str "chapter,"
      , Space
      , Str "e.g."
      , SoftBreak
      , Span
          ( "eq:eqn2" , [] , [] )
          [ Math
              DisplayMath
              " S(x) = \\int_{x_1}^{x_2} a x+b \\  \\mathrm{d}x \\qquad{(3)}"
          ]
      ]
  , Header
      1
      ( "sec:chapter-5.-reference-lists" , [] , [] )
      [ Str "Chapter"
      , Space
      , Str "5."
      , Space
      , Str "Reference"
      , Space
      , Str "lists"
      ]
  , Para
      [ Str "It\8217s"
      , Space
      , Str "also"
      , Space
      , Str "possible"
      , Space
      , Str "to"
      , Space
      , Str "show"
      , Space
      , Str "lists"
      , Space
      , Str "of"
      , Space
      , Str "figures"
      , Space
      , Str "and"
      , Space
      , Str "tables,"
      , Space
      , Str "like"
      , Space
      , Str "this:"
      ]
  , Header
      2
      ( "list-of-figures" , [] , [] )
      [ Str "List" , Space , Str "of" , Space , Str "Figures" ]
  , OrderedList
      ( 1 , DefaultStyle , DefaultDelim )
      [ [ Plain [ Str "A" , Space , Str "figure" ] ]
      , [ Plain [ Str "First" , Space , Str "figure" ] ]
      , [ Plain [ Str "Second" , Space , Str "figure" ] ]
      , [ Plain [ Str "Third" , Space , Str "figure" ] ]
      , [ Plain [ Str "Subfigure" , Space , Str "a" ] ]
      , [ Plain [ Str "Subfigure" , Space , Str "b" ] ]
      , [ Plain [ Str "Subfigures" , Space , Str "caption" ] ]
      ]
  , Header
      2
      ( "list-of-tables" , [] , [] )
      [ Str "List" , Space , Str "of" , Space , Str "Tables" ]
  , OrderedList
      ( 1 , DefaultStyle , DefaultDelim )
      [ [ Plain [ Str "Table" , Space , Str "example" ] ] ]
  , Header
      1
      ( "" , [] , [] )
      [ Str "List" , Space , Str "of" , Space , Str "Listings" ]
  , OrderedList
      ( 1 , DefaultStyle , DefaultDelim )
      [ [ Plain [ Str "Listing" , Space , Str "caption" ] ]
      , [ Plain [ Str "Listing" , Space , Str "caption" ] ]
      , [ Plain [ Str "Listing" , Space , Str "caption" ] ]
      ]
  , Header
      1
      ( "sec:appendix-a.-custom-labels"
      , []
      , [ ( "label" , "AppA" ) ]
      )
      [ Str "Appendix"
      , Space
      , Str "A."
      , Space
      , Str "Custom"
      , Space
      , Str "labels"
      ]
  , Header
      2
      ( "sec:custlabs" , [] , [ ( "label" , "CustLab" ) ] )
      [ Str "This"
      , Space
      , Str "section"
      , Space
      , Str "will"
      , Space
      , Str "have"
      , Space
      , Str "custom"
      , Space
      , Str "label"
      ]
  ]
