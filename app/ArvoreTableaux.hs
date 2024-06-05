module ArvoreTableaux where

import Data.Set (toList, Set, partition, findMin, delete, union)
import Data.List (intercalate)
import Data.Tree (Tree(Node), drawTree)

import ResolverFormula (resolver)
import DadosBase (Formula(..), Tableaux, TipoNo, StatusConjunto(..))

instance Show Formula where
    show (Atomo c) = c : ""
    show (Nao f) = "(~" ++ show f ++ ")"
    show (E f g) = "(" ++ show f ++ " ^ " ++ show g ++ ")"
    show (Ou f g) = "(" ++ show f ++ " v " ++ show g ++ ")"
    show (Implica f g) = "(" ++ show f ++ " -> " ++ show g ++ ")"
    show (Equivale f g) = "(" ++ show f ++ " <-> " ++ show g ++ ")"

mostrarNo :: TipoNo -> String
mostrarNo (sp, res) = intercalate ", " (map show (toList sp)) ++ if res then " {x}" else " {0}"

mostrarTableaux :: Tableaux -> String
mostrarTableaux = drawTree . fmap mostrarNo

construirArvore :: Set Formula -> Tableaux
construirArvore sp = do
    let (naoAtomos, _) = partition (not . ehAtomo) sp
    let min = findMin naoAtomos
    let conjuntoAux = delete min sp
    let res = map (construirArvore . union conjuntoAux) (resolver min)
    Node (sp, null res) res