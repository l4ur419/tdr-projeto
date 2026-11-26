#' Leite entregue pelas fazendas de uma cooperativa
#'
#' Tabela arrumada do leite entregue a cada mês, de 2023 a 2025, pelas dez
#' fazendas com medição de uma cooperativa, já juntada ao cadastro e com a
#' medida relativa. É o resultado de [arrumar_dados()] aplicado aos
#' arquivos de `inst/extdata/`, e tem a classe `leitecoop`
#' ([leitecoop-metodos]), que continua sendo um `tibble`. Os dados são
#' simulados, sorteados para o login `l4ur419` do GitHub.
#'
#' Os 9 meses sem registro (2 em 2023, 5 em 2024 e 2 em 2025) continuam
#' `NA` nas colunas `leite` e `litros_por_vaca`: um mês sem registro é
#' dado ausente, e não produção zero.
#'
#' @format Um `tibble` da classe `leitecoop`, com 360 linhas (10 fazendas,
#'   3 anos e 12 meses) e 9 colunas:
#' \describe{
#'   \item{origem}{Nome do arquivo anual de onde veio a linha.}
#'   \item{ano}{Ano da medição, inteiro, de 2023 a 2025.}
#'   \item{codigo}{Identificador da fazenda, de `FZ02` a `FZ11`.}
#'   \item{mes}{Mês da medição, fator com os níveis `jan` a `dez` na ordem
#'     do calendário.}
#'   \item{leite}{Leite entregue no mês, em milhares de litros; `NA` no mês
#'     sem registro.}
#'   \item{nome}{Nome da fazenda.}
#'   \item{sistema}{Sistema de produção: Confinado, Semiconfinado ou
#'     Pasto.}
#'   \item{vacas}{Porte da fazenda: número de vacas em lactação.}
#'   \item{litros_por_vaca}{Medida relativa: `leite / vacas`, em mil litros
#'     por vaca no mês.}
#' }
#'
#' @source Dados simulados, distribuídos para a Lista 03 da disciplina no
#'   arquivo `lista-03-l4ur419.zip`, de
#'   <https://fernandomayer.github.io/data/tdr/>. Os arquivos brutos estão
#'   em `inst/extdata/` ([caminho_dados()]), e o script que monta a tabela,
#'   em `data-raw/leite_fazendas.R`, no repositório do pacote.
#'
#' @examples
#' leite_fazendas
#' summary(leite_fazendas)
#' table(leite_fazendas$sistema, leite_fazendas$ano)
"leite_fazendas"
