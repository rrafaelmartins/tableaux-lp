{-# OPTIONS_GHC -Wno-unused-matches #-}
module ResolverFormula where

import Data.Tree ( Tree(Node) )
import Data.Set ( Set, filter, null, member, findMin, deleteMin, size, singleton, fromList )
import Models ( Formula(Atomo, Nao, E, Ou, Implica, Equivale), StatusConjunto(EhFormula, Aberto, Fechado), Tableaux )
import Prelude hiding (min)

ehAtomo :: Formula -> Bool
ehAtomo (Atomo _) = True
ehAtomo (Nao (Atomo _)) = True
ehAtomo _ = False

aplicarRegras :: Formula -> Formula
aplicarRegras (Implica f g) = Ou (Nao f) g
aplicarRegras (Equivale f g) = E (Implica f g) (Implica g f)
aplicarRegras f = f

todosAtomos :: Set Formula -> Bool
todosAtomos sp = Data.Set.null (Data.Set.filter (not . ehAtomo) sp)

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
    | (not . todosAtomos) sp = EhFormula
    | otherwise = Aberto

noFechado :: Tableaux -> Bool
noFechado (Node (f, b) children) = b

resolver :: Formula -> [Set Formula]
resolver (E p q) = [fromList [p, q]]
resolver (Nao (Ou p q)) = [fromList [Nao p, Nao q]]
resolver (Nao (Implica p q)) = [fromList [p, Nao q]]
resolver (Nao (Nao p)) = [fromList [p]]
resolver (Nao (E p q)) = map singleton [Nao p, Nao q]
resolver (Nao (Equivale p q)) = map singleton [Nao (Implica p q), Nao (Implica q p)]
resolver (Equivale p q) = [fromList [Implica p q, Implica q p]]
resolver (Ou p q) = map singleton [p, q]
resolver (Implica p q) = map singleton [Nao p, q]
resolver (Nao p) = [singleton (Nao p)]
resolver p = [singleton p]