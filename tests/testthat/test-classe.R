test_that("o print() escreve a linha de resumo antes da tabela", {
  expect_snapshot(print(leite_fazendas))
})

test_that("a linha de resumo usa o singular e trata tabelas incompletas", {
  uma <- leite_fazendas[leite_fazendas$codigo == "FZ05" &
                          leite_fazendas$ano == 2023, ]
  expect_snapshot(print(uma, n = 3))
  expect_snapshot(print(leite_fazendas[0, ]))
  expect_snapshot(print(leite_fazendas[, c("nome", "sistema")], n = 2))
})

test_that("o print() devolve o objeto de forma invisivel", {
  saida <- utils::capture.output(
    resultado <- withVisible(print(leite_fazendas))
  )
  expect_false(resultado$visible)
  expect_identical(resultado$value, leite_fazendas)
  expect_match(saida[1], "^Leite de 10 fazendas em 3 anos")
})

test_that("uma selecao de linhas continua sendo da classe", {
  pasto <- leite_fazendas[leite_fazendas$sistema == "Pasto", ]
  expect_s3_class(pasto, "leitecoop")
  filtrada <- dplyr::filter(leite_fazendas, ano == 2024)
  expect_s3_class(filtrada, "leitecoop")
  expect_s3_class(filtrada, "tbl_df")
})

test_that("a classe tem os metodos print, summary e plot", {
  metodos <- as.character(utils::methods(class = "leitecoop"))
  expect_true(all(c("print.leitecoop", "summary.leitecoop",
                    "plot.leitecoop") %in% metodos))
})

test_that("o summary() devolve a conferencia do LEIA-ME.txt", {
  leia_me <- conferencia_leia_me()
  conferencia <- summary(leite_fazendas)
  expect_s3_class(conferencia, "tbl_df")
  expect_false(inherits(conferencia, "leitecoop"))
  expect_named(conferencia, c("ano", "unidades", "linhas",
                              "meses_sem_registro", "soma"))
  expect_equal(conferencia$ano, leia_me$por_ano$ano)
  expect_equal(conferencia$unidades, rep(leia_me$unidades_medicoes, 3))
  expect_equal(conferencia$linhas, rep(leia_me$unidades_medicoes * 12, 3))
  expect_equal(conferencia$meses_sem_registro,
               leia_me$por_ano$meses_sem_registro)
  expect_equal(conferencia$soma, leia_me$por_ano$soma)
})

test_that("o summary() recusa tabela sem as colunas necessarias", {
  expect_error(summary(leite_fazendas[, c("nome", "sistema")]),
               class = "leitecoop_erro_colunas")
})

test_that("o plot() desenha a sazonalidade e devolve o grafico", {
  grDevices::pdf(NULL)
  on.exit(grDevices::dev.off(), add = TRUE)
  expect_invisible(grafico <- plot(leite_fazendas))
  expect_s3_class(grafico, "ggplot")
  expect_equal(nrow(grafico$data), 36)
})

test_that("o plot() recusa tabela sem as colunas necessarias", {
  expect_error(plot(leite_fazendas[, c("nome", "sistema")]),
               class = "leitecoop_erro_colunas")
})

test_that("a linha de resumo trata um ano, tabela vazia e tabela sem colunas", {
  uma <- leite_fazendas[leite_fazendas$codigo == "FZ05" &
                          leite_fazendas$ano == 2023, ]
  expect_equal(
    linha_resumo(uma),
    "Leite de 1 fazenda em 1 ano (2023), com 1 m\u00eas sem registro"
  )
  expect_equal(
    linha_resumo(leite_fazendas[0, ]),
    "Leite de 0 fazendas em 0 anos (sem anos), com 0 meses sem registro"
  )
  expect_match(linha_resumo(leite_fazendas[, c("nome", "sistema")]),
               "^Leite das fazendas da cooperativa")
})
