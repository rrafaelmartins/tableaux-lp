import Models (Formula(..))
import ArvoreTableaux (mostrarTableaux, construirArvore, ehTautologia)
import ResolverFormula (aplicarRegras)
import Data.Set (singleton)
import Parser (parseFormula)

main :: IO ()
main = do
    putStrLn "\nInsira a fórmula:"
    entrada <- getLine

    case parseFormula entrada of
        Left erro -> print erro
        Right formula -> do
            putStrLn "\nSupondo que a fórmula é falsa:"
            putStrLn $ "~" ++ show formula

            putStrLn "\nProvando por refutação:"
            let tableaux = (construirArvore . singleton) (aplicarRegras (Nao formula))
            putStrLn (mostrarTableaux tableaux)

            let msg = if ehTautologia tableaux then " não é " else " é "
            putStrLn $ "\n Logo, a fórmula " ++ show formula ++ msg ++ "uma tautologia!\n"