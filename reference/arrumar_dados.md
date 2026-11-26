# Arrumação das medições e junção ao cadastro

Leva os arquivos anuais empilhados à tabela arrumada: passa a tabela
para a forma longa, com uma linha por fazenda, ano e mês; transforma o
mês em fator, na ordem do calendário; junta a tabela ao cadastro,
mantendo todas as linhas das medições e conferindo a cardinalidade (cada
fazenda medida tem exatamente uma linha no cadastro); e cria a medida
relativa, o leite do mês dividido pelo número de vacas.

## Uso

``` r
arrumar_dados(leite_bruto = ler_anuais(), cadastro = ler_cadastro())
```

## Argumentos

- leite_bruto:

  Tabela com os anos empilhados, como a devolvida por
  [`ler_anuais()`](https://l4ur419.github.io/tdr-projeto/reference/ler_anuais.md),
  com as colunas `ano`, `codigo` e `jan` a `dez`. O padrão é a leitura
  dos arquivos que acompanham o pacote.

- cadastro:

  Tabela do cadastro, como a devolvida por
  [`ler_cadastro()`](https://l4ur419.github.io/tdr-projeto/reference/ler_cadastro.md).
  O padrão é a leitura do cadastro do pacote.

## Valor

Um objeto da classe `leitecoop` (veja
[leitecoop-metodos](https://l4ur419.github.io/tdr-projeto/reference/leitecoop-metodos.md)),
que continua sendo um `tibble`, com uma linha por fazenda, ano e mês e
as colunas `origem`, `ano`, `codigo`, `mes` (fator ordenado pelo
calendário), `leite`, `nome`, `sistema`, `vacas` e `litros_por_vaca`.
Uma tabela sem as colunas esperadas produz um erro da classe
`leitecoop_erro_colunas`.

## Detalhes

O leite está em milhares de litros, de modo que a medida relativa,
`litros_por_vaca`, está em mil litros por vaca no mês. Os meses sem
registro continuam `NA` (veja a seção "Meses sem registro" em
[leitecoop-package](https://l4ur419.github.io/tdr-projeto/reference/leitecoop-package.md)).

A junção é um `left_join()` com `relationship = "many-to-one"`: antes
dela, a função confere que o cadastro não tem códigos repetidos e que
todo código medido existe no cadastro, e para com um erro da classe
`leitecoop_erro_cadastro` se não for o caso. Por isso a junção não muda
o número de linhas.

## Exemplos

``` r
dados <- arrumar_dados()
dados
#> Leite de 10 fazendas em 3 anos (2023 a 2025), com 9 meses sem registro
#> # A tibble: 360 × 9
#>    origem           ano codigo mes   leite nome    sistema vacas litros_por_vaca
#>    <chr>          <int> <chr>  <fct> <dbl> <chr>   <chr>   <dbl>           <dbl>
#>  1 leite_2023.csv  2023 FZ02   jan    190. Fazend… Pasto     371           0.512
#>  2 leite_2023.csv  2023 FZ02   fev    182. Fazend… Pasto     371           0.490
#>  3 leite_2023.csv  2023 FZ02   mar    202  Fazend… Pasto     371           0.544
#>  4 leite_2023.csv  2023 FZ02   abr    168  Fazend… Pasto     371           0.453
#>  5 leite_2023.csv  2023 FZ02   mai    164. Fazend… Pasto     371           0.443
#>  6 leite_2023.csv  2023 FZ02   jun    198. Fazend… Pasto     371           0.535
#>  7 leite_2023.csv  2023 FZ02   jul    206. Fazend… Pasto     371           0.554
#>  8 leite_2023.csv  2023 FZ02   ago    226. Fazend… Pasto     371           0.609
#>  9 leite_2023.csv  2023 FZ02   set    220. Fazend… Pasto     371           0.592
#> 10 leite_2023.csv  2023 FZ02   out    224. Fazend… Pasto     371           0.602
#> # ℹ 350 more rows
nrow(dados)
#> [1] 360

# As leituras também podem ser passadas explicitamente:
dados <- arrumar_dados(ler_anuais(), ler_cadastro())
```
