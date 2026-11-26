test_that("as constantes internas descrevem os arquivos do pacote", {
  expect_length(meses, 12)
  expect_equal(meses[c(1, 12)], c("jan", "dez"))
  expect_true(all(arquivos_anuais %in% caminho_dados()))
  expect_named(ler_cadastro(), colunas_cadastro)
})
