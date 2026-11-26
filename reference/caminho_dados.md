# Caminho de um arquivo de dados do pacote

Devolve o caminho, no pacote instalado, de um ou mais dos arquivos
brutos que o acompanham em `inst/extdata/`: os três arquivos anuais
(`leite_2023.csv`, `leite_2024.csv` e `leite_2025.csv`), o cadastro
(`cadastro.csv`) e o `LEIA-ME.txt`. As funções de leitura usam esses
caminhos como padrão. O caminho é obtido com
[`system.file()`](https://rdrr.io/r/base/system.file.html), e por isso
funciona tanto no pacote instalado quanto com o `devtools::load_all()`.

## Uso

``` r
caminho_dados(arquivo = NULL)
```

## Argumentos

- arquivo:

  Vetor de caracteres com o nome de um ou mais arquivos de
  `inst/extdata/`. Com `NULL`, o padrão, a função devolve os nomes dos
  arquivos disponíveis.

## Valor

Um vetor de caracteres com o caminho completo de cada arquivo pedido ou,
com `arquivo = NULL`, com os nomes dos arquivos disponíveis. Um nome que
não está em `inst/extdata/` produz um erro da classe
`leitecoop_erro_arquivo`.

## Exemplos

``` r
caminho_dados()
#> [1] "LEIA-ME.txt"    "cadastro.csv"   "leite_2023.csv" "leite_2024.csv"
#> [5] "leite_2025.csv"
caminho_dados("cadastro.csv")
#> [1] "/home/runner/work/_temp/Library/leitecoop/extdata/cadastro.csv"
caminho_dados(c("leite_2023.csv", "leite_2025.csv"))
#> [1] "/home/runner/work/_temp/Library/leitecoop/extdata/leite_2023.csv"
#> [2] "/home/runner/work/_temp/Library/leitecoop/extdata/leite_2025.csv"
```
