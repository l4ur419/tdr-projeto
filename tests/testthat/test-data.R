test_that("leite_fazendas e a tabela arrumada dos arquivos do pacote", {
  # Confere que o data/ esta em dia com inst/extdata/ e com as funcoes
  expect_equal(leite_fazendas, arrumar_dados())
})

test_that("leite_fazendas tem a estrutura documentada", {
  expect_s3_class(leite_fazendas, "leitecoop")
  expect_s3_class(leite_fazendas, "tbl_df")
  expect_equal(dim(leite_fazendas), c(360L, 9L))
  expect_equal(sum(is.na(leite_fazendas$leite)), 9)
  expect_equal(range(leite_fazendas$ano), c(2023L, 2025L))
  expect_equal(sort(unique(leite_fazendas$codigo)),
               sprintf("FZ%02d", 2:11))
})
