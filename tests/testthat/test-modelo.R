test_that("ajustar_modelo() ajusta o modelo log-linear aos meses registrados", {
  modelo <- ajustar_modelo(leite_fazendas)
  expect_s3_class(modelo, "lm")
  expect_true("ano" %in% names(stats::coef(modelo)))
  expect_equal(stats::nobs(modelo), sum(!is.na(leite_fazendas$leite)))
})

test_that("variacao_anual() transforma o coeficiente de ano", {
  modelo <- ajustar_modelo(leite_fazendas)
  v <- variacao_anual(modelo)
  expect_s3_class(v, "tbl_df")
  expect_named(v, c("variacao", "inferior", "superior"))
  expect_equal(v$variacao, exp(stats::coef(modelo)[["ano"]]) - 1)
  expect_true(v$inferior < v$variacao && v$variacao < v$superior)

  v90 <- variacao_anual(modelo, nivel = 0.90)
  expect_equal(v90$variacao, v$variacao)
  expect_true(v90$superior - v90$inferior < v$superior - v$inferior)
})

test_that("variacao_anual() e ajustar_modelo() validam os argumentos", {
  expect_error(variacao_anual("modelo"), class = "leitecoop_erro_modelo")
  expect_error(variacao_anual(stats::lm(dist ~ speed, data = cars)),
               class = "leitecoop_erro_modelo")
  modelo <- ajustar_modelo(leite_fazendas)
  expect_error(variacao_anual(modelo, nivel = 1.5),
               class = "leitecoop_erro_modelo")
  expect_error(ajustar_modelo(ler_cadastro()),
               class = "leitecoop_erro_colunas")
})
