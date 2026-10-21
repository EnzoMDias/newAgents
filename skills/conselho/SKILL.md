---
name: conselho
description: Convoca um conselho de agentes especialistas do Squad para tomar uma decisão técnica difícil (escolha de stack, arquitetura, build vs buy, trade-off de segurança/performance, avançar ou não com uma entrega). Os agentes dão pareceres independentes, leem e rebatem os pareceres dos outros e o Tech Lead sintetiza a decisão num ADR. Use quando houver uma decisão de alto impacto ou divergência entre agentes, ou quando o usuário digitar /conselho.
---

# Conselho do Squad

Questão: `$ARGUMENTS` (se vazio, pergunte ao humano qual decisão deve ser tomada).

Você é o Tech Lead e preside o conselho. Objetivo: a **melhor decisão com evidência**, não consenso a qualquer custo.

## 1. Enquadrar
Escreva `.team/reviews/conselho-<NNN>/QUESTAO.md` (crie `.team/` se não existir) com:
- a pergunta exata a decidir;
- contexto (leia o código e o `.team/` antes);
- opções conhecidas (pode ficar aberto);
- critérios de decisão com pesos, derivados do BRIEF. Padrão: correção e requisitos > segurança > simplicidade e manutenção > custo de mudança > performance > custo financeiro.

## 2. Escolher de 3 a 5 conselheiros
Só quem tem competência real sobre a questão. Exemplos:
- Stack/arquitetura → `software-architect`, `researcher`, `devops-engineer`, `security-engineer`
- Modelo de dados → `data-engineer`, `software-architect`, `performance-engineer`
- Release GO/NO-GO → `qa-engineer`, `code-reviewer`, `security-engineer`, `performance-engineer`
- Produto/UX → `product-manager`, `ux-designer`, `frontend-engineer`
- Feature de IA → `ai-engineer`, `security-engineer`, `software-architect`

## 3. Rodada 1: pareceres independentes (em paralelo)
Chame todos numa única mensagem. Prompt para cada um:
> Conselho `<NNN>`. Leia `.team/reviews/conselho-<NNN>/QUESTAO.md` e o código relevante. Escreva seu parecer em `.team/reviews/conselho-<NNN>/<seu-nome>.md` contendo: recomendação, nota de 0 a 10 para cada opção em cada critério, evidências (arquivos, docs, benchmarks), riscos da opção recomendada e o que mudaria sua opinião. Não leia os pareceres dos outros nesta rodada.

## 4. Rodada 2: debate
Retome cada conselheiro com **SendMessage** (se indisponível, chame-o de novo):
> Leia os pareceres dos outros conselheiros em `.team/reviews/conselho-<NNN>/`. Aponte o argumento mais forte contra a sua posição e responda a ele. Mantenha ou mude sua recomendação e explique. Acrescente uma seção `## Réplica` ao seu arquivo.

Se ainda houver divergência sobre um **fato** (ex.: "a lib X suporta Y?"), resolva com evidência: peça ao `researcher` para verificar, ou rode um experimento/protótipo curto. Divergência de **valor** não precisa de mais rodadas: você decide.

## 5. Decisão
1. Monte a matriz: opções × critérios ponderados, com as notas médias dos conselheiros.
2. Um NO-GO do `security-engineer` por risco alto/crítico só é superado com aceitação explícita do humano.
3. Decida. Escreva `.team/decisions/ADR-<NNN>-<slug>.md` (status `aceito` se estiver dentro da autoridade do time; `proposto` se depender do humano) incluindo a matriz, os votos, as dissidências e o motivo.
4. Atualize `decisions/README.md` e `log.md`.
5. Reporte ao humano: decisão, placar, principal dissidência e risco, e o que (se algo) precisa da aprovação dele.
