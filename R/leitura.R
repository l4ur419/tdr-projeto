#' Leitura do cadastro das fazendas
#'
#' Lê o cadastro, com uma linha por fazenda. O arquivo é separado por
#' ponto e vírgula e está na codificação Latin-1 (ISO-8859-1), que é a dos
#' acentos dos nomes; o tipo de cada coluna é declarado, em vez de
#' adivinhado.
#'
#' @param arquivo Caminho do arquivo do cadastro. O padrão é o
#'   `cadastro.csv` que acompanha o pacote ([caminho_dados()]).
#'
#' @returns Um `tibble` com uma linha por fazenda e as colunas `codigo`
#'   (identificador, o mesmo dos arquivos anuais), `nome`, `sistema`
#'   (Confinado, Semiconfinado ou Pasto) e `vacas` (vacas em lactação). Um
#'   arquivo que não existe produz um erro da classe
#'   `leitecoop_erro_arquivo`, e uma tabela sem as colunas esperadas, um
#'   erro da classe `leitecoop_erro_colunas`.
#'
#' @seealso [ler_anuais()], para os arquivos de medições, e
#'   [arrumar_dados()], que junta as duas leituras.
#'
#' @export
#'
#' @examples
#' cadastro <- ler_cadastro()
#' cadastro
#' nrow(cadastro)
ler_cadastro <- function(arquivo = caminho_dados("cadastro.csv")) {
  verificar_arquivo(arquivo)
  cadastro <- readr::read_delim(
    arquivo,
    delim = ";",
    locale = readr::locale(encoding = "ISO-8859-1"),
    col_types = readr::cols(
      codigo = readr::col_character(),
      nome = readr::col_character(),
      sistema = readr::col_character(),
      vacas = readr::col_double()
    ),
    progress = FALSE
  )
  verificar_colunas(cadastro, colunas_cadastro)
  tibble::as_tibble(cadastro)
}

#' Leitura de um arquivo anual de medições
#'
#' Lê um dos arquivos anuais, com uma linha por fazenda e uma coluna por
#' mês. O arquivo é separado por ponto e vírgula, usa a vírgula como
#' separador decimal e marca o mês sem registro com `"-"`, que é lido como
#' `NA`; o `codigo` é lido como texto e os doze meses, como números.
#'
#' @param arquivo Caminho de um arquivo anual, como os que
#'   `caminho_dados("leite_2023.csv")` devolve.
#'
#' @returns Um `tibble` com uma linha por fazenda com medição e 13 colunas:
#'   `codigo` e os meses `jan` a `dez`, com o leite entregue no mês, em
#'   milhares de litros. Um arquivo que não existe produz um erro da classe
#'   `leitecoop_erro_arquivo`, e uma tabela sem as colunas esperadas, um
#'   erro da classe `leitecoop_erro_colunas`.
#'
#' @seealso [ler_anuais()], que lê e empilha os três anos.
#'
#' @export
#'
#' @examples
#' ler_um_ano(caminho_dados("leite_2023.csv"))
ler_um_ano <- function(arquivo) {
  verificar_arquivo(arquivo)
  if (length(arquivo) != 1) {
    rlang::abort(
      "`arquivo` precisa ser o caminho de um \u00fanico arquivo.",
      class = "leitecoop_erro_arquivo"
    )
  }
  ano <- readr::read_delim(
    arquivo,
    delim = ";",
    locale = readr::locale(decimal_mark = ",", encoding = "UTF-8"),
    na = "-",
    col_types = readr::cols(
      codigo = readr::col_character(),
      .default = readr::col_double()
    ),
    progress = FALSE
  )
  verificar_colunas(ano, c("codigo", meses))
  tibble::as_tibble(ano)
}

#' Leitura dos três arquivos anuais
#'
#' Lê os arquivos anuais com [ler_um_ano()], por meio do [purrr::map()], e
#' os empilha em uma tabela só, registrando de qual arquivo veio cada
#' linha. O ano é tirado do nome do arquivo, com [readr::parse_number()].
#'
#' @param arquivos Vetor com os caminhos dos arquivos anuais. O padrão são
#'   os três arquivos que acompanham o pacote, de 2023, 2024 e 2025. O nome
#'   de cada arquivo precisa conter o ano.
#'
#' @returns Um `tibble` com uma linha por fazenda e ano e as colunas
#'   `origem` (o nome do arquivo), `ano` (inteiro), `codigo` e os meses
#'   `jan` a `dez`. Um arquivo que não existe produz um erro da classe
#'   `leitecoop_erro_arquivo`.
#'
#' @seealso [arrumar_dados()], que passa a tabela para a forma longa e a
#'   junta ao cadastro.
#'
#' @export
#'
#' @examples
#' leite_bruto <- ler_anuais()
#' leite_bruto
#' table(leite_bruto$ano)
ler_anuais <- function(arquivos = caminho_dados(arquivos_anuais)) {
  verificar_arquivo(arquivos)
  arquivos |>
    rlang::set_names(basename(arquivos)) |>
    purrr::map(ler_um_ano) |>
    purrr::list_rbind(names_to = "origem") |>
    dplyr::mutate(
      ano = as.integer(readr::parse_number(.data$origem)),
      .after = "origem"
    )
}

#' Login para o qual os dados foram sorteados
#'
#' Lê, na primeira linha do `LEIA-ME.txt`, o login do GitHub para o qual os
#' dados simulados foram sorteados.
#'
#' @param arquivo Caminho do `LEIA-ME.txt`. O padrão é o que acompanha o
#'   pacote.
#'
#' @returns Um vetor de caracteres de comprimento um, com o login. Um
#'   arquivo que não existe, ou cuja primeira linha não traz o login,
#'   produz um erro da classe `leitecoop_erro_arquivo`.
#'
#' @export
#'
#' @examples
#' ler_login()
ler_login <- function(arquivo = caminho_dados("LEIA-ME.txt")) {
  verificar_arquivo(arquivo)
  primeira <- readLines(arquivo[1], n = 1, warn = FALSE, encoding = "UTF-8")
  if (length(primeira) == 0 || !grepl("login\\s+\\S+", primeira)) {
    rlang::abort(
      "A primeira linha do arquivo n\u00e3o traz o login.",
      class = "leitecoop_erro_arquivo"
    )
  }
  trimws(sub(".*login\\s+", "", primeira))
}
