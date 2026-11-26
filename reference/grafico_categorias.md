# Gráfico da medida relativa por sistema

Desenha a distribuição da medida relativa (mil litros por vaca no mês)
em cada sistema de produção, com os três anos juntos. Os meses sem
registro ficam de fora.

## Uso

``` r
grafico_categorias(dados)
```

## Argumentos

- dados:

  A tabela arrumada, da classe `leitecoop`, com as colunas `sistema` e
  `litros_por_vaca`. Uma tabela sem essas colunas produz um erro da
  classe `leitecoop_erro_colunas`.

## Valor

Um objeto do `ggplot2`, desenhado ao ser impresso.

## Veja também

Other graficos:
[`grafico_sazonal()`](https://l4ur419.github.io/tdr-projeto/reference/grafico_sazonal.md)

## Exemplos

``` r
grafico_categorias(leite_fazendas)
```
