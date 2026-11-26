# leitecoop: leite entregue pelas fazendas de uma cooperativa

Dados simulados do leite entregue a cada mês, de 2023 a 2025, pelas
fazendas de uma cooperativa, sorteados para o login `l4ur419` do GitHub.
Os cinco arquivos brutos acompanham o pacote em `inst/extdata/`
([`caminho_dados()`](https://l4ur419.github.io/tdr-projeto/reference/caminho_dados.md));
as funções
[`ler_cadastro()`](https://l4ur419.github.io/tdr-projeto/reference/ler_cadastro.md)
e
[`ler_anuais()`](https://l4ur419.github.io/tdr-projeto/reference/ler_anuais.md)
os leem, a
[`arrumar_dados()`](https://l4ur419.github.io/tdr-projeto/reference/arrumar_dados.md)
monta a tabela arrumada, da classe `leitecoop`
([leitecoop-metodos](https://l4ur419.github.io/tdr-projeto/reference/leitecoop-metodos.md)),
e os resumos e gráficos partem dela. A tabela arrumada também vem
pronta, no conjunto de dados
[leite_fazendas](https://l4ur419.github.io/tdr-projeto/reference/leite_fazendas.md).

## Meses sem registro

Um mês sem registro (`"-"` nos arquivos anuais) é tratado como dado
ausente, e não como produção zero: a falta de registro não indica que a
fazenda deixou de produzir. Ele continua `NA` na tabela arrumada, as
somas e médias ignoram esses meses (`na.rm = TRUE`), e as contagens de
meses com e sem registro usam
[`is.na()`](https://rdrr.io/r/base/NA.html). A decisão afeta os totais e
as médias da medida relativa, mas não as contagens de meses.

## Veja também

Useful links:

- <https://l4ur419.github.io/tdr-projeto/>

- <https://github.com/l4ur419/tdr-projeto>

- Report bugs at <https://github.com/l4ur419/tdr-projeto/issues>

## Autor

**Maintainer**: Laura Nicoletti <laura.nicoletti@ufpr.br>
