# Total de cada sistema em cada ano

A tabela de apresentação da Lista 03: o total de leite de cada sistema
em cada ano, com uma linha por sistema e uma coluna por ano. A soma de
cada coluna é a soma dos valores registrados no ano, do `LEIA-ME.txt`.

## Uso

``` r
resumir_cat_ano(dados)
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

Um `tibble` com uma linha por sistema, em ordem alfabética, a coluna
`sistema` e uma coluna por ano, com o total em mil litros.

## Meses sem registro

Um mês sem registro é dado ausente, e não produção zero. Os totais e as
médias ignoram esses meses (`na.rm = TRUE`), e as contagens de meses com
e sem registro usam [`is.na()`](https://rdrr.io/r/base/NA.html). A
decisão afeta as colunas de total e de média da medida relativa, mas não
as de contagem de meses.

## Veja também

Other resumos:
[`resumir_ano()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_ano.md),
[`resumir_categoria()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_categoria.md),
[`resumir_mes()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_mes.md),
[`resumir_sazonal()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_sazonal.md),
[`resumir_unidade()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_unidade.md)

## Exemplos

``` r
resumir_cat_ano(leite_fazendas)
#> # A tibble: 3 × 4
#>   sistema       `2023` `2024` `2025`
#>   <chr>          <dbl>  <dbl>  <dbl>
#> 1 Confinado      8225.  8591.  9464.
#> 2 Pasto          4164.  4453.  4864 
#> 3 Semiconfinado  6480.  6628.  7333.
```
