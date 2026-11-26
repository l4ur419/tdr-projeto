test_that("ler_cadastro() le as unidades do cadastro do LEIA-ME.txt", {
  leia_me <- conferencia_leia_me()
  cadastro <- ler_cadastro()
  expect_s3_class(cadastro, "tbl_df")
  expect_equal(nrow(cadastro), leia_me$unidades_cadastro)
  expect_named(cadastro, c("codigo", "nome", "sistema", "vacas"))
  expect_type(cadastro$codigo, "character")
  expect_type(cadastro$vacas, "double")
})

test_that("ler_cadastro() le os acentos do Latin-1", {
  cadastro <- ler_cadastro()
  expect_true("Fazenda Boa Esperança" %in% cadastro$nome)
  expect_true("Fazenda Água Limpa" %in% cadastro$nome)
  expect_setequal(unique(cadastro$sistema),
                  c("Confinado", "Semiconfinado", "Pasto"))
})

test_that("ler_um_ano() le um arquivo anual com os tipos declarados", {
  leia_me <- conferencia_leia_me()
  ano <- ler_um_ano(caminho_dados("leite_2023.csv"))
  expect_equal(nrow(ano), leia_me$unidades_medicoes)
  expect_equal(ncol(ano), 13)
  expect_type(ano$codigo, "character")
  expect_true(all(vapply(ano[-1], is.double, logical(1))))
  # O "-" vira NA, e a virgula decimal e lida como decimal
  sem_registro <- leia_me$por_ano$meses_sem_registro[leia_me$por_ano$ano == 2023]
  expect_equal(sum(is.na(ano[-1])), sem_registro)
  expect_equal(ano$jan[ano$codigo == "FZ02"], 189.9)
})

test_that("ler_anuais() empilha os tres anos, com a origem e o ano", {
  leia_me <- conferencia_leia_me()
  bruto <- ler_anuais()
  expect_equal(nrow(bruto), 3 * leia_me$unidades_medicoes)
  expect_named(bruto, c("origem", "ano", "codigo", meses))
  expect_type(bruto$ano, "integer")
  expect_equal(sort(unique(bruto$ano)), 2023:2025)
  expect_equal(dplyr::n_distinct(bruto$codigo), leia_me$unidades_medicoes)
  expect_equal(unique(bruto$origem), arquivos_anuais)
})

test_that("ler_login() le o login do LEIA-ME.txt", {
  expect_equal(ler_login(), "l4ur419")
})

test_that("as leituras recusam arquivos inexistentes", {
  expect_error(ler_cadastro("nao-existe.csv"),
               class = "leitecoop_erro_arquivo")
  expect_error(ler_um_ano("nao-existe.csv"),
               class = "leitecoop_erro_arquivo")
  expect_error(ler_anuais(c(caminho_dados("leite_2023.csv"), "nao.csv")),
               class = "leitecoop_erro_arquivo")
  expect_error(ler_login("nao-existe.txt"),
               class = "leitecoop_erro_arquivo")
  expect_error(ler_um_ano(caminho_dados(arquivos_anuais)),
               class = "leitecoop_erro_arquivo")
})

test_that("as leituras recusam tabelas sem as colunas esperadas", {
  sem_vacas <- tempfile(fileext = ".csv")
  writeLines(c("codigo;nome;sistema", "FZ01;A;Pasto"), sem_vacas)
  expect_error(suppressWarnings(ler_cadastro(sem_vacas)),
               class = "leitecoop_erro_colunas")

  sem_meses <- tempfile(fileext = ".csv")
  writeLines(c("codigo;jan;fev", "FZ01;1,5;2,0"), sem_meses)
  expect_error(ler_um_ano(sem_meses), class = "leitecoop_erro_colunas")
})

test_that("ler_login() recusa um arquivo sem o login", {
  sem_login <- tempfile(fileext = ".txt")
  writeLines("Outro arquivo qualquer", sem_login)
  expect_error(ler_login(sem_login), class = "leitecoop_erro_arquivo")
})
