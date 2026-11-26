# Número no formato brasileiro

Arredonda e formata números com vírgula decimal e ponto de milhar, para
citá-los em texto, como no código em linha de um documento Quarto, sem a
notação científica que o R usaria para números grandes.

## Uso

``` r
formatar_numero(x, digitos = 1)
```

## Argumentos

- x:

  Vetor numérico. Outro tipo produz um erro da classe
  `leitecoop_erro_argumento`.

- digitos:

  Número de casas decimais, inteiro não negativo.

## Valor

Um vetor de caracteres do comprimento de `x`.

## Exemplos

``` r
formatar_numero(18870.1)
#> [1] "18.870,1"
formatar_numero(0.65789, digitos = 2)
#> [1] "0,66"
formatar_numero(c(1234567.891, 2.5), digitos = 2)
#> [1] "1.234.567,89" "2,50"        
```
