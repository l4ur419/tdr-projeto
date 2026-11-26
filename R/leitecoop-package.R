#' leitecoop: leite entregue pelas fazendas de uma cooperativa
#'
#' Dados simulados do leite entregue a cada mês, de 2023 a 2025, pelas
#' fazendas de uma cooperativa.
#' Os cinco arquivos brutos acompanham o pacote em `inst/extdata/`
#' ([caminho_dados()]); as funções [ler_cadastro()] e [ler_anuais()] os
#' leem, e a [arrumar_dados()] monta a tabela arrumada.
#'
#' @section Meses sem registro:
#' Um mês sem registro (`"-"` nos arquivos anuais) é tratado como dado
#' ausente, e não como produção zero: a falta de registro não indica que a
#' fazenda deixou de produzir. Ele continua `NA` na tabela arrumada, as
#' somas e médias ignoram esses meses (`na.rm = TRUE`), e as contagens de
#' meses com e sem registro usam `is.na()`. A decisão afeta os totais e as
#' médias da medida relativa, mas não as contagens de meses.
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom rlang .data
## usethis namespace: end

NULL

# Os doze meses, na ordem do calendario e com os nomes das colunas dos
# arquivos anuais.
meses <- c(
  "jan", "fev", "mar", "abr", "mai", "jun",
  "jul", "ago", "set", "out", "nov", "dez"
)

# Os tres arquivos anuais que acompanham o pacote.
arquivos_anuais <- c("leite_2023.csv", "leite_2024.csv", "leite_2025.csv")

# As colunas do cadastro.
colunas_cadastro <- c("codigo", "nome", "sistema", "vacas")
