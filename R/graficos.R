#' Gráfico de sazonalidade
#'
#' Desenha a média mensal da medida relativa (mil litros por vaca), com
#' uma linha para cada ano.
#'
#' @param resumo O resumo por ano e mês, como o devolvido por
#'   [resumir_sazonal()], com as colunas `ano`, `mes` e `media_relativa`.
#'   Uma tabela sem essas colunas produz um erro da classe
#'   `leitecoop_erro_colunas`.
#'
#' @returns Um objeto do `ggplot2`, desenhado ao ser impresso.
#'
#' @family graficos
#' @export
#'
#' @examples
#' grafico_sazonal(resumir_sazonal(leite_fazendas))
grafico_sazonal <- function(resumo) {
  verificar_colunas(resumo, c("ano", "mes", "media_relativa"))
  resumo$ano <- factor(resumo$ano)
  ggplot2::ggplot(
    resumo,
    ggplot2::aes(
      x = .data$mes,
      y = .data$media_relativa,
      colour = .data$ano,
      group = .data$ano
    )
  ) +
    ggplot2::geom_line(linewidth = 0.8) +
    ggplot2::geom_point(size = 2) +
    ggplot2::labs(
      x = "M\u00eas",
      y = "M\u00e9dia mensal (mil litros por vaca)",
      colour = "Ano"
    ) +
    ggplot2::theme_minimal()
}

#' Gráfico da medida relativa por sistema
#'
#' Desenha a distribuição da medida relativa (mil litros por vaca no mês)
#' em cada sistema de produção, com os três anos juntos. Os meses sem
#' registro ficam de fora.
#'
#' @param dados A tabela arrumada, da classe `leitecoop`, com as colunas
#'   `sistema` e `litros_por_vaca`. Uma tabela sem essas colunas produz um
#'   erro da classe `leitecoop_erro_colunas`.
#'
#' @returns Um objeto do `ggplot2`, desenhado ao ser impresso.
#'
#' @family graficos
#' @export
#'
#' @examples
#' grafico_categorias(leite_fazendas)
grafico_categorias <- function(dados) {
  verificar_colunas(dados, c("sistema", "litros_por_vaca"))
  dados <- tibble::as_tibble(dados)
  dados <- dados[!is.na(dados$litros_por_vaca), ]
  ggplot2::ggplot(
    dados,
    ggplot2::aes(x = .data$sistema, y = .data$litros_por_vaca)
  ) +
    ggplot2::geom_boxplot(fill = "grey90") +
    ggplot2::labs(x = "Sistema", y = "Mil litros por vaca no m\u00eas") +
    ggplot2::theme_minimal()
}
