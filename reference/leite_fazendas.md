# Leite entregue pelas fazendas de uma cooperativa

Tabela arrumada do leite entregue a cada mês, de 2023 a 2025, pelas dez
fazendas com medição de uma cooperativa, já juntada ao cadastro e com a
medida relativa. É o resultado de
[`arrumar_dados()`](https://l4ur419.github.io/tdr-projeto/reference/arrumar_dados.md)
aplicado aos arquivos de `inst/extdata/`, e tem a classe `leitecoop`
([leitecoop-metodos](https://l4ur419.github.io/tdr-projeto/reference/leitecoop-metodos.md)),
que continua sendo um `tibble`. Os dados são simulados, sorteados para o
login `l4ur419` do GitHub.

## Uso

``` r
leite_fazendas
```

## Formato

Um `tibble` da classe `leitecoop`, com 360 linhas (10 fazendas, 3 anos e
12 meses) e 9 colunas:

- origem:

  Nome do arquivo anual de onde veio a linha.

- ano:

  Ano da medição, inteiro, de 2023 a 2025.

- codigo:

  Identificador da fazenda, de `FZ02` a `FZ11`.

- mes:

  Mês da medição, fator com os níveis `jan` a `dez` na ordem do
  calendário.

- leite:

  Leite entregue no mês, em milhares de litros; `NA` no mês sem
  registro.

- nome:

  Nome da fazenda.

- sistema:

  Sistema de produção: Confinado, Semiconfinado ou Pasto.

- vacas:

  Porte da fazenda: número de vacas em lactação.

- litros_por_vaca:

  Medida relativa: `leite / vacas`, em mil litros por vaca no mês.

## Fonte

Dados simulados, distribuídos para a Lista 03 da disciplina no arquivo
`lista-03-l4ur419.zip`, de <https://fernandomayer.github.io/data/tdr/>.
Os arquivos brutos estão em `inst/extdata/`
([`caminho_dados()`](https://l4ur419.github.io/tdr-projeto/reference/caminho_dados.md)),
e o script que monta a tabela, em `data-raw/leite_fazendas.R`, no
repositório do pacote.

## Detalhes

Os 9 meses sem registro (2 em 2023, 5 em 2024 e 2 em 2025) continuam
`NA` nas colunas `leite` e `litros_por_vaca`: um mês sem registro é dado
ausente, e não produção zero.

## Exemplos

``` r
leite_fazendas
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
summary(leite_fazendas)
#> # A tibble: 3 × 5
#>     ano unidades linhas meses_sem_registro   soma
#>   <int>    <int>  <int>              <int>  <dbl>
#> 1  2023       10    120                  2 18870.
#> 2  2024       10    120                  5 19673.
#> 3  2025       10    120                  2 21661 
table(leite_fazendas$sistema, leite_fazendas$ano)
#>                
#>                 2023 2024 2025
#>   Confinado       48   48   48
#>   Pasto           36   36   36
#>   Semiconfinado   36   36   36
```
