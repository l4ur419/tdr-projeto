test_that("arrumar_dados() reproduz linhas, ausentes e somas do LEIA-ME.txt", {
  leia_me <- conferencia_leia_me()
  dados <- arrumar_dados()

  # Uma linha por unidade com medicao, ano e mes
  expect_equal(nrow(dados), leia_me$unidades_medicoes * 3 * 12)

  por_ano <- dplyr::summarise(
    tibble::as_tibble(dados),
    unidades = dplyr::n_distinct(codigo),
    meses_sem_registro = sum(is.na(leite)),
    soma = sum(leite, na.rm = TRUE),
    .by = "ano"
  )
  por_ano <- por_ano[order(por_ano$ano), ]
  expect_equal(por_ano$ano, leia_me$por_ano$ano)
  expect_equal(por_ano$unidades, rep(leia_me$unidades_medicoes, 3))
  expect_equal(por_ano$meses_sem_registro, leia_me$por_ano$meses_sem_registro)
  expect_equal(por_ano$soma, leia_me$por_ano$soma)
})

test_that("os numeros do LEIA-ME.txt sao os esperados", {
  leia_me <- conferencia_leia_me()
  expect_equal(leia_me$unidades_cadastro, 11)
  expect_equal(leia_me$unidades_medicoes, 10)
  expect_equal(leia_me$por_ano$meses_sem_registro, c(2, 5, 2))
  expect_equal(leia_me$por_ano$soma, c(18870.1, 19673.2, 21661.0))
})

test_that("arrumar_dados() devolve a classe, as colunas e o mes ordenado", {
  dados <- arrumar_dados()
  expect_s3_class(dados, "leitecoop")
  expect_s3_class(dados, "tbl_df")
  expect_equal(class(dados)[1], "leitecoop")
  expect_named(dados, c("origem", "ano", "codigo", "mes", "leite", "nome",
                        "sistema", "vacas", "litros_por_vaca"))
  expect_s3_class(dados$mes, "factor")
  expect_equal(levels(dados$mes), meses)
})

test_that("a juncao nao muda o numero de linhas e traz o cadastro", {
  bruto <- ler_anuais()
  dados <- arrumar_dados(bruto, ler_cadastro())
  expect_equal(nrow(dados), nrow(bruto) * 12)
  expect_false(anyNA(dados$vacas))
  expect_false(anyNA(dados$sistema))
})

test_that("a medida relativa e o leite dividido pelas vacas", {
  dados <- arrumar_dados()
  expect_equal(dados$litros_por_vaca, dados$leite / dados$vacas)
  expect_equal(sum(is.na(dados$litros_por_vaca)), sum(is.na(dados$leite)))
})

test_that("arrumar_dados() recusa cadastro com codigos repetidos ou faltando", {
  bruto <- ler_anuais()
  cadastro <- ler_cadastro()

  repetido <- rbind(cadastro, cadastro[2, ])
  expect_error(arrumar_dados(bruto, repetido),
               class = "leitecoop_erro_cadastro")

  sem_fz02 <- cadastro[cadastro$codigo != "FZ02", ]
  expect_error(arrumar_dados(bruto, sem_fz02),
               class = "leitecoop_erro_cadastro")
})

test_that("arrumar_dados() recusa tabelas sem as colunas esperadas", {
  bruto <- ler_anuais()
  cadastro <- ler_cadastro()
  expect_error(arrumar_dados(bruto[, -3], cadastro),
               class = "leitecoop_erro_colunas")
  expect_error(arrumar_dados(bruto, cadastro[, -4]),
               class = "leitecoop_erro_colunas")
  expect_error(arrumar_dados("leite", cadastro),
               class = "leitecoop_erro_colunas")
})

test_that("achar_sem_medicao() encontra a unica fazenda sem medicao", {
  leia_me <- conferencia_leia_me()
  sem <- achar_sem_medicao()
  expect_equal(nrow(sem),
               leia_me$unidades_cadastro - leia_me$unidades_medicoes)
  expect_equal(sem$codigo, "FZ01")
  expect_equal(sem$nome, "Fazenda Boa Esperança")
  expect_error(achar_sem_medicao(list(), ler_anuais()),
               class = "leitecoop_erro_colunas")
})
