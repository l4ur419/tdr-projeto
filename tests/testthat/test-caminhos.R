test_that("caminho_dados() lista os cinco arquivos brutos", {
  expect_setequal(
    caminho_dados(),
    c("LEIA-ME.txt", "cadastro.csv", "leite_2023.csv", "leite_2024.csv",
      "leite_2025.csv")
  )
})

test_that("caminho_dados() devolve caminhos que existem", {
  um <- caminho_dados("cadastro.csv")
  expect_length(um, 1)
  expect_true(file.exists(um))
  expect_equal(basename(um), "cadastro.csv")

  dois <- caminho_dados(c("leite_2023.csv", "leite_2025.csv"))
  expect_length(dois, 2)
  expect_true(all(file.exists(dois)))
})

test_that("caminho_dados() recusa arquivo inexistente ou argumento invalido", {
  expect_error(caminho_dados("nao-existe.csv"),
               class = "leitecoop_erro_arquivo")
  expect_error(caminho_dados(c("cadastro.csv", "outro.csv")),
               class = "leitecoop_erro_arquivo")
  expect_error(caminho_dados(1), class = "leitecoop_erro_arquivo")
  expect_error(caminho_dados(character(0)), class = "leitecoop_erro_arquivo")
})
