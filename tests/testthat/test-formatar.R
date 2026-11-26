test_that("formatar_numero() usa virgula decimal e ponto de milhar", {
  expect_equal(formatar_numero(18870.1), "18.870,1")
  expect_equal(formatar_numero(21661), "21.661,0")
  expect_equal(formatar_numero(0.65789, digitos = 2), "0,66")
  expect_equal(formatar_numero(15, digitos = 0), "15")
  expect_equal(formatar_numero(c(1234567.891, 2.5), digitos = 2),
               c("1.234.567,89", "2,50"))
})

test_that("formatar_numero() nao usa notacao cientifica", {
  expect_equal(formatar_numero(60204.3), "60.204,3")
  expect_false(grepl("e", formatar_numero(1e8)))
})

test_that("formatar_numero() valida os argumentos", {
  expect_error(formatar_numero("10"), class = "leitecoop_erro_argumento")
  expect_error(formatar_numero(10, digitos = -1),
               class = "leitecoop_erro_argumento")
  expect_error(formatar_numero(10, digitos = 1.5),
               class = "leitecoop_erro_argumento")
  expect_error(formatar_numero(10, digitos = c(1, 2)),
               class = "leitecoop_erro_argumento")
})
