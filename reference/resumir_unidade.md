# Resumo por fazenda

Resume cada fazenda nos três anos: meses com registro, total de leite e
média mensal da medida relativa, com o nome e o sistema de cada uma,
ordenado da maior média relativa para a menor.

## Uso

``` r
resumir_unidade(dados)
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

Um `tibble` com uma linha por fazenda e as colunas `codigo`, `nome`,
`sistema`, `meses_com_registro`, `total` (mil litros) e `media_relativa`
(mil litros por vaca no mês).

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
[`resumir_sazonal()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_sazonal.md)

## Exemplos

``` r
resumir_unidade(leite_fazendas)
#> # A tibble: 10 × 6
#>    codigo nome                  sistema meses_com_registro  total media_relativa
#>    <chr>  <chr>                 <chr>                <int>  <dbl>          <dbl>
#>  1 FZ10   Fazenda Capão Alto    Confin…                 36  7320.          0.865
#>  2 FZ06   Fazenda São Jorge     Confin…                 36  5225.          0.849
#>  3 FZ07   Fazenda Três Irmãos   Confin…                 36  4048.          0.821
#>  4 FZ03   Fazenda Santo Antônio Semico…                 36 10088.          0.794
#>  5 FZ09   Fazenda Santa Rita    Confin…                 35  9687.          0.789
#>  6 FZ08   Fazenda Primavera     Semico…                 34  6539.          0.680
#>  7 FZ02   Fazenda Santa Luzia   Pasto                   36  7999.          0.599
#>  8 FZ05   Fazenda Monte Alegre  Semico…                 33  3815.          0.564
#>  9 FZ04   Fazenda Água Limpa    Pasto                   35  3560.          0.544
#> 10 FZ11   Fazenda Vale do Sol   Pasto                   34  1924.          0.529
```
