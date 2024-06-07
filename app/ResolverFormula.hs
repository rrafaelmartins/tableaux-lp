module ResolverFormula where

import Data.Set (Set, fromList)
import Models (Formula(..))

resolver :: Formula -> [Set Formula]
resolver (E p q) = [fromList [p, q]]
resolver (Ou p q) = [fromList [p], fromList [q]]
resolver (Implica p q) = [fromList [Nao p, q]]
resolver (Equivale p q) = [fromList [Implica p q, Implica q p]]
resolver (Nao (E p q)) = [fromList [Nao p], fromList [Nao q]]
resolver (Nao (Ou p q)) = [fromList [Nao p, Nao q]]
resolver (Nao (Implica p q)) = [fromList [p, Nao q]]
resolver (Nao (Equivale p q)) = [fromList [Nao (Implica p q), Nao (Implica q p)]]
resolver (Nao (Nao p)) = [fromList [p]]
resolver f = [fromList [f]]

ehAtomo :: Formula -> Bool
ehAtomo (Atomo _) = True
ehAtomo (Nao (Atomo _)) = True
ehAtomo _ = False

oposta :: Formula -> Formula
oposta (Nao p) = p
oposta p = Nao p

temContradicao :: Set Formula -> Bool
temContradicao sp
    | size sp <= 1 = False
    | otherwise = do
      let min = findMin sp
      let conjuntoSemMin = deleteMin sp
      member (oposta min) conjuntoSemMin || temContradicao conjuntoSemMin

obterStatus :: Set Formula -> StatusConjunto
obterStatus sp
    | temContradicao sp = Fechado
    | any (not . ehAtomo) (toList sp) = EhFormula
    | otherwise = Aberto

noFechado :: Tableaux -> Bool
noFechado (Node (_, b) _) = b