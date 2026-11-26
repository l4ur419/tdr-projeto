# Resumo por ano

Resume cada ano: fazendas com medição, meses com e sem registro, total
de leite e média mensal da medida relativa. É a tabela da comparação
entre 2023 e 2025, que usa a média da medida relativa, e não o total: o
total soma apenas os meses registrados e depende do tamanho dos
rebanhos, e a média relativa considera só os meses registrados e
desconta o porte de cada fazenda.

## Uso

``` r
resumir_ano(dados)
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

Um `tibble` com uma linha por ano, em ordem crescente, e as colunas
`ano`, `unidades`, `meses_com_registro`, `meses_sem_registro`, `total`
(mil litros) e `media_relativa` (mil litros por vaca no mês).

## Meses sem registro

Um mês sem registro é dado ausente, e não produção zero. Os totais e as
médias ignoram esses meses (`na.rm = TRUE`), e as contagens de meses com
e sem registro usam [`is.na()`](https://rdrr.io/r/base/NA.html). A
decisão afeta as colunas de total e de média da medida relativa, mas não
as de contagem de meses.

## Veja também

Other resumos:
[`resumir_cat_ano()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_cat_ano.md),
[`resumir_categoria()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_categoria.md),
[`resumir_mes()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_mes.md),
[`resumir_sazonal()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_sazonal.md),
[`resumir_unidade()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_unidade.md)

## Exemplos

``` r
resumo <- resumir_ano(leite_fazendas)
resumo
#> # A tibble: 3 × 6
#>     ano unidades meses_com_registro meses_sem_registro  total media_relativa
#>   <int>    <int>              <int>              <int>  <dbl>          <dbl>
#> 1  2023       10                118                  2 18870.          0.658
#> 2  2024       10                115                  5 19673.          0.703
#> 3  2025       10                118                  2 21661           0.756
# Variação percentual da média relativa entre o primeiro e o último ano
100 * (resumo$media_relativa[3] / resumo$media_relativa[1] - 1)
#> [1] 15.03238
```
