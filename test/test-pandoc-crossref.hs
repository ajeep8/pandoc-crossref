{-
pandoc-crossref is a pandoc filter for numbering figures,
equations, tables and cross-references to them.
Copyright (C) 2015  Nikolay Yakimov <root@livid.pp.ru>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-}

{-# LANGUAGE FlexibleContexts, CPP, OverloadedStrings, RankNTypes, ScopedTypeVariables #-}
import Test.Hspec
import Text.Pandoc hiding (getDataFileName)
import Text.Pandoc.Builder
import Control.Monad.State
import Data.List
import Control.Arrow
import qualified Data.Map as M
import qualified Data.Text as T
import qualified Data.Default as Df

import Text.Pandoc.CrossRef
import Text.Pandoc.CrossRef.Util.Options
import Text.Pandoc.CrossRef.Util.Util
import Text.Pandoc.CrossRef.References.Types
import Lens.Micro
import qualified Text.Pandoc.CrossRef.References.Blocks as References.Blocks
import qualified Text.Pandoc.CrossRef.References.Refs as References.Refs
import qualified Text.Pandoc.CrossRef.References.List as References.List
import qualified Text.Pandoc.CrossRef.Util.Template as Util.Template
import qualified Text.Pandoc.CrossRef.Util.CodeBlockCaptions as Util.CodeBlockCaptions

import qualified Native
import Paths_pandoc_crossref

import Prelude

main :: IO ()
main = hspec $ do
    describe "References.Blocks.replaceInlines" $ do
      it "Labels equations" $
        testAll (equation' "a^2+b^2=c^2" "equation")
        (spanWith ("eq:equation", [], []) (equation' "a^2+b^2=c^2\\qquad{(1)}" ""),
          eqnRefs =: M.fromList $ refRec'' "eq:equation" 1)
      it "Labels equations in the middle of text" $
        testAll (
                text "This is an equation: "
             <> equation' "a^2+b^2=c^2" "equation"
             <> text " it should be labeled")
        (
           text "This is an equation: "
        <> spanWith ("eq:equation", [], []) (equation' "a^2+b^2=c^2\\qquad{(1)}" "")
        <> text " it should be labeled",
          eqnRefs =: M.fromList $ refRec'' "eq:equation" 1)
      it "Labels equations in the beginning of text" $
        testAll (
                equation' "a^2+b^2=c^2" "equation"
             <> text " it should be labeled")
        (
           spanWith ("eq:equation", [], []) (equation' "a^2+b^2=c^2\\qquad{(1)}" "")
        <> text " it should be labeled",
          eqnRefs =: M.fromList $ refRec'' "eq:equation" 1)
      it "Labels equations in the end of text" $
        testAll (
                text "This is an equation: "
             <> equation' "a^2+b^2=c^2" "equation")
        (
           text "This is an equation: "
        <> spanWith ("eq:equation", [], []) (equation' "a^2+b^2=c^2\\qquad{(1)}" ""),
          eqnRefs =: M.fromList $ refRec'' "eq:equation" 1)

    -- TODO:
    -- describe "References.Blocks.spanInlines"
    -- describe "References.Blocks.divBlocks"

    describe "References.Blocks.replaceBlocks" $ do
      it "Labels images" $
        testAll (figure "test.jpg" "" "Test figure" "figure")
        (figure "test.jpg" "" "Figure 1: Test figure" "figure",
          imgRefs =: M.fromList $ refRec' "fig:figure" 1 "Test figure")
      it "Labels subfigures" $
        testAll (
          divWith ("fig:subfigure",[],[]) (
            para (figure' "fig:" "test1.jpg" "" "Test figure 1" "figure1")
          <>para (figure' "fig:" "test2.jpg" "" "Test figure 2" "figure2")
          <>para (text "figure caption")
            ) <>
          divWith ("fig:subfigure2",[],[]) (
            para (figure' "fig:" "test21.jpg" "" "Test figure 21" "figure21")
          <>para (figure' "fig:" "test22.jpg" "" "Test figure 22" "figure22")
          <>para (text "figure caption 2")
            )
          )
        (
          divWith ("fig:subfigure",["subfigures"],[]) (
               para (figure' "fig:" "test1.jpg" "" "a" "figure1")
            <> para (figure' "fig:" "test2.jpg" "" "b" "figure2")
            <> para (text "Figure 1: figure caption. a — Test figure 1, b — Test figure 2")
            ) <>
          divWith ("fig:subfigure2",["subfigures"],[]) (
               para (figure' "fig:" "test21.jpg" "" "a" "figure21")
            <> para (figure' "fig:" "test22.jpg" "" "b" "figure22")
            <> para (text "Figure 2: figure caption 2. a — Test figure 21, b — Test figure 22")
            )
        , imgRefs =: M.fromList [("fig:figure1",RefRec {
                                            refIndex = [(1,Nothing)],
                                            refTitle = [Str "Test",Space,Str "figure",Space,Str "1"],
                                            refSubfigure = Just [(1, Just "a")]}),
                                    ("fig:figure2",RefRec {
                                            refIndex = [(1,Nothing)],
                                            refTitle = [Str "Test",Space,Str "figure",Space,Str "2"],
                                            refSubfigure = Just [(2, Just "b")]}),
                                    ("fig:subfigure",RefRec {
                                            refIndex = [(1,Nothing)],
                                            refTitle = [Str "figure",Space,Str "caption"],
                                            refSubfigure = Nothing}),
                                    ("fig:figure21",RefRec {
                                            refIndex = [(2,Nothing)],
                                            refTitle = [Str "Test",Space,Str "figure",Space,Str "21"],
                                            refSubfigure = Just [(1, Just "a")]}),
                                    ("fig:figure22",RefRec {
                                            refIndex = [(2,Nothing)],
                                            refTitle = [Str "Test",Space,Str "figure",Space,Str "22"],
                                            refSubfigure = Just [(2, Just "b")]}),
                                    ("fig:subfigure2",RefRec {
                                            refIndex = [(2,Nothing)],
                                            refTitle = [Str "figure",Space,Str "caption",Space,Str "2"],
                                            refSubfigure = Nothing})
                                   ]
            )
      it "Labels equations" $
        testAll (equation "a^2+b^2=c^2" "equation")
        (para $ spanWith ("eq:equation", [], []) (equation' "a^2+b^2=c^2\\qquad{(1)}" ""),
          eqnRefs =: M.fromList $ refRec'' "eq:equation" 1)
      it "Labels equations in the middle of text" $
        testAll (para $
                text "This is an equation: "
             <> equation' "a^2+b^2=c^2" "equation"
             <> text " it should be labeled")
        (para $
           text "This is an equation: "
        <> spanWith ("eq:equation", [], []) (equation' "a^2+b^2=c^2\\qquad{(1)}" "")
        <> text " it should be labeled",
          eqnRefs =: M.fromList $ refRec'' "eq:equation" 1)
      it "Labels equations in the beginning of text" $
        testAll (para $
                equation' "a^2+b^2=c^2" "equation"
             <> text " it should be labeled")
        (para $
           spanWith ("eq:equation", [], []) (equation' "a^2+b^2=c^2\\qquad{(1)}" "")
        <> text " it should be labeled",
          eqnRefs =: M.fromList $ refRec'' "eq:equation" 1)
      it "Labels equations in the end of text" $
        testAll (para $
                text "This is an equation: "
             <> equation' "a^2+b^2=c^2" "equation")
        (para $
           text "This is an equation: "
        <> spanWith ("eq:equation", [], []) (equation' "a^2+b^2=c^2\\qquad{(1)}" ""),
          eqnRefs =: M.fromList $ refRec'' "eq:equation" 1)
      it "Labels tables" $
        testAll (table' "Test table" "table")
        (divWith ("tbl:table", [], []) $ table' "Table 1: Test table" "",
          tblRefs =: M.fromList $ refRec' "tbl:table" 1 "Test table")
      it "Labels code blocks" $
        testAll (codeBlock' "Test code block" "codeblock")
        (codeBlockDiv "Listing 1: Test code block" "codeblock",
          lstRefs =: M.fromList $ refRec' "lst:codeblock" 1 "Test code block")
      it "Labels code block divs" $
        testAll (codeBlockDiv "Test code block" "codeblock")
        (codeBlockDiv "Listing 1: Test code block" "codeblock",
          lstRefs =: M.fromList $ refRec' "lst:codeblock" 1 "Test code block")
      it "Labels sections divs" $
        testAll (section "Section Header" 1 "section")
        (section "Section Header" 1 "section",
          secRefs .~ M.fromList (refRec' "sec:section" 1 "Section Header")
          $ curChap =: [(1,Nothing)])

    describe "References.Refs.replaceRefs" $ do
      it "References one image" $
        testRefs' "fig:" [1] [4] imgRefs "fig.\160\&4"
      it "References multiple images" $
        testRefs' "fig:" [1..3] [4..6] imgRefs "figs.\160\&4-6"
      it "References one equation" $
        testRefs' "eq:" [1] [4] eqnRefs "eq.\160\&4"
      it "References multiple equations" $
        testRefs' "eq:" [1..3] [4..6] eqnRefs "eqns.\160\&4-6"
      it "References one table" $
        testRefs' "tbl:" [1] [4] tblRefs "tbl.\160\&4"
      it "References multiple tables" $
        testRefs' "tbl:" [1..3] [4..6] tblRefs "tbls.\160\&4-6"
      it "References one listing" $
        testRefs' "lst:" [1] [4] lstRefs "lst.\160\&4"
      it "References multiple listings" $
        testRefs' "lst:" [1..3] [4..6] lstRefs "lsts.\160\&4-6"
      it "References one section" $
        testRefs' "sec:" [1] [4] secRefs "sec.\160\&4"
      it "References multiple sections" $
        testRefs' "sec:" [1..3] [4..6] secRefs "secs.\160\&4-6"
      it "Separates references to different chapter items by a comma" $
        testRefs'' "lst:" [1..6] (zip [1,1..] [4..6] <> zip [2,2..] [7..9]) lstRefs "lsts.\160\&1.4-1.6, 2.7-2.9"

    describe "References.Refs.replaceRefs capitalization" $ do
      it "References one image" $
        testRefs' "Fig:" [1] [4] imgRefs "Fig.\160\&4"
      it "References multiple images" $
        testRefs' "Fig:" [1..3] [4..6] imgRefs "Figs.\160\&4-6"
      it "References one equation" $
        testRefs' "Eq:" [1] [4] eqnRefs "Eq.\160\&4"
      it "References multiple equations" $
        testRefs' "Eq:" [1..3] [4..6] eqnRefs "Eqns.\160\&4-6"
      it "References one table" $
        testRefs' "Tbl:" [1] [4] tblRefs "Tbl.\160\&4"
      it "References multiple tables" $
        testRefs' "Tbl:" [1..3] [4..6] tblRefs "Tbls.\160\&4-6"
      it "References one listing" $
        testRefs' "Lst:" [1] [4] lstRefs "Lst.\160\&4"
      it "References multiple listings" $
        testRefs' "Lst:" [1..3] [4..6] lstRefs "Lsts.\160\&4-6"
      it "References one listing" $
        testRefs' "Sec:" [1] [4] secRefs "Sec.\160\&4"
      it "References multiple listings" $
        testRefs' "Sec:" [1..3] [4..6] secRefs "Secs.\160\&4-6"

    describe "References.List.listOf" $ do
      it "Generates list of tables" $
        testList (rawBlock "latex" "\\listoftables")
                 (tblRefs =: M.fromList $ refRec' "tbl:1" 4 "4" <> refRec' "tbl:2" 5 "5" <> refRec' "tbl:3" 6 "6")
                 (header 1 (text "List of Tables") <> orderedList ((plain . str . T.pack . show) `map` [4..6 :: Int]))
      it "Generates list of figures" $
        testList (rawBlock "latex" "\\listoffigures")
                 (imgRefs =: M.fromList $ refRec' "fig:1" 4 "4" <> refRec' "fig:2" 5 "5" <> refRec' "fig:3" 6 "6")
                 (header 1 (text "List of Figures") <> orderedList ((plain . str . T.pack . show) `map` [4..6 :: Int]))

    describe "Util.CodeBlockCaptions" $
      it "Transforms table-style codeBlock captions to codeblock divs" $ do
        let t x = testCBCaptions x (codeBlockDiv' "Code Block" "cb")
        t (codeBlockForTable "cb" <> paraText ": Code Block")
        t (codeBlockForTable "cb" <> paraText "Listing: Code Block")
        t (paraText ": Code Block" <> codeBlockForTable "cb")
        t (paraText "Listing: Code Block" <> codeBlockForTable "cb")

    describe "Util.Template" $
      it "Applies templates" $
        let (template :: Util.Template.Template)=Util.Template.makeTemplate defaultMeta (toList $ displayMath "figureTitle" <> displayMath "i" <> displayMath "t")
        in Util.Template.applyTemplate [Str "1"] [Str "title"] template `shouldBe`
           toList (str "Figure" <> str "1" <> str "title")

    describe "Citation groups shouldn't be separated (#22 regression test)" $ do
      it "Should not separate citation groups" $ do
        let cits = para $ citeGen "" [1..3]
        testRefs cits def cits

      it "Should not separate citation groups with unknown prefix" $ do
        let cits = para $ citeGen "unk:" [1..3]
        testRefs cits def cits

      it "Should not separate citation groups with different unknown prefixes" $ do
        let cits = para $ cite (mconcat $ map (cit . uncurry (<>) . second (T.pack . show)) l) $ text $
              "[" <> T.intercalate "; " (map (("@" <>) . uncurry (<>) . second (T.pack . show)) l) <> "]"
            l = zip ["unk1:", "unk2:"] [1,2::Int]
        testRefs cits def cits

#ifdef FLAKY
    describe "Test files" $ do

      it "demo.md matches demo.native" $ do
        demomd <- readFile =<< getDataFileName "docs/demo/demo.md"
        Pandoc m b <- handleError $ runPure $ readMarkdown def {readerExtensions = pandocExtensions} $ T.pack demomd
        runCrossRef m Nothing crossRefBlocks b `shouldBe` Native.demo

      it "demo.md with chapters matches demo-chapters.native" $ do
        demomd <- readFile =<< getDataFileName "docs/demo/demo.md"
        Pandoc m b <- handleError $ runPure $ readMarkdown def {readerExtensions = pandocExtensions} $ T.pack demomd
        let m' = setMeta "chapters" True m
        runCrossRef m' Nothing crossRefBlocks b `shouldBe` Native.demochapters
#endif

    describe "LaTeX" $ do
      let test = test' nullMeta
          infixr 5 `test`
          test' m i o = getLatex m i `shouldBe` o
          getLatex m i = either (fail . show) T.unpack (runPure $ writeLaTeX def (Pandoc m $ runCrossRef m (Just $ Format "latex") crossRefBlocks (toList i)))

      describe "Labels" $ do

        it "Section labels" $
          headerWith ("sec:section_label1", [], []) 1 (text "Section")
            <> para (citeGen "sec:section_label" [1])
            `test` "\\hypertarget{sec:section_label1}{%\n\\section{Section}\\label{sec:section_label1}}\n\nsec.~\\ref{sec:section_label1}"

        it "Image labels" $
          figure "img.png" "" "Title" "figure_label1"
            <> para (citeGen "fig:figure_label" [1])
            `test` "\\begin{figure}\n\\hypertarget{fig:figure_label1}{%\n\\centering\n\\includegraphics{img.png}\n\\caption{Title}\\label{fig:figure_label1}\n}\n\\end{figure}\n\nfig.~\\ref{fig:figure_label1}"

        it "Eqn labels" $
          equation "x^2" "some_equation1"
            <> para (citeGen "eq:some_equation" [1])
            `test` "\\begin{equation}\\protect\\hypertarget{eq:some_equation1}{}{x^2}\\label{eq:some_equation1}\\end{equation}\n\neq.~\\ref{eq:some_equation1}"

#ifdef FLAKY
        it "Tbl labels" $
          table' "A table" "some_table1"
            <> para (citeGen "tbl:some_table" [1])
            `test` "\\hypertarget{tbl:some_table1}{}\n\\begin{longtable}[]{@{}@{}}\n\\caption{\\label{tbl:some_table1}A table}\\tabularnewline\n\\toprule()\n\\endhead\n \\\\\n\\bottomrule()\n\\end{longtable}\n\ntbl.~\\ref{tbl:some_table1}"
#endif

        it "Code block labels" $ do
          codeBlock' "A code block" "some_codeblock1"
            <> para (citeGen "lst:some_codeblock" [1])
            `test` "\\begin{codelisting}\n\n\\caption{A code block}\n\n\\hypertarget{lst:some_codeblock1}{%\n\\label{lst:some_codeblock1}}%\n\\begin{Shaded}\n\\begin{Highlighting}[]\n\\OtherTok{main ::} \\DataTypeTok{IO}\\NormalTok{ ()}\n\\end{Highlighting}\n\\end{Shaded}\n\n\\end{codelisting}\n\nlst.~\\ref{lst:some_codeblock1}"
          codeBlock' "A code block with under_score" "some_codeblock1"
            <> para (citeGen "lst:some_codeblock" [1])
            `test` "\\begin{codelisting}\n\n\\caption{A code block with under\\_score}\n\n\\hypertarget{lst:some_codeblock1}{%\n\\label{lst:some_codeblock1}}%\n\\begin{Shaded}\n\\begin{Highlighting}[]\n\\OtherTok{main ::} \\DataTypeTok{IO}\\NormalTok{ ()}\n\\end{Highlighting}\n\\end{Shaded}\n\n\\end{codelisting}\n\nlst.~\\ref{lst:some_codeblock1}"
          let test1 = test' $ setMeta "codeBlockCaptions" True nullMeta
              infixr 5 `test1`
          codeBlockForTable "some_codeblock1" <> paraText ": A code block"
            <> para (citeGen "lst:some_codeblock" [1])
            `test1` "\\begin{codelisting}\n\n\\caption{A code block}\n\n\\hypertarget{lst:some_codeblock1}{%\n\\label{lst:some_codeblock1}}%\n\\begin{Shaded}\n\\begin{Highlighting}[]\n\\OtherTok{main ::} \\DataTypeTok{IO}\\NormalTok{ ()}\n\\end{Highlighting}\n\\end{Shaded}\n\n\\end{codelisting}\n\nlst.~\\ref{lst:some_codeblock1}"

citeGen :: T.Text -> [Int] -> Inlines
citeGen p l = cite (mconcat $ map (cit . (p<>) . T.pack . show) l) $ text $
  "[" <> T.intercalate "; " (map (("@"<>) . (p<>) . T.pack . show) l) <> "]"

refGen :: T.Text -> [Int] -> [Int] -> M.Map T.Text RefRec
refGen p l1 l2 = M.fromList $ mconcat $ zipWith refRec'' (((uncapitalizeFirst p<>) . T.pack . show) `map` l1) l2

refGen' :: T.Text -> [Int] -> [(Int, Int)] -> M.Map T.Text RefRec
refGen' p l1 l2 = M.fromList $ mconcat $ zipWith refRec''' (((uncapitalizeFirst p<>) . T.pack . show) `map` l1) l2

refRec' :: T.Text -> Int -> T.Text -> [(T.Text, RefRec)]
refRec' ref i tit = [(ref, RefRec{refIndex=[(i,Nothing)],refTitle=toList $ text tit,refSubfigure=Nothing})]

refRec'' :: T.Text -> Int -> [(T.Text, RefRec)]
refRec'' ref i = refRec' ref i ""

refRec''' :: T.Text -> (Int, Int) -> [(T.Text, RefRec)]
refRec''' ref (c,i) = [(ref, RefRec{refIndex=[(c,Nothing), (i,Nothing)],refTitle=toList $ text "",refSubfigure=Nothing})]

testRefs' :: T.Text -> [Int] -> [Int] -> Lens' References (M.Map T.Text RefRec) -> T.Text -> Expectation
testRefs' p l1 l2 prop res = testRefs (para $ citeGen p l1) (set prop (refGen p l1 l2) def) (para $ text res)

testRefs'' :: T.Text -> [Int] -> [(Int, Int)] -> Lens' References (M.Map T.Text RefRec) -> T.Text -> Expectation
testRefs'' p l1 l2 prop res = testRefs (para $ citeGen p l1) (set prop (refGen' p l1 l2) def) (para $ text res)

testAll :: (Eq a, Data a, Show a) => Many a -> (Many a, References) -> Expectation
testAll = testState f def
  where f = References.Blocks.replaceAll defaultOptions

testState :: (Eq s, Eq a1, Show s, Show a1, Df.Default s) =>
               ([a] -> State s [a1]) -> s -> Many a -> (Many a1, s) -> Expectation
testState f init' arg res = runState (f $ toList arg) init' `shouldBe` first toList res

testRefs :: Blocks -> References -> Blocks -> Expectation
testRefs bs st rbs = testState (bottomUpM (References.Refs.replaceRefs defaultOptions)) st bs (rbs, st)

testCBCaptions :: Blocks -> Blocks -> Expectation
testCBCaptions bs res = runState (bottomUpM (Util.CodeBlockCaptions.mkCodeBlockCaptions defaultOptions{Text.Pandoc.CrossRef.Util.Options.codeBlockCaptions=True}) (toList bs)) def `shouldBe` (toList res,def)

testList :: Blocks -> References -> Blocks -> Expectation
testList bs st res = runState (bottomUpM (References.List.listOf defaultOptions) (toList bs)) st `shouldBe` (toList res,st)

figure :: T.Text -> T.Text -> T.Text -> T.Text -> Blocks
figure = (((para .) .) .) . figure' "fig:"

figure' :: T.Text -> T.Text -> T.Text -> T.Text -> T.Text -> Inlines
figure' p src title alt ref = imageWith ("fig:" <> ref, [], []) src (p <> title) (text alt)

section :: T.Text -> Int -> T.Text -> Blocks
section text' level label = headerWith ("sec:" <> label,[],[]) level (text text')

equation :: T.Text -> T.Text -> Blocks
equation = (para .) . equation'

equation' :: T.Text -> T.Text -> Inlines
equation' eq ref = displayMath eq <> ref' "eq" ref

table' :: T.Text -> T.Text -> Blocks
table' title ref = table (simpleCaption . plain $ text title <> ref' "tbl" ref) []
   (TableHead nullAttr [Row nullAttr $ map (Cell nullAttr AlignDefault (RowSpan 0) (ColSpan 0) . toList) [para $ str "H1", para $ str "H2"]])
  [TableBody nullAttr (RowHeadColumns 0) [] [Row nullAttr $ map (Cell nullAttr AlignDefault (RowSpan 0) (ColSpan 0) . toList) [para $ str "C1", para $ str "C2"]]]
  (TableFoot nullAttr [])

codeBlock' :: T.Text -> T.Text -> Blocks
codeBlock' title ref = codeBlockWith
  ("lst:"<>ref,["haskell"],[("caption",title)]) "main :: IO ()"

codeBlockForTable :: T.Text -> Blocks
codeBlockForTable ref = codeBlockWith
     ("lst:"<>ref,["haskell"],[]) "main :: IO ()"

paraText :: T.Text -> Blocks
paraText s = para $ text s

codeBlockDiv :: T.Text -> T.Text -> Blocks
codeBlockDiv title ref = divWith ("lst:"<>ref, ["listing","haskell"],[]) $
  para (text title) <>
  codeBlockWith
    ("",["haskell"],[]) "main :: IO ()"

codeBlockDiv' :: T.Text -> T.Text -> Blocks
codeBlockDiv' title ref = divWith ("lst:"<>ref, ["listing"],[]) $
  para (text title) <>
  codeBlockWith
    ("",["haskell"],[]) "main :: IO ()"

ref' :: T.Text -> T.Text -> Inlines
ref' p n | T.null n  = mempty
         | otherwise = space <> str ("{#"<>p<>":"<>n<>"}")

defaultOptions :: Options
defaultOptions = getOptions defaultMeta Nothing

defCit :: Citation
defCit = Citation{citationId = ""
                 ,citationPrefix = []
                 ,citationSuffix = []
                 ,citationHash = 0
                 ,citationNoteNum = 0
                 ,citationMode = NormalCitation
                 }

cit :: T.Text -> [Citation]
cit r = [defCit{citationId=r}]

infixr 0 =:
(=:) :: Df.Default r => Lens' r a -> a -> r
a =: b = a .~ b $ def
