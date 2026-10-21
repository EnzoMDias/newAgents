# Squad: time de agentes de desenvolvimento para o Claude Code

16 especialistas + um Tech Lead orquestrador que planejam, debatem, decidem nos portões GO/NO-GO, implementam, testam, revisam e documentam qualquer tipo de software.

## Instalação

```powershell
.\install.ps1                        # para todos os projetos (~/.claude)
.\install.ps1 -Projeto C:\meu\app    # só em um projeto
```

Reinicie o Claude Code depois. Para atualizar, edite os arquivos aqui e rode de novo.

## Uso

| Comando | O que faz |
|---|---|
| `/squad <objetivo>` | Ciclo completo: descoberta → plano → portão → implementação → portão → docs |
| `/squad status` | Mostra fase, tarefas, bloqueios e decisões pendentes |
| `/squad` | Retoma o trabalho de onde parou |
| `/conselho <decisão>` | Conselho de 3 a 5 especialistas: pareceres independentes, réplicas, ADR |

Também dá para chamar um especialista direto: *"use o security-engineer para revisar o login"*, ou `@debugger`.

Exemplos:
```
/squad criar uma API de agendamento para clínicas com painel web em Next.js
/squad o checkout está lento e às vezes cobra em dobro, investigar e corrigir
/conselho Postgres ou MongoDB para o catálogo de produtos?
```

## O time

| Agente | Papel | Modelo |
|---|---|---|
| product-manager | Escopo, histórias, critérios de aceite, MVP | herdado |
| researcher | Fatos atuais: versões, docs, comparativos, licenças | herdado |
| software-architect | Arquitetura, contratos, ADRs, decomposição em tarefas | opus |
| ux-designer | Fluxos, telas, estados, design system, WCAG 2.2 AA | herdado |
| backend-engineer | APIs, regras de negócio, integrações, autenticação | herdado |
| frontend-engineer | Web UI, estado, acessibilidade, Core Web Vitals | herdado |
| mobile-engineer | iOS, Android, React Native, Flutter | herdado |
| data-engineer | Schema, migrações zero-downtime, índices, pipelines | herdado |
| ai-engineer | LLMs, RAG, agentes, evals, custo | opus |
| devops-engineer | Docker, CI/CD, IaC, deploy, observabilidade | herdado |
| security-engineer | STRIDE, OWASP, dependências, segredos; **veto** | opus |
| qa-engineer | Estratégia de testes, automação, caça a bugs | herdado |
| code-reviewer | Revisão de correção e manutenibilidade | opus |
| performance-engineer | Medição, profiling, carga, otimização | herdado |
| debugger | Causa raiz com evidência, teste de regressão | opus |
| tech-writer | README, docs de API, changelog, runbooks | herdado |

"Herdado" usa o modelo da sua sessão. Troque o campo `model:` no arquivo do agente se quiser.

## Como os agentes conversam

1. **Quadro compartilhado `.team/`** criado no projeto. É a memória do time:
   - `BRIEF.md`: objetivo, escopo, critérios de aceite, autorizações
   - `BOARD.md`: tarefas, donos, dependências, status, resultado dos portões
   - `decisions/`: ADRs (proposto → aceito)
   - `handoffs/`: mensagens diretas entre agentes (`003-backend-engineer-para-frontend-engineer.md`)
   - `reviews/`, `research/`, `design/`, `qa/`, `perf/`, `bugs/`: artefatos de cada especialista
   - `log.md`: o que cada agente fez, em ordem
2. **Debate mediado**: quando há divergência ou NO-GO, o Tech Lead retoma cada agente com contexto (SendMessage), mostra a posição do outro e pede réplica. São no máximo 2 rodadas; depois o Tech Lead decide por critérios fixos e registra um ADR.
3. **Portões**: plano (segurança + QA + quem for relevante) e entrega (QA + revisão + segurança). Um NO-GO volta ao dono com o achado literal.

Todo agente segue o mesmo protocolo (`shared/protocolo.md`): lê o quadro antes de começar, respeita os ADRs, escreve handoffs e devolve um relatório padronizado com evidência real (testes executados, não presumidos).

## Segurança operacional

Os agentes não fazem commit, push, deploy, migração em dados reais nem gastos sem autorização no `BRIEF.md` ou pedido seu.

## Estrutura deste repositório

```
agents/            16 especialistas ({{PROTOCOLO}} é preenchido na instalação)
shared/protocolo.md
skills/squad/      orquestrador + templates do quadro
skills/conselho/   decisões por conselho
install.ps1
```
