#' Resumo por fazenda
#'
#' Resume cada fazenda nos três anos: meses com registro, total de leite e
#' média mensal da medida relativa, com o nome e o sistema de cada uma,
#' ordenado da maior média relativa para a menor.
#'
#' @section Meses sem registro:
#' Um mês sem registro é dado ausente, e não produção zero. Os totais e as
#' médias ignoram esses meses (`na.rm = TRUE`), e as contagens de meses com
#' e sem registro usam `is.na()`. A decisão afeta as colunas de total e de
#' média da medida relativa, mas não as de contagem de meses.
#'
#' @param dados A tabela arrumada, da classe `leitecoop`, como a devolvida
#'   por [arrumar_dados()] ou o conjunto [leite_fazendas]. Uma tabela sem
#'   as colunas usadas no resumo produz um erro da classe
#'   `leitecoop_erro_colunas`.
#'
#' @returns Um `tibble` com uma linha por fazenda e as colunas `codigo`,
#'   `nome`, `sistema`, `meses_com_registro`, `total` (mil litros) e
#'   `media_relativa` (mil litros por vaca no mês).
#'
#' @family resumos
#' @export
#'
#' @examples
#' resumir_unidade(leite_fazendas)
resumir_unidade <- function(dados) {
  verificar_colunas(dados, c("codigo", "nome", "sistema", "leite",
                             "litros_por_vaca"))
  dados |>
    tibble::as_tibble() |>
    dplyr::summarise(
      meses_com_registro = sum(!is.na(.data$leite)),
      total = sum(.data$leite, na.rm = TRUE),
      media_relativa = mean(.data$litros_por_vaca, na.rm = TRUE),
      .by = c("codigo", "nome", "sistema")
    ) |>
    dplyr::arrange(dplyr::desc(.data$media_relativa))
}

#' Resumo por sistema de produção
#'
#' Resume cada sistema de produção (a categoria das fazendas: Confinado,
#' Semiconfinado ou Pasto) nos três anos: número de fazendas, total de
#' leite e média mensal da medida relativa, da maior média para a menor.
#'
#' @inheritSection resumir_unidade Meses sem registro
#' @inheritParams resumir_unidade
#'
#' @returns Um `tibble` com uma linha por sistema e as colunas `sistema`,
#'   `unidades`, `total` (mil litros) e `media_relativa` (mil litros por
#'   vaca no mês).
#'
#' @family resumos
#' @export
#'
#' @examples
#' resumir_categoria(leite_fazendas)
resumir_categoria <- function(dados) {
  verificar_colunas(dados, c("codigo", "sistema", "leite",
                             "litros_por_vaca"))
  dados |>
    tibble::as_tibble() |>
    dplyr::summarise(
      unidades = dplyr::n_distinct(.data$codigo),
      total = sum(.data$leite, na.rm = TRUE),
      media_relativa = mean(.data$litros_por_vaca, na.rm = TRUE),
      .by = "sistema"
    ) |>
    dplyr::arrange(dplyr::desc(.data$media_relativa))
}

#' Total de cada sistema em cada ano
#'
#' A tabela de apresentação da Lista 03: o total de leite de cada sistema
#' em cada ano, com uma linha por sistema e uma coluna por ano. A soma de
#' cada coluna é a soma dos valores registrados no ano, do `LEIA-ME.txt`.
#'
#' @inheritSection resumir_unidade Meses sem registro
#' @inheritParams resumir_unidade
#'
#' @returns Um `tibble` com uma linha por sistema, em ordem alfabética, a
#'   coluna `sistema` e uma coluna por ano, com o total em mil litros.
#'
#' @family resumos
#' @export
#'
#' @examples
#' resumir_cat_ano(leite_fazendas)
resumir_cat_ano <- function(dados) {
  verificar_colunas(dados, c("sistema", "ano", "leite"))
  dados |>
    tibble::as_tibble() |>
    dplyr::summarise(
      total = sum(.data$leite, na.rm = TRUE),
      .by = c("sistema", "ano")
    ) |>
    dplyr::arrange(.data$sistema, .data$ano) |>
    tidyr::pivot_wider(names_from = "ano", values_from = "total")
}

#' Resumo por ano
#'
#' Resume cada ano: fazendas com medição, meses com e sem registro, total
#' de leite e média mensal da medida relativa. É a tabela da comparação
#' entre 2023 e 2025, que usa a média da medida relativa, e não o total:
#' o total soma apenas os meses registrados e depende do tamanho dos
#' rebanhos, e a média relativa considera só os meses registrados e
#' desconta o porte de cada fazenda.
#'
#' @inheritSection resumir_unidade Meses sem registro
#' @inheritParams resumir_unidade
#'
#' @returns Um `tibble` com uma linha por ano, em ordem crescente, e as
#'   colunas `ano`, `unidades`, `meses_com_registro`, `meses_sem_registro`,
#'   `total` (mil litros) e `media_relativa` (mil litros por vaca no mês).
#'
#' @family resumos
#' @export
#'
#' @examples
#' resumo <- resumir_ano(leite_fazendas)
#' resumo
#' # Variação percentual da média relativa entre o primeiro e o último ano
#' 100 * (resumo$media_relativa[3] / resumo$media_relativa[1] - 1)
resumir_ano <- function(dados) {
  verificar_colunas(dados, c("ano", "codigo", "leite", "litros_por_vaca"))
  dados |>
    tibble::as_tibble() |>
    dplyr::summarise(
      unidades = dplyr::n_distinct(.data$codigo),
      meses_com_registro = sum(!is.na(.data$leite)),
      meses_sem_registro = sum(is.na(.data$leite)),
      total = sum(.data$leite, na.rm = TRUE),
      media_relativa = mean(.data$litros_por_vaca, na.rm = TRUE),
      .by = "ano"
    ) |>
    dplyr::arrange(.data$ano)
}

#' Resumo por mês
#'
#' Calcula a média da medida relativa em cada mês, com os três anos
#' juntos. É o resumo que aponta o mês de maior e o de menor média.
#'
#' @inheritSection resumir_unidade Meses sem registro
#' @inheritParams resumir_unidade
#'
#' @returns Um `tibble` com uma linha por mês, na ordem do calendário, e as
#'   colunas `mes` (fator) e `media_relativa` (mil litros por vaca no mês).
#'
#' @family resumos
#' @export
#'
#' @examples
#' por_mes <- resumir_mes(leite_fazendas)
#' por_mes
#' por_mes$mes[which.max(por_mes$media_relativa)]
resumir_mes <- function(dados) {
  verificar_colunas(dados, c("mes", "litros_por_vaca"))
  dados |>
    tibble::as_tibble() |>
    dplyr::summarise(
      media_relativa = mean(.data$litros_por_vaca, na.rm = TRUE),
      .by = "mes"
    ) |>
    dplyr::arrange(.data$mes)
}

#' Resumo por ano e mês
#'
#' Calcula a média da medida relativa em cada mês de cada ano, que é o que
#' a figura de sazonalidade ([grafico_sazonal()]) desenha.
#'
#' @inheritSection resumir_unidade Meses sem registro
#' @inheritParams resumir_unidade
#'
#' @returns Um `tibble` com uma linha por ano e mês e as colunas `ano`
#'   (fator), `mes` (fator) e `media_relativa` (mil litros por vaca no
#'   mês).
#'
#' @family resumos
#' @export
#'
#' @examples
#' resumir_sazonal(leite_fazendas)
resumir_sazonal <- function(dados) {
  verificar_colunas(dados, c("ano", "mes", "litros_por_vaca"))
  dados |>
    tibble::as_tibble() |>
    dplyr::summarise(
      media_relativa = mean(.data$litros_por_vaca, na.rm = TRUE),
      .by = c("ano", "mes")
    ) |>
    dplyr::arrange(.data$ano, .data$mes) |>
    dplyr::mutate(ano = factor(.data$ano))
}
