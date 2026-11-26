# Validacao de argumentos, com erros de classe propria (rlang::abort).
# As mensagens usam escapes \u para os acentos, porque o codigo de um
# pacote precisa ser ASCII.

# Para com erro de classe "leitecoop_erro_arquivo" se `arquivo` nao for um
# vetor de caracteres com caminhos de arquivos que existem.
verificar_arquivo <- function(arquivo, arg = rlang::caller_arg(arquivo),
                              call = rlang::caller_env()) {
  if (!is.character(arquivo) || length(arquivo) == 0) {
    rlang::abort(
      sprintf("`%s` precisa ser um vetor de caracteres com caminhos de arquivos.",
              arg),
      class = "leitecoop_erro_arquivo",
      call = call
    )
  }
  faltam <- arquivo[!file.exists(arquivo)]
  if (length(faltam) > 0) {
    rlang::abort(
      c(
        "Arquivo n\u00e3o encontrado.",
        rlang::set_names(faltam, rep("x", length(faltam)))
      ),
      class = "leitecoop_erro_arquivo",
      call = call
    )
  }
  invisible(arquivo)
}

# Para com erro de classe "leitecoop_erro_colunas" se `x` nao for uma tabela
# com todas as `colunas`.
verificar_colunas <- function(x, colunas, arg = rlang::caller_arg(x),
                              call = rlang::caller_env()) {
  if (!is.data.frame(x)) {
    rlang::abort(
      sprintf("`%s` precisa ser uma tabela (data.frame ou tibble).", arg),
      class = "leitecoop_erro_colunas",
      call = call
    )
  }
  faltam <- setdiff(colunas, names(x))
  if (length(faltam) > 0) {
    rlang::abort(
      c(
        sprintf("`%s` n\u00e3o tem as colunas esperadas.", arg),
        x = paste("Faltam:", paste(faltam, collapse = ", "))
      ),
      class = "leitecoop_erro_colunas",
      call = call
    )
  }
  invisible(x)
}
