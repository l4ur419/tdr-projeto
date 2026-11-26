# Login para o qual os dados foram sorteados

Lê, na primeira linha do `LEIA-ME.txt`, o login do GitHub para o qual os
dados simulados foram sorteados.

## Uso

``` r
ler_login(arquivo = caminho_dados("LEIA-ME.txt"))
```

## Argumentos

- arquivo:

  Caminho do `LEIA-ME.txt`. O padrão é o que acompanha o pacote.

## Valor

Um vetor de caracteres de comprimento um, com o login. Um arquivo que
não existe, ou cuja primeira linha não traz o login, produz um erro da
classe `leitecoop_erro_arquivo`.

## Exemplos

``` r
ler_login()
#> [1] "l4ur419"
```
