#' Arrumação das medições e junção ao cadastro
#'
#' Leva os arquivos anuais empilhados à tabela arrumada: passa a tabela
#' para a forma longa, com uma linha por fazenda, ano e mês; transforma o
#' mês em fator, na ordem do calendário; junta a tabela ao cadastro,
#' mantendo todas as linhas das medições e conferindo a cardinalidade
#' (cada fazenda medida tem exatamente uma linha no cadastro); e cria a
#' medida relativa, o leite do mês dividido pelo número de vacas.
#'
#' @details O leite está em milhares de litros, de modo que a medida
#'   relativa, `litros_por_vaca`, está em mil litros por vaca no mês. Os
#'   meses sem registro continuam `NA` (veja a seção "Meses sem registro"
#'   em [leitecoop-package]).
#'
#'   A junção é um `left_join()` com `relationship = "many-to-one"`: antes
#'   dela, a função confere que o cadastro não tem códigos repetidos e que
#'   todo código medido existe no cadastro, e para com um erro da classe
#'   `leitecoop_erro_cadastro` se não for o caso. Por isso a junção não
#'   muda o número de linhas.
#'
#' @param leite_bruto Tabela com os anos empilhados, como a devolvida por
#'   [ler_anuais()], com as colunas `ano`, `codigo` e `jan` a `dez`. O
#'   padrão é a leitura dos arquivos que acompanham o pacote.
#' @param cadastro Tabela do cadastro, como a devolvida por
#'   [ler_cadastro()]. O padrão é a leitura do cadastro do pacote.
#'
#' @returns Um `tibble` com uma linha por fazenda, ano e mês e as colunas
#'   `origem`, `ano`, `codigo`, `mes` (fator ordenado pelo calendário),
#'   `leite`, `nome`, `sistema`, `vacas` e `litros_por_vaca`. Uma tabela
#'   sem as colunas esperadas produz um erro da classe
#'   `leitecoop_erro_colunas`.
#'
#' @export
#'
#' @examples
#' dados <- arrumar_dados()
#' dados
#' nrow(dados)
#'
#' # As leituras também podem ser passadas explicitamente:
#' dados <- arrumar_dados(ler_anuais(), ler_cadastro())
arrumar_dados <- function(leite_bruto = ler_anuais(),
                          cadastro = ler_cadastro()) {
  verificar_colunas(leite_bruto, c("ano", "codigo", meses))
  verificar_colunas(cadastro, colunas_cadastro)

  repetidos <- unique(cadastro$codigo[duplicated(cadastro$codigo)])
  if (length(repetidos) > 0) {
    rlang::abort(
      c(
        "O cadastro tem c\u00f3digos repetidos.",
        x = paste("Repetidos:", paste(repetidos, collapse = ", "))
      ),
      class = "leitecoop_erro_cadastro"
    )
  }

  longa <- leite_bruto |>
    tidyr::pivot_longer(
      cols = dplyr::all_of(meses),
      names_to = "mes",
      values_to = "leite"
    ) |>
    dplyr::mutate(mes = factor(.data$mes, levels = meses))

  sem_cadastro <- setdiff(unique(longa$codigo), cadastro$codigo)
  if (length(sem_cadastro) > 0) {
    rlang::abort(
      c(
        "H\u00e1 fazendas medidas que n\u00e3o est\u00e3o no cadastro.",
        x = paste("C\u00f3digos:", paste(sem_cadastro, collapse = ", "))
      ),
      class = "leitecoop_erro_cadastro"
    )
  }

  longa |>
    dplyr::left_join(cadastro, by = "codigo", relationship = "many-to-one") |>
    dplyr::mutate(litros_por_vaca = .data$leite / .data$vacas)
}

#' Fazenda do cadastro sem medição
#'
#' Responde, com uma junção filtrante ([dplyr::anti_join()]), quais
#' fazendas do cadastro não têm medição em ano algum.
#'
#' @param cadastro Tabela do cadastro, como a devolvida por
#'   [ler_cadastro()].
#' @param leite_bruto Tabela das medições, como a devolvida por
#'   [ler_anuais()] (ou a tabela arrumada, que também tem a coluna
#'   `codigo`).
#'
#' @returns Um `tibble` com as linhas do cadastro cujo código não aparece
#'   nas medições.
#'
#' @export
#'
#' @examples
#' achar_sem_medicao()
achar_sem_medicao <- function(cadastro = ler_cadastro(),
                              leite_bruto = ler_anuais()) {
  verificar_colunas(cadastro, "codigo")
  verificar_colunas(leite_bruto, "codigo")
  dplyr::anti_join(cadastro, leite_bruto, by = "codigo")
}
