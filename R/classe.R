# A tabela arrumada tem a classe "leitecoop" na frente das classes do
# tibble, de modo que continua sendo um tibble (e um data.frame).
nova_tabela_leite <- function(x) {
  x <- tibble::as_tibble(x)
  class(x) <- c("leitecoop", class(x))
  x
}

# Numero seguido da palavra no singular ou no plural.
plural <- function(n, singular, plural) {
  paste(n, if (n == 1) singular else plural)
}

# A linha de resumo que o print() escreve antes da tabela.
linha_resumo <- function(x) {
  if (!all(c("codigo", "ano", "leite") %in% names(x))) {
    return("Leite das fazendas da cooperativa (tabela sem c\u00f3digo, ano ou leite)")
  }
  anos <- sort(unique(x$ano))
  periodo <- if (length(anos) == 0) {
    "sem anos"
  } else if (length(anos) == 1) {
    as.character(anos)
  } else {
    paste(anos[1], "a", anos[length(anos)])
  }
  n_fazendas <- dplyr::n_distinct(x$codigo)
  n_ausentes <- sum(is.na(x$leite))
  paste0(
    "Leite de ", plural(n_fazendas, "fazenda", "fazendas"),
    " em ", plural(length(anos), "ano", "anos"), " (", periodo, "), com ",
    plural(n_ausentes, "m\u00eas sem registro", "meses sem registro")
  )
}

#' Métodos da classe `leitecoop`
#'
#' A tabela arrumada devolvida por [arrumar_dados()], e o conjunto de dados
#' [leite_fazendas], têm a classe `leitecoop` seguida das classes do
#' `tibble`, de modo que continuam sendo um `tibble`. A classe tem três
#' métodos:
#'
#' * `print()` escreve uma linha de resumo, com o número de fazendas, de
#'   anos e de meses sem registro, e passa ao `print()` do `tibble` com o
#'   [NextMethod()];
#' * `summary()` devolve a conferência por ano, a ser comparada com o
#'   `LEIA-ME.txt`: fazendas com medição, linhas, meses sem registro e
#'   soma dos valores registrados;
#' * `plot()` desenha a sazonalidade, com [grafico_sazonal()].
#'
#' @param x,object Um objeto da classe `leitecoop`.
#' @param ... Outros argumentos, passados ao `print()` do `tibble`, no
#'   `print()`, e ignorados nos demais.
#'
#' @returns O `print()` devolve `x`, de forma invisível. O `summary()`
#'   devolve um `tibble` com uma linha por ano e as colunas `ano`,
#'   `unidades`, `linhas`, `meses_sem_registro` e `soma` (mil litros). O
#'   `plot()` desenha o gráfico e devolve, de forma invisível, o objeto do
#'   `ggplot2`. Uma tabela sem as colunas necessárias produz, no
#'   `summary()` e no `plot()`, um erro da classe `leitecoop_erro_colunas`.
#'
#' @name leitecoop-metodos
#'
#' @examples
#' leite_fazendas
#' summary(leite_fazendas)
#' plot(leite_fazendas)
#'
#' # Uma seleção de linhas continua sendo da classe
#' pasto <- leite_fazendas[leite_fazendas$sistema == "Pasto", ]
#' class(pasto)
#' pasto
NULL

#' @rdname leitecoop-metodos
#' @export
print.leitecoop <- function(x, ...) {
  writeLines(linha_resumo(x))
  NextMethod()
}

#' @rdname leitecoop-metodos
#' @export
summary.leitecoop <- function(object, ...) {
  verificar_colunas(object, c("ano", "codigo", "leite"))
  object |>
    tibble::as_tibble() |>
    dplyr::summarise(
      unidades = dplyr::n_distinct(.data$codigo),
      linhas = dplyr::n(),
      meses_sem_registro = sum(is.na(.data$leite)),
      soma = sum(.data$leite, na.rm = TRUE),
      .by = "ano"
    ) |>
    dplyr::arrange(.data$ano)
}

#' @rdname leitecoop-metodos
#' @export
plot.leitecoop <- function(x, ...) {
  grafico <- grafico_sazonal(resumir_sazonal(x))
  print(grafico)
  invisible(grafico)
}
