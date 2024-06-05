module Models where

import Data.Set (Set)
import Data.Tree (Tree)

data Formula = Atomo !Chargit 
             | Nao !Formula
             | E !Formula !Formula
             | Ou !Formula !Formula
             | Implica !Formula !Formula
             | Equivale !Formula !Formula
             deriving (Eq, Ord)

data ArvoreF = Vazia | NoF {
    formula :: !Formula,
    esquerda :: !ArvoreF,
    direita :: !ArvoreF
} deriving (Eq, Ord)

data StatusConjunto = EhFormula | Aberto | Fechado deriving (Eq, Show)

type TipoNo = (Set Formula, Bool)

type Tableaux = Tree TipoNo