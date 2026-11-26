#' Número no formato brasileiro
#'
#' Arredonda e formata números com vírgula decimal e ponto de milhar, para
#' citá-los em texto, como no código em linha de um documento Quarto, sem
#' a notação científica que o R usaria para números grandes.
#'
#' @param x Vetor numérico. Outro tipo produz um erro da classe
#'   `leitecoop_erro_argumento`.
#' @param digitos Número de casas decimais, inteiro não negativo.
#'
#' @returns Um vetor de caracteres do comprimento de `x`.
#'
#' @export
#'
#' @examples
#' formatar_numero(18870.1)
#' formatar_numero(0.65789, digitos = 2)
#' formatar_numero(c(1234567.891, 2.5), digitos = 2)
formatar_numero <- function(x, digitos = 1) {
  if (!is.numeric(x)) {
    rlang::abort(
      "`x` precisa ser num\u00e9rico.",
      class = "leitecoop_erro_argumento"
    )
  }
  if (!is.numeric(digitos) || length(digitos) != 1 || is.na(digitos) ||
        digitos < 0 || digitos != round(digitos)) {
    rlang::abort(
      "`digitos` precisa ser um n\u00famero inteiro n\u00e3o negativo.",
      class = "leitecoop_erro_argumento"
    )
  }
  vapply(
    x,
    function(valor) {
      format(round(valor, digitos), nsmall = digitos, trim = TRUE,
             big.mark = ".", decimal.mark = ",", scientific = FALSE)
    },
    character(1)
  )
}
