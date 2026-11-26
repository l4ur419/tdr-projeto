# Changelog

## leitecoop 0.1.0

Primeira versão, com a análise do trabalho intermediário transformada em
pacote.

- Os cinco arquivos brutos da Lista 03 (login `l4ur419`) em
  `inst/extdata/`, sem alteração, e a
  [`caminho_dados()`](https://l4ur419.github.io/tdr-projeto/reference/caminho_dados.md),
  que os encontra.
- Leitura declarada do cadastro e dos arquivos anuais:
  [`ler_cadastro()`](https://l4ur419.github.io/tdr-projeto/reference/ler_cadastro.md),
  [`ler_um_ano()`](https://l4ur419.github.io/tdr-projeto/reference/ler_um_ano.md),
  [`ler_anuais()`](https://l4ur419.github.io/tdr-projeto/reference/ler_anuais.md)
  e
  [`ler_login()`](https://l4ur419.github.io/tdr-projeto/reference/ler_login.md).
- Arrumação com
  [`arrumar_dados()`](https://l4ur419.github.io/tdr-projeto/reference/arrumar_dados.md)
  (forma longa, mês como fator, junção ao cadastro com a cardinalidade
  conferida e medida relativa) e
  [`achar_sem_medicao()`](https://l4ur419.github.io/tdr-projeto/reference/achar_sem_medicao.md).
- A classe `leitecoop`, com os métodos
  [`print()`](https://rdrr.io/r/base/print.html),
  [`summary()`](https://rdrr.io/r/base/summary.html) e
  [`plot()`](https://rdrr.io/r/graphics/plot.default.html).
- Resumos por fazenda, sistema, ano, mês e ano e mês (`resumir_*()`), os
  gráficos
  [`grafico_sazonal()`](https://l4ur419.github.io/tdr-projeto/reference/grafico_sazonal.md)
  e
  [`grafico_categorias()`](https://l4ur419.github.io/tdr-projeto/reference/grafico_categorias.md),
  o modelo opcional
  ([`ajustar_modelo()`](https://l4ur419.github.io/tdr-projeto/reference/ajustar_modelo.md)
  e
  [`variacao_anual()`](https://l4ur419.github.io/tdr-projeto/reference/variacao_anual.md))
  e a
  [`formatar_numero()`](https://l4ur419.github.io/tdr-projeto/reference/formatar_numero.md).
- Erros de classe própria (`leitecoop_erro_*`) na validação dos
  argumentos.
- O conjunto de dados `leite_fazendas`, montado por
  `data-raw/leite_fazendas.R`.
- A vinheta em Quarto, os testes com o `testthat`, a verificação no
  GitHub Actions e o site com o `pkgdown`.
