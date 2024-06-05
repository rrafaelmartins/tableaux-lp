module Parser (parseFormula) where

import Text.ParserCombinators.Parsec
import qualified Text.ParserCombinators.Parsec.Expr as Ex
import Text.ParserCombinators.Parsec.Language (emptyDef)
import qualified Text.ParserCombinators.Parsec.Token as Tok
import DadosBase (Formula(..))

lexer = Tok.makeTokenParser emptyDef
parens = Tok.parens lexer
reservedOp = Tok.reservedOp lexer
whiteSpace = Tok.whiteSpace lexer
identifier = Tok.identifier lexer

atomo :: Parser Formula
atomo = do
  Atomo . head <$> identifier

formula :: Parser Formula
formula = Ex.buildExpressionParser tabela fator
  where
    prefixOp x f = Ex.Prefix (reservedOp x >> return f)
    infixOp  x f = Ex.Infix (reservedOp x >> return f)
    tabela = [ [prefixOp "~"  Nao]
             , [infixOp "->"  Implica Ex.AssocRight]
             , [infixOp "<->" Equivale Ex.AssocRight]
             , [infixOp "^" E Ex.AssocLeft]
             , [infixOp "v" Ou  Ex.AssocLeft]
             ]
    fator =  parens formula
           <|> atomo
           <?> "proposicao"

parseFormula :: String -> Either ParseError Formula
parseFormula = parse (whiteSpace >> formula) "Formula"