# Leitura de um arquivo anual de medições

Lê um dos arquivos anuais, com uma linha por fazenda e uma coluna por
mês. O arquivo é separado por ponto e vírgula, usa a vírgula como
separador decimal e marca o mês sem registro com `"-"`, que é lido como
`NA`; o `codigo` é lido como texto e os doze meses, como números.

## Uso

``` r
ler_um_ano(arquivo)
```

## Argumentos

- arquivo:

  Caminho de um arquivo anual, como os que
  `caminho_dados("leite_2023.csv")` devolve.

## Valor

Um `tibble` com uma linha por fazenda com medição e 13 colunas: `codigo`
e os meses `jan` a `dez`, com o leite entregue no mês, em milhares de
litros. Um arquivo que não existe produz um erro da classe
`leitecoop_erro_arquivo`, e uma tabela sem as colunas esperadas, um erro
da classe `leitecoop_erro_colunas`.

## Veja também

[`ler_anuais()`](https://l4ur419.github.io/tdr-projeto/reference/ler_anuais.md),
que lê e empilha os três anos.

## Exemplos

``` r
ler_um_ano(caminho_dados("leite_2023.csv"))
#> # A tibble: 10 × 13
#>    codigo   jan   fev   mar   abr   mai   jun   jul   ago   set   out   nov
#>    <chr>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 FZ02   190.  182.  202   168   164.  198.  206.  226.  220.  224.  227. 
#>  2 FZ03   261.  260.  244.  223.  239.  251.  257.  268.  273.  278.  292. 
#>  3 FZ04    98.1  92.5  88.1  75.4  83.9  83.8 101.   98.8 109.  123   116. 
#>  4 FZ05   111.  110.  106.   99.5  NA    93.1 103.  105   114.  117.  133. 
#>  5 FZ06   136.  129.  117   133.  134   120.  121.  146.  152.  138.  151. 
#>  6 FZ07   113   110.  108.  109.   86   111.  104.   89.4 114.  122.  100. 
#>  7 FZ08   174.  174   202.  151.  163.  164.  158.  171.  185   195.  195  
#>  8 FZ09   263.  270.  253.  241   209.  238.  245.  259.  294.  286.  291  
#>  9 FZ10   183   193.  170   188.  173.  186.  176.  187.  197.  210.  195. 
#> 10 FZ11    49.9  48.3  49.6  NA    55.6  49.9  48.3  54.9  55.1  61.3  60.3
#> # ℹ 1 more variable: dez <dbl>
```
