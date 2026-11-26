# Fazenda do cadastro sem medição

Responde, com uma junção filtrante
([`dplyr::anti_join()`](https://dplyr.tidyverse.org/reference/filter-joins.html)),
quais fazendas do cadastro não têm medição em ano algum.

## Uso

``` r
achar_sem_medicao(cadastro = ler_cadastro(), leite_bruto = ler_anuais())
```

## Argumentos

- cadastro:

  Tabela do cadastro, como a devolvida por
  [`ler_cadastro()`](https://l4ur419.github.io/tdr-projeto/reference/ler_cadastro.md).

- leite_bruto:

  Tabela das medições, como a devolvida por
  [`ler_anuais()`](https://l4ur419.github.io/tdr-projeto/reference/ler_anuais.md)
  (ou a tabela arrumada, que também tem a coluna `codigo`).

## Valor

Um `tibble` com as linhas do cadastro cujo código não aparece nas
medições.

## Exemplos

``` r
achar_sem_medicao()
#> # A tibble: 1 × 4
#>   codigo nome                  sistema       vacas
#>   <chr>  <chr>                 <chr>         <dbl>
#> 1 FZ01   Fazenda Boa Esperança Semiconfinado    64
```
