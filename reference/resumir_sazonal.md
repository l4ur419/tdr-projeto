# Resumo por ano e mês

Calcula a média da medida relativa em cada mês de cada ano, que é o que
a figura de sazonalidade
([`grafico_sazonal()`](https://l4ur419.github.io/tdr-projeto/reference/grafico_sazonal.md))
desenha.

## Uso

``` r
resumir_sazonal(dados)
```

## Argumentos

- dados:

  A tabela arrumada, da classe `leitecoop`, como a devolvida por
  [`arrumar_dados()`](https://l4ur419.github.io/tdr-projeto/reference/arrumar_dados.md)
  ou o conjunto
  [leite_fazendas](https://l4ur419.github.io/tdr-projeto/reference/leite_fazendas.md).
  Uma tabela sem as colunas usadas no resumo produz um erro da classe
  `leitecoop_erro_colunas`.

## Valor

Um `tibble` com uma linha por ano e mês e as colunas `ano` (fator),
`mes` (fator) e `media_relativa` (mil litros por vaca no mês).

## Meses sem registro

Um mês sem registro é dado ausente, e não produção zero. Os totais e as
médias ignoram esses meses (`na.rm = TRUE`), e as contagens de meses com
e sem registro usam [`is.na()`](https://rdrr.io/r/base/NA.html). A
decisão afeta as colunas de total e de média da medida relativa, mas não
as de contagem de meses.

## Veja também

Other resumos:
[`resumir_ano()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_ano.md),
[`resumir_cat_ano()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_cat_ano.md),
[`resumir_categoria()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_categoria.md),
[`resumir_mes()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_mes.md),
[`resumir_unidade()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_unidade.md)

## Exemplos

``` r
resumir_sazonal(leite_fazendas)
#> # A tibble: 36 × 3
#>    ano   mes   media_relativa
#>    <fct> <fct>          <dbl>
#>  1 2023  jan            0.655
#>  2 2023  fev            0.647
#>  3 2023  mar            0.631
#>  4 2023  abr            0.619
#>  5 2023  mai            0.601
#>  6 2023  jun            0.618
#>  7 2023  jul            0.624
#>  8 2023  ago            0.656
#>  9 2023  set            0.707
#> 10 2023  out            0.729
#> # ℹ 26 more rows
```
