# Variação anual estimada

Transforma o coeficiente de `ano` do modelo de
[`ajustar_modelo()`](https://l4ur419.github.io/tdr-projeto/reference/ajustar_modelo.md)
na variação anual, em proporção, com `exp(coef) - 1`, e faz o mesmo com
os limites do intervalo de confiança.

## Uso

``` r
variacao_anual(modelo, nivel = 0.95)
```

## Argumentos

- modelo:

  Um objeto da classe `lm` com o coeficiente `ano`, como o devolvido por
  [`ajustar_modelo()`](https://l4ur419.github.io/tdr-projeto/reference/ajustar_modelo.md).
  Outro objeto produz um erro da classe `leitecoop_erro_modelo`.

- nivel:

  Nível de confiança do intervalo, entre 0 e 1.

## Valor

Um `tibble` com uma linha e as colunas `variacao`, `inferior` e
`superior`, em proporção (multiplique por 100 para ter a porcentagem).

## Veja também

Other modelo:
[`ajustar_modelo()`](https://l4ur419.github.io/tdr-projeto/reference/ajustar_modelo.md)

## Exemplos

``` r
variacao_anual(ajustar_modelo(leite_fazendas))
#> # A tibble: 1 × 3
#>   variacao inferior superior
#>      <dbl>    <dbl>    <dbl>
#> 1   0.0724   0.0573   0.0877
```
