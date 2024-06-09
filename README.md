## Trabalho de Linguagens de Programação: Tableaux para a Lógica Clássica Proposicional.
### Professor: Bruno Lopes Vieira.
### Alunos: Mateus Ferreira Machado e Rafael Aguiar Martins.

### 1. Como executar?
#### 1.1 - No VSCode, baixar a extensão "Haskell"
- A extensão pedirá para baixar o compilador do Haskell e o Cabal. Caso isso não ocorra automaticamente, é possível baixar nesse link:
  - [https://www.haskell.org/cabal/](https://www.haskell.org/cabal/download.html)

#### 1.2 - O input deve ser feito seguindo a seguinte lista de representações:

- Implicação: ->
- Equivalência: <->
- Negação: ~
- Conjunção (e): ^
- Disjunção (ou): v

#### 1.3 - Lembrar de usar o espaçamento quando for utilizar a Disjunção (ou). Pois o símbolo v (letra V) será confundido com um átomo (p, q, r, etc)
Exemplo:
a v b: Funciona
avb: Não Funciona

#### 1.4 - No diretório principal, utilizar o comando `cabal run`.
