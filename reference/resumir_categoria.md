# Resumo por sistema de produção

Resume cada sistema de produção (a categoria das fazendas: Confinado,
Semiconfinado ou Pasto) nos três anos: número de fazendas, total de
leite e média mensal da medida relativa, da maior média para a menor.

## Uso

``` r
resumir_categoria(dados)
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

Um `tibble` com uma linha por sistema e as colunas `sistema`,
`unidades`, `total` (mil litros) e `media_relativa` (mil litros por vaca
no mês).

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
[`resumir_mes()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_mes.md),
[`resumir_sazonal()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_sazonal.md),
[`resumir_unidade()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_unidade.md)

## Exemplos

``` r
resumir_categoria(leite_fazendas)
#> # A tibble: 3 × 4
#>   sistema       unidades  total media_relativa
#>   <chr>            <int>  <dbl>          <dbl>
#> 1 Confinado            4 26281.          0.831
#> 2 Semiconfinado        3 20442.          0.682
#> 3 Pasto                3 13482.          0.558
```
