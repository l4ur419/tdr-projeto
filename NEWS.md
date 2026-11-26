# leitecoop 0.1.0

Primeira versão, com a análise do trabalho intermediário transformada em
pacote.

* Os cinco arquivos brutos da Lista 03 (login `l4ur419`) em
  `inst/extdata/`, sem alteração, e a `caminho_dados()`, que os encontra.
* Leitura declarada do cadastro e dos arquivos anuais: `ler_cadastro()`,
  `ler_um_ano()`, `ler_anuais()` e `ler_login()`.
* Arrumação com `arrumar_dados()` (forma longa, mês como fator, junção ao
  cadastro com a cardinalidade conferida e medida relativa) e
  `achar_sem_medicao()`.
* A classe `leitecoop`, com os métodos `print()`, `summary()` e `plot()`.
* Resumos por fazenda, sistema, ano, mês e ano e mês (`resumir_*()`), os
  gráficos `grafico_sazonal()` e `grafico_categorias()`, o modelo opcional
  (`ajustar_modelo()` e `variacao_anual()`) e a `formatar_numero()`.
* Erros de classe própria (`leitecoop_erro_*`) na validação dos
  argumentos.
* O conjunto de dados `leite_fazendas`, montado por
  `data-raw/leite_fazendas.R`.
* A vinheta em Quarto, os testes com o `testthat`, a verificação no GitHub
  Actions e o site com o `pkgdown`.
