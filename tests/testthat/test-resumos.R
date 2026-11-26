test_that("resumir_unidade() resume cada fazenda, da maior media para a menor", {
  leia_me <- conferencia_leia_me()
  r <- resumir_unidade(leite_fazendas)
  expect_named(r, c("codigo", "nome", "sistema", "meses_com_registro",
                    "total", "media_relativa"))
  expect_equal(nrow(r), leia_me$unidades_medicoes)
  expect_false(is.unsorted(rev(r$media_relativa)))
  expect_equal(sum(r$total), sum(leia_me$por_ano$soma))
  expect_equal(sum(r$meses_com_registro),
               nrow(leite_fazendas) - sum(leia_me$por_ano$meses_sem_registro))
  fz05 <- leite_fazendas[leite_fazendas$codigo == "FZ05", ]
  expect_equal(r$media_relativa[r$codigo == "FZ05"],
               mean(fz05$litros_por_vaca, na.rm = TRUE))
})

test_that("resumir_categoria() resume cada sistema", {
  leia_me <- conferencia_leia_me()
  r <- resumir_categoria(leite_fazendas)
  expect_named(r, c("sistema", "unidades", "total", "media_relativa"))
  expect_setequal(r$sistema, c("Confinado", "Semiconfinado", "Pasto"))
  expect_equal(sum(r$unidades), leia_me$unidades_medicoes)
  expect_equal(sum(r$total), sum(leia_me$por_ano$soma))
  expect_false(is.unsorted(rev(r$media_relativa)))
})

test_that("resumir_cat_ano() tem uma coluna por ano com as somas do LEIA-ME.txt", {
  leia_me <- conferencia_leia_me()
  r <- resumir_cat_ano(leite_fazendas)
  expect_named(r, c("sistema", "2023", "2024", "2025"))
  expect_equal(r$sistema, c("Confinado", "Pasto", "Semiconfinado"))
  expect_equal(unname(colSums(r[-1])), leia_me$por_ano$soma)
})

test_that("resumir_ano() resume cada ano, com os ausentes do LEIA-ME.txt", {
  leia_me <- conferencia_leia_me()
  r <- resumir_ano(leite_fazendas)
  expect_named(r, c("ano", "unidades", "meses_com_registro",
                    "meses_sem_registro", "total", "media_relativa"))
  expect_equal(r$ano, leia_me$por_ano$ano)
  expect_equal(r$meses_sem_registro, leia_me$por_ano$meses_sem_registro)
  expect_equal(r$meses_com_registro + r$meses_sem_registro,
               rep(leia_me$unidades_medicoes * 12, 3))
  expect_equal(r$total, leia_me$por_ano$soma)
})

test_that("resumir_mes() tem os doze meses na ordem do calendario", {
  r <- resumir_mes(leite_fazendas)
  expect_named(r, c("mes", "media_relativa"))
  expect_equal(as.character(r$mes), meses)
  jan <- leite_fazendas$litros_por_vaca[leite_fazendas$mes == "jan"]
  expect_equal(r$media_relativa[1], mean(jan, na.rm = TRUE))
})

test_that("resumir_sazonal() tem uma linha por ano e mes", {
  r <- resumir_sazonal(leite_fazendas)
  expect_named(r, c("ano", "mes", "media_relativa"))
  expect_equal(nrow(r), 36)
  expect_s3_class(r$ano, "factor")
  expect_equal(levels(r$ano), c("2023", "2024", "2025"))
  expect_false(anyNA(r$media_relativa))
})

test_that("os resumos devolvem tibbles sem a classe do pacote", {
  for (resumo in list(resumir_unidade, resumir_categoria, resumir_cat_ano,
                      resumir_ano, resumir_mes, resumir_sazonal)) {
    r <- resumo(leite_fazendas)
    expect_s3_class(r, "tbl_df")
    expect_false(inherits(r, "leitecoop"))
  }
})

test_that("os resumos recusam tabelas sem as colunas necessarias", {
  cadastro <- ler_cadastro()
  expect_error(resumir_unidade(cadastro), class = "leitecoop_erro_colunas")
  expect_error(resumir_categoria(cadastro), class = "leitecoop_erro_colunas")
  expect_error(resumir_cat_ano(cadastro), class = "leitecoop_erro_colunas")
  expect_error(resumir_ano(cadastro), class = "leitecoop_erro_colunas")
  expect_error(resumir_mes(cadastro), class = "leitecoop_erro_colunas")
  expect_error(resumir_sazonal(cadastro), class = "leitecoop_erro_colunas")
})
