# o print() escreve a linha de resumo antes da tabela

    Code
      print(leite_fazendas)
    Output
      Leite de 10 fazendas em 3 anos (2023 a 2025), com 9 meses sem registro
      # A tibble: 360 x 9
         origem           ano codigo mes   leite nome    sistema vacas litros_por_vaca
         <chr>          <int> <chr>  <fct> <dbl> <chr>   <chr>   <dbl>           <dbl>
       1 leite_2023.csv  2023 FZ02   jan    190. Fazend~ Pasto     371           0.512
       2 leite_2023.csv  2023 FZ02   fev    182. Fazend~ Pasto     371           0.490
       3 leite_2023.csv  2023 FZ02   mar    202  Fazend~ Pasto     371           0.544
       4 leite_2023.csv  2023 FZ02   abr    168  Fazend~ Pasto     371           0.453
       5 leite_2023.csv  2023 FZ02   mai    164. Fazend~ Pasto     371           0.443
       6 leite_2023.csv  2023 FZ02   jun    198. Fazend~ Pasto     371           0.535
       7 leite_2023.csv  2023 FZ02   jul    206. Fazend~ Pasto     371           0.554
       8 leite_2023.csv  2023 FZ02   ago    226. Fazend~ Pasto     371           0.609
       9 leite_2023.csv  2023 FZ02   set    220. Fazend~ Pasto     371           0.592
      10 leite_2023.csv  2023 FZ02   out    224. Fazend~ Pasto     371           0.602
      # i 350 more rows

# a linha de resumo usa o singular e trata tabelas incompletas

    Code
      print(uma, n = 3)
    Output
      Leite de 1 fazenda em 1 ano (2023), com 1 mês sem registro
      # A tibble: 12 x 9
        origem           ano codigo mes   leite nome     sistema vacas litros_por_vaca
        <chr>          <int> <chr>  <fct> <dbl> <chr>    <chr>   <dbl>           <dbl>
      1 leite_2023.csv  2023 FZ05   jan    111. Fazenda~ Semico~   205           0.543
      2 leite_2023.csv  2023 FZ05   fev    110. Fazenda~ Semico~   205           0.537
      3 leite_2023.csv  2023 FZ05   mar    106. Fazenda~ Semico~   205           0.515
      # i 9 more rows

---

    Code
      print(leite_fazendas[0, ])
    Output
      Leite de 0 fazendas em 0 anos (sem anos), com 0 meses sem registro
      # A tibble: 0 x 9
      # i 9 variables: origem <chr>, ano <int>, codigo <chr>, mes <fct>, leite <dbl>,
      #   nome <chr>, sistema <chr>, vacas <dbl>, litros_por_vaca <dbl>

---

    Code
      print(leite_fazendas[, c("nome", "sistema")], n = 2)
    Output
      Leite das fazendas da cooperativa (tabela sem código, ano ou leite)
      # A tibble: 360 x 2
        nome                sistema
        <chr>               <chr>  
      1 Fazenda Santa Luzia Pasto  
      2 Fazenda Santa Luzia Pasto  
      # i 358 more rows

