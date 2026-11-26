# Le a secao "Conferencia" do LEIA-ME.txt que acompanha os dados, para que
# os testes comparem a leitura e a arrumacao com os numeros publicados, e
# nao com numeros copiados para o codigo.
conferencia_leia_me <- function() {
  linhas <- readLines(caminho_dados("LEIA-ME.txt"), encoding = "UTF-8")
  numero_de <- function(rotulo) {
    linha <- grep(rotulo, linhas, value = TRUE)
    as.integer(sub(".*:\\s*", "", linha))
  }
  anos <- grep("^\\s*20[0-9]{2}\\s+", linhas, value = TRUE)
  partes <- strsplit(trimws(anos), "\\s+")
  list(
    unidades_cadastro = numero_de("unidades no cadastro"),
    unidades_medicoes = numero_de("unidades com medi"),
    por_ano = data.frame(
      ano = vapply(partes, function(p) as.integer(p[1]), integer(1)),
      meses_sem_registro = vapply(partes, function(p) as.integer(p[2]),
                                  integer(1)),
      soma = vapply(partes, function(p) as.numeric(sub(",", ".", p[3])),
                    numeric(1))
    )
  )
}
