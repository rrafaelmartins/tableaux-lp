{-# OPTIONS_GHC -Wno-orphans #-}
module ArvoreTableaux where

-- ESTE ARQUIVO DESENHA A ÁRVORE

import Data.Set ( toList, Set, partition, findMin, delete, union )
import Data.List ( intercalate )
import Data.Tree ( Tree(Node), drawTree )

import ResolverFormula ( resolver, obterStatus, ehAtomo, noFechado )
import qualified Data.Tree as Tree
import Prelude hiding (min)
import Models ( Formula(Atomo, Nao, E, Ou, Implica, Equivale), Tableaux, TipoNo, StatusConjunto(EhFormula, Aberto, Fechado) )

instance Show Formula where
    show (Atomo c) = c : ""
    show (Nao f) = "(~" ++ show f ++ ")"
    show (E f g) = "(" ++ show f ++ " ^ " ++ show g ++ ")"
    show (Ou f g) = "(" ++ show f ++ " v " ++ show g ++ ")"
    show (Implica f g) = "(" ++ show f ++ " -> " ++ show g ++ ")"
    show (Equivale f g) = "(" ++ show f ++ " <-> " ++ show g ++ ")"

listaFormulasParaStrings :: [Formula] -> [String]
listaFormulasParaStrings = map show

ehTautologia :: Tableaux -> Bool
ehTautologia = not . fechado

fechado :: Tableaux -> Bool
fechado (Tree.Node (_, b) _) = b

listaParaString :: [Formula] -> String
listaParaString f = Data.List.intercalate ", " (listaFormulasParaStrings f)

mostrarNo :: TipoNo -> String
mostrarNo (sp, res) = 
    let isLeaf = null (Tree.subForest (Node undefined [])) in
    if isLeaf && all ehAtomo (toList sp)
        then listaParaString (toList sp) ++ if res then " {x}" else " {0}"
        else listaParaString (toList sp)

mostrarTableaux :: Tableaux -> String
mostrarTableaux = drawTree . fmap mostrarNo

construirArvore :: Set Formula -> Tableaux
construirArvore sp = do
    let (naoAtomos, _) = partition (not . ehAtomo) sp
    let min = findMin naoAtomos
    let conjuntoAux = delete min sp
    let res = map (construirArvore . union conjuntoAux) (resolver min)
    let todosFechados = all noFechado res

    case obterStatus sp of
      Aberto -> Node (sp, False) []
      Fechado -> Node (sp, True) []
      EhFormula -> Node (sp, todosFechados) res