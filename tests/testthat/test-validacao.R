test_that("verificar_arquivo() aceita arquivos que existem", {
  arquivo <- caminho_dados("cadastro.csv")
  expect_invisible(verificar_arquivo(arquivo))
  expect_equal(verificar_arquivo(arquivo), arquivo)
})

test_that("verificar_arquivo() recusa argumento invalido ou arquivo ausente", {
  expect_error(verificar_arquivo(NULL), class = "leitecoop_erro_arquivo")
  expect_error(verificar_arquivo(42), class = "leitecoop_erro_arquivo")
  expect_error(verificar_arquivo("nao-existe.csv"),
               class = "leitecoop_erro_arquivo")
})

test_that("verificar_colunas() aceita tabelas com as colunas pedidas", {
  expect_invisible(verificar_colunas(cars, "speed"))
})

test_that("verificar_colunas() recusa o que nao e tabela ou nao tem as colunas", {
  expect_error(verificar_colunas(list(a = 1), "a"),
               class = "leitecoop_erro_colunas")
  expect_error(verificar_colunas(cars, c("speed", "peso")),
               class = "leitecoop_erro_colunas")
})

test_that("os erros de classe propria trazem a mensagem e a classe do rlang", {
  erro <- tryCatch(caminho_dados("x.csv"), error = function(e) e)
  expect_s3_class(erro, c("leitecoop_erro_arquivo", "rlang_error"))
  expect_match(conditionMessage(erro), "x.csv", fixed = TRUE)
})
