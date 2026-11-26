# Gráfico de sazonalidade

Desenha a média mensal da medida relativa (mil litros por vaca), com uma
linha para cada ano.

## Uso

``` r
grafico_sazonal(resumo)
```

## Argumentos

- resumo:

  O resumo por ano e mês, como o devolvido por
  [`resumir_sazonal()`](https://l4ur419.github.io/tdr-projeto/reference/resumir_sazonal.md),
  com as colunas `ano`, `mes` e `media_relativa`. Uma tabela sem essas
  colunas produz um erro da classe `leitecoop_erro_colunas`.

## Valor

Um objeto do `ggplot2`, desenhado ao ser impresso.

## Veja também

Other graficos:
[`grafico_categorias()`](https://l4ur419.github.io/tdr-projeto/reference/grafico_categorias.md)

## Exemplos

``` r
grafico_sazonal(resumir_sazonal(leite_fazendas))
```
