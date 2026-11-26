#' Caminho de um arquivo de dados do pacote
#'
#' Devolve o caminho, no pacote instalado, de um ou mais dos arquivos
#' brutos que o acompanham em `inst/extdata/`: os três arquivos anuais
#' (`leite_2023.csv`, `leite_2024.csv` e `leite_2025.csv`), o cadastro
#' (`cadastro.csv`) e o `LEIA-ME.txt`. As funções de leitura usam esses
#' caminhos como padrão. O caminho é obtido com [system.file()], e por isso
#' funciona tanto no pacote instalado quanto com o `devtools::load_all()`.
#'
#' @param arquivo Vetor de caracteres com o nome de um ou mais arquivos de
#'   `inst/extdata/`. Com `NULL`, o padrão, a função devolve os nomes dos
#'   arquivos disponíveis.
#'
#' @returns Um vetor de caracteres com o caminho completo de cada arquivo
#'   pedido ou, com `arquivo = NULL`, com os nomes dos arquivos
#'   disponíveis. Um nome que não está em `inst/extdata/` produz um erro
#'   da classe `leitecoop_erro_arquivo`.
#'
#' @export
#'
#' @examples
#' caminho_dados()
#' caminho_dados("cadastro.csv")
#' caminho_dados(c("leite_2023.csv", "leite_2025.csv"))
caminho_dados <- function(arquivo = NULL) {
  if (is.null(arquivo)) {
    return(dir(system.file("extdata", package = "leitecoop")))
  }
  if (!is.character(arquivo) || length(arquivo) == 0) {
    rlang::abort(
      "`arquivo` precisa ser um vetor de caracteres com nomes de arquivos.",
      class = "leitecoop_erro_arquivo"
    )
  }
  caminhos <- vapply(
    arquivo,
    function(a) system.file("extdata", a, package = "leitecoop"),
    character(1),
    USE.NAMES = FALSE
  )
  faltam <- arquivo[caminhos == ""]
  if (length(faltam) > 0) {
    rlang::abort(
      c(
        "Arquivo n\u00e3o encontrado nos dados do pacote.",
        rlang::set_names(faltam, rep("x", length(faltam))),
        i = paste(
          "Os arquivos dispon\u00edveis s\u00e3o:",
          paste(caminho_dados(), collapse = ", ")
        )
      ),
      class = "leitecoop_erro_arquivo"
    )
  }
  caminhos
}
