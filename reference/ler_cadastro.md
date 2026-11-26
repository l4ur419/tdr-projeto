# Leitura do cadastro das fazendas

Lê o cadastro, com uma linha por fazenda. O arquivo é separado por ponto
e vírgula e está na codificação Latin-1 (ISO-8859-1), que é a dos
acentos dos nomes; o tipo de cada coluna é declarado, em vez de
adivinhado.

## Uso

``` r
ler_cadastro(arquivo = caminho_dados("cadastro.csv"))
```

## Argumentos

- arquivo:

  Caminho do arquivo do cadastro. O padrão é o `cadastro.csv` que
  acompanha o pacote
  ([`caminho_dados()`](https://l4ur419.github.io/tdr-projeto/reference/caminho_dados.md)).

## Valor

Um `tibble` com uma linha por fazenda e as colunas `codigo`
(identificador, o mesmo dos arquivos anuais), `nome`, `sistema`
(Confinado, Semiconfinado ou Pasto) e `vacas` (vacas em lactação). Um
arquivo que não existe produz um erro da classe
`leitecoop_erro_arquivo`, e uma tabela sem as colunas esperadas, um erro
da classe `leitecoop_erro_colunas`.

## Veja também

[`ler_anuais()`](https://l4ur419.github.io/tdr-projeto/reference/ler_anuais.md),
para os arquivos de medições, e
[`arrumar_dados()`](https://l4ur419.github.io/tdr-projeto/reference/arrumar_dados.md),
que junta as duas leituras.

## Exemplos

``` r
cadastro <- ler_cadastro()
cadastro
#> # A tibble: 11 × 4
#>    codigo nome                  sistema       vacas
#>    <chr>  <chr>                 <chr>         <dbl>
#>  1 FZ01   Fazenda Boa Esperança Semiconfinado    64
#>  2 FZ02   Fazenda Santa Luzia   Pasto           371
#>  3 FZ03   Fazenda Santo Antônio Semiconfinado   353
#>  4 FZ04   Fazenda Água Limpa    Pasto           187
#>  5 FZ05   Fazenda Monte Alegre  Semiconfinado   205
#>  6 FZ06   Fazenda São Jorge     Confinado       171
#>  7 FZ07   Fazenda Três Irmãos   Confinado       137
#>  8 FZ08   Fazenda Primavera     Semiconfinado   283
#>  9 FZ09   Fazenda Santa Rita    Confinado       351
#> 10 FZ10   Fazenda Capão Alto    Confinado       235
#> 11 FZ11   Fazenda Vale do Sol   Pasto           107
nrow(cadastro)
#> [1] 11
```
