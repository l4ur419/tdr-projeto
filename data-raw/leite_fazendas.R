## Tabela arrumada do leite entregue pelas fazendas da cooperativa, montada
## com as funções do próprio pacote a partir dos arquivos de inst/extdata/.
## Rodar da raiz do pacote: source("data-raw/leite_fazendas.R")

devtools::load_all()

leite_fazendas <- arrumar_dados(ler_anuais(), ler_cadastro())

usethis::use_data(leite_fazendas, overwrite = TRUE)
