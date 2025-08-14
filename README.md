# 🧮 Trabalho da disciplina Linguagens de Programação: Tableaux para a Lógica Clássica Proposicional.

**Professor:** Bruno Lopes Vieira  
**Alunos:** Mateus Ferreira Machado e Rafael Aguiar Martins

---

## 📦 Como Executar

Para garantir a compatibilidade e evitar erros, é **altamente recomendado** seguir estes passos para configurar o ambiente com as versões exatas que foram testadas e funcionam com o projeto.

---

### 1️⃣ Instalação do Ambiente (via GHCup)

A maneira mais confiável de instalar o Haskell é usando a ferramenta **[GHCup](https://www.haskell.org/ghcup/)**.

#### **Linux / macOS / WSL**
```bash
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

#### **Windows (PowerShell)**
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
Invoke-Command -ScriptBlock ([ScriptBlock]::Create((Invoke-WebRequest https://www.haskell.org/ghcup/sh/bootstrap-haskell.ps1 -UseBasicParsing))) -ArgumentList $true
```
> Após instalar, feche e reabra o terminal.

---

### 2️⃣ Instalação das Versões Certas

1.  **Instale o GHC (versão 9.12.2 ou superior):**
    ```bash
    ghcup install ghc 9.12.2
    ```

2.  **Instale o Cabal (versão 3.16.0.0 ou superior):**
    ```bash
    ghcup install cabal 3.16.0.0
    ```

3.  **Defina as versões como padrão:**
    ```bash
    ghcup set ghc 9.12.2
    ghcup set cabal 3.16.0.0
    ```

---

### 3️⃣ Executando o Projeto

1. **Clone o repositório**:
```bash
git clone https://github.com/rrafaelmartins/tableaux-lp.git
```

2. **Entre na pasta do projeto**:
```bash
cd caminho/para/o/projeto
```

3. **Execute o programa**:
```bash
cabal run
```
> Na primeira execução, o Cabal baixará dependências e compilará o projeto, o que pode levar alguns minutos.

---

## 🖥️ Utilização do Programa

### Formato da Entrada

[cite_start]O input da fórmula lógica deve seguir as seguintes representações: [cite: 1]

* [cite_start]Implicação: `->` [cite: 1]
* [cite_start]Equivalência: `<->` [cite: 1]
* [cite_start]Negação: `~` [cite: 1]
* [cite_start]Conjunção (e): `^` [cite: 1]
* [cite_start]Disjunção (ou): `v` [cite: 1]

### ⚠️ Atenção ao Espaçamento no `v`
[cite_start]É fundamental usar espaços ao redor do operador de **Disjunção (`v`)**, pois o símbolo `v` (a letra "v") pode ser confundido com um átomo (como `p`, `q`, `r`, etc). [cite: 1]

✅ **Correto**:
```txt
a v b
```

❌ **Incorreto**:
```txt
avb
```

---

## 📌 Exemplo de Uso

Entrada:
```
(a ^ b) v (b -> a)
```

Negando a fórmula:
```
~((a ^ b) v (b -> a))
```

Saída (exemplo):
```
(~((a ^ b) v (b -> a)))

|
- (~(a ^ b)), (~(b -> a))     | +- (~a), (~(b -> a))        |  | |  - b, (~a) {0}
|
- (~b), (~(b -> a))           | - b, (~a), (~b) {x}
```

Conclusão:
> A fórmula `((a ^ b) v (b -> a))` **não é** uma tautologia.

---

## 📖 Legenda do Resultado

- `{0}` → **Ramo Aberto**: não houve contradição.
- `{x}` → **Ramo Fechado**: houve contradição.

---