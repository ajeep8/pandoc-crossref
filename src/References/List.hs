module References.List (listOf) where

import Text.Pandoc.Definition
import Control.Monad.State
import Control.Arrow
import Data.List
import qualified Data.Map as M

import References.Types
import Util.Util
import Util.Options

listOf :: Options -> [Block] -> WS [Block]
listOf Options{outFormat=f} x | isFormat "latex" f = return x
listOf opts (Para [RawInline (Format "tex") "\\listoffigures"]:xs)
  = gets imgRefs >>= makeList opts lofTitle xs
listOf opts (Para [RawInline (Format "tex") "\\listoftables"]:xs)
  = gets tblRefs >>= makeList opts lotTitle xs
listOf opts (Para [RawInline (Format "tex") "\\listoflistings"]:xs)
  = gets lstRefs >>= makeList opts lolTitle xs
listOf _ x = return x

makeList :: Options -> (Options -> [Block]) -> [Block] -> M.Map String RefRec -> WS [Block]
makeList opts titlef xs refs
  = return $
      titlef opts ++
      (if sepChapters opts
        then Div ("", ["list"], []) (itemChap `map` refsSorted)
        else OrderedList style (item `map` refsSorted))
      : xs
  where
    refsSorted = sortBy compare' $ M.toList refs
    compare' (_,RefRec{refIndex=i}) (_,RefRec{refIndex=j}) = compare i j
    item = (:[]) . Plain . refTitle . snd
    itemChap = Para . uncurry ((. (Space :)) . (++)) . (numWithChap . refIndex &&& refTitle) . snd
    numWithChap (c,i)
      | c > 0 = s c : chapDelim opts ++ [s i]
      | otherwise = [s i]
      where
        s = Str . show
    style = (1,DefaultStyle,DefaultDelim)
