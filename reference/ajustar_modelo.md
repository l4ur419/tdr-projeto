# Modelo para a variação anual

Ajusta o modelo do trabalho intermediário. Os valores dos dados são o
produto de efeitos (porte, sistema, mês e ano), de modo que, no
logaritmo, eles se somam; o modelo é
`lm(log(litros_por_vaca) ~ ano + mes + sistema)`, ajustado aos meses com
registro e medida relativa positiva.

## Uso

``` r
ajustar_modelo(dados)
```

## Argumentos

- dados:

  A tabela arrumada, da classe `leitecoop`, com as colunas `ano`, `mes`,
  `sistema` e `litros_por_vaca`. Uma tabela sem essas colunas produz um
  erro da classe `leitecoop_erro_colunas`.

## Valor

Um objeto da classe `lm`.

## Veja também

[`variacao_anual()`](https://l4ur419.github.io/tdr-projeto/reference/variacao_anual.md),
que extrai a variação anual estimada.

Other modelo:
[`variacao_anual()`](https://l4ur419.github.io/tdr-projeto/reference/variacao_anual.md)

## Exemplos

``` r
modelo <- ajustar_modelo(leite_fazendas)
coef(modelo)
#>          (Intercept)                  ano               mesfev 
#>        -141.66483681           0.06989864          -0.04227658 
#>               mesmar               mesabr               mesmai 
#>          -0.06682149          -0.08134164          -0.07422572 
#>               mesjun               mesjul               mesago 
#>          -0.07252609          -0.03498746           0.02128161 
#>               messet               mesout               mesnov 
#>           0.06337096           0.10602553           0.11802367 
#>               mesdez         sistemaPasto sistemaSemiconfinado 
#>           0.03968064          -0.40055477          -0.20805199 
```
