module ResolverFormula where

import Data.Set (Set, fromList)
import DadosBase (Formula(..))

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