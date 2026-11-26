#' Modelo para a variação anual
#'
#' Ajusta o modelo do trabalho intermediário. Os valores dos dados são o
#' produto de efeitos (porte, sistema, mês e ano), de modo que, no
#' logaritmo, eles se somam; o modelo é
#' `lm(log(litros_por_vaca) ~ ano + mes + sistema)`, ajustado aos meses com
#' registro e medida relativa positiva.
#'
#' @param dados A tabela arrumada, da classe `leitecoop`, com as colunas
#'   `ano`, `mes`, `sistema` e `litros_por_vaca`. Uma tabela sem essas
#'   colunas produz um erro da classe `leitecoop_erro_colunas`.
#'
#' @returns Um objeto da classe `lm`.
#'
#' @seealso [variacao_anual()], que extrai a variação anual estimada.
#'
#' @family modelo
#' @export
#'
#' @examples
#' modelo <- ajustar_modelo(leite_fazendas)
#' coef(modelo)
ajustar_modelo <- function(dados) {
  verificar_colunas(dados, c("ano", "mes", "sistema", "litros_por_vaca"))
  dados_modelo <- tibble::as_tibble(dados)
  manter <- !is.na(dados_modelo$litros_por_vaca) &
    dados_modelo$litros_por_vaca > 0
  dados_modelo <- dados_modelo[manter, ]
  stats::lm(log(litros_por_vaca) ~ ano + mes + sistema, data = dados_modelo)
}

#' Variação anual estimada
#'
#' Transforma o coeficiente de `ano` do modelo de [ajustar_modelo()] na
#' variação anual, em proporção, com `exp(coef) - 1`, e faz o mesmo com os
#' limites do intervalo de confiança.
#'
#' @param modelo Um objeto da classe `lm` com o coeficiente `ano`, como o
#'   devolvido por [ajustar_modelo()]. Outro objeto produz um erro da
#'   classe `leitecoop_erro_modelo`.
#' @param nivel Nível de confiança do intervalo, entre 0 e 1.
#'
#' @returns Um `tibble` com uma linha e as colunas `variacao`, `inferior` e
#'   `superior`, em proporção (multiplique por 100 para ter a
#'   porcentagem).
#'
#' @family modelo
#' @export
#'
#' @examples
#' variacao_anual(ajustar_modelo(leite_fazendas))
variacao_anual <- function(modelo, nivel = 0.95) {
  if (!inherits(modelo, "lm") || !"ano" %in% names(stats::coef(modelo))) {
    rlang::abort(
      "`modelo` precisa ser um modelo `lm` com o coeficiente `ano`.",
      class = "leitecoop_erro_modelo"
    )
  }
  if (!is.numeric(nivel) || length(nivel) != 1 || nivel <= 0 || nivel >= 1) {
    rlang::abort(
      "`nivel` precisa ser um n\u00famero entre 0 e 1.",
      class = "leitecoop_erro_modelo"
    )
  }
  estimativa <- stats::coef(modelo)[["ano"]]
  intervalo <- stats::confint(modelo, "ano", level = nivel)
  tibble::tibble(
    variacao = exp(estimativa) - 1,
    inferior = exp(intervalo[1, 1]) - 1,
    superior = exp(intervalo[1, 2]) - 1
  )
}
