# Resumo por mês

Calcula a média da medida relativa em cada mês, com os três anos juntos.
É o resumo que aponta o mês de maior e o de menor média.

## Uso

``` r
resumir_mes(dados)
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

Um `tibble` com uma linha por mês, na ordem do calendário, e as colunas
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
[`resumir_sazonal()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_sazonal.md),
[`resumir_unidade()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_unidade.md)

## Exemplos

``` r
por_mes <- resumir_mes(leite_fazendas)
por_mes
#> # A tibble: 12 × 2
#>    mes   media_relativa
#>    <fct>          <dbl>
#>  1 jan            0.704
#>  2 fev            0.673
#>  3 mar            0.657
#>  4 abr            0.658
#>  5 mai            0.656
#>  6 jun            0.652
#>  7 jul            0.680
#>  8 ago            0.728
#>  9 set            0.749
#> 10 out            0.781
#> 11 nov            0.793
#> 12 dez            0.732
por_mes$mes[which.max(por_mes$media_relativa)]
#> [1] nov
#> Levels: jan fev mar abr mai jun jul ago set out nov dez
```
