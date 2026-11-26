test_that("grafico_sazonal() desenha uma linha por ano", {
  g <- grafico_sazonal(resumir_sazonal(leite_fazendas))
  expect_s3_class(g, "ggplot")
  expect_equal(nrow(g$data), 36)
  expect_s3_class(g$data$ano, "factor")
  expect_equal(g$labels$colour, "Ano")
})

test_that("grafico_sazonal() aceita o ano como numero", {
  resumo <- resumir_sazonal(leite_fazendas)
  resumo$ano <- as.integer(as.character(resumo$ano))
  g <- grafico_sazonal(resumo)
  expect_s3_class(g$data$ano, "factor")
})

test_that("grafico_categorias() deixa de fora os meses sem registro", {
  g <- grafico_categorias(leite_fazendas)
  expect_s3_class(g, "ggplot")
  expect_equal(nrow(g$data), sum(!is.na(leite_fazendas$litros_por_vaca)))
  expect_false(anyNA(g$data$litros_por_vaca))
})

test_that("os graficos recusam tabelas sem as colunas necessarias", {
  expect_error(grafico_sazonal(leite_fazendas),
               class = "leitecoop_erro_colunas")
  expect_error(grafico_categorias(ler_cadastro()),
               class = "leitecoop_erro_colunas")
})
