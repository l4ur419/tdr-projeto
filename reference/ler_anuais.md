# Leitura dos três arquivos anuais

Lê os arquivos anuais com
[`ler_um_ano()`](https://l4ur419.github.io/tdr-projeto/reference/ler_um_ano.md),
por meio do
[`purrr::map()`](https://purrr.tidyverse.org/reference/map.html), e os
empilha em uma tabela só, registrando de qual arquivo veio cada linha. O
ano é tirado do nome do arquivo, com
[`readr::parse_number()`](https://readr.tidyverse.org/reference/parse_number.html).

## Uso

``` r
ler_anuais(arquivos = caminho_dados(arquivos_anuais))
```

## Argumentos

- arquivos:

  Vetor com os caminhos dos arquivos anuais. O padrão são os três
  arquivos que acompanham o pacote, de 2023, 2024 e 2025. O nome de cada
  arquivo precisa conter o ano.

## Valor

Um `tibble` com uma linha por fazenda e ano e as colunas `origem` (o
nome do arquivo), `ano` (inteiro), `codigo` e os meses `jan` a `dez`. Um
arquivo que não existe produz um erro da classe
`leitecoop_erro_arquivo`.

## Veja também

[`arrumar_dados()`](https://l4ur419.github.io/tdr-projeto/reference/arrumar_dados.md),
que passa a tabela para a forma longa e a junta ao cadastro.

## Exemplos

``` r
leite_bruto <- ler_anuais()
leite_bruto
#> # A tibble: 30 × 15
#>    origem       ano codigo   jan   fev   mar   abr   mai   jun   jul   ago   set
#>    <chr>      <int> <chr>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 leite_202…  2023 FZ02   190.  182.  202   168   164.  198.  206.  226.  220. 
#>  2 leite_202…  2023 FZ03   261.  260.  244.  223.  239.  251.  257.  268.  273. 
#>  3 leite_202…  2023 FZ04    98.1  92.5  88.1  75.4  83.9  83.8 101.   98.8 109. 
#>  4 leite_202…  2023 FZ05   111.  110.  106.   99.5  NA    93.1 103.  105   114. 
#>  5 leite_202…  2023 FZ06   136.  129.  117   133.  134   120.  121.  146.  152. 
#>  6 leite_202…  2023 FZ07   113   110.  108.  109.   86   111.  104.   89.4 114. 
#>  7 leite_202…  2023 FZ08   174.  174   202.  151.  163.  164.  158.  171.  185  
#>  8 leite_202…  2023 FZ09   263.  270.  253.  241   209.  238.  245.  259.  294. 
#>  9 leite_202…  2023 FZ10   183   193.  170   188.  173.  186.  176.  187.  197. 
#> 10 leite_202…  2023 FZ11    49.9  48.3  49.6  NA    55.6  49.9  48.3  54.9  55.1
#> # ℹ 20 more rows
#> # ℹ 3 more variables: out <dbl>, nov <dbl>, dez <dbl>
table(leite_bruto$ano)
#> 
#> 2023 2024 2025 
#>   10   10   10 
```
