* ### **Instituição:** Pontifícia Universidade Católica do Paraná
* ### **Disciplina:** Programação Lógica e Funcional
* ### **Professor:** Frank Coelho de Alcantara

---

### Integrantes do Grupo

* **Angelo Andrioli Netho** ([@angelonetho](https://github.com/angelonetho))
* **Eduardo Mendes Carbonera** ([@EduCarbonera](https://github.com/EduCarbonera))
* **Hugo Fagundes Faria** ([@hugoffs](https://github.com/hugoffs))
* **Kaio Gonçalves Teles** ([@Kaio-333](https://github.com/Kaio-333))

---

Link para execução GDD: https://Placeholder
Link para execução Repl.it: https://Placeholder

---

# INSTRUÇÕES DE EXECUÇÃO

Documentação (README.md) explicando como compilar e executar o programa no Online
GDB ou no Repl.it, e um exemplo de uso dos comandos.
---

# Testes
## Cenário 1: Persistência de Estado (Sucesso) 
* Iniciar o programa (sem arquivos de dados). 
* Adicionar 3 itens. 
* Fechar o programa. 
* Verificar se os arquivos Inventario.dat e Auditoria.log foram criados. 
* Reiniciar o programa. 
* Executar um comando de "listar" (a ser criado) ou verificar se o estado carregado em memória contém os 3 itens.

## Cenário 2: Erro de Lógica (Estoque Insuficiente)
* Adicionar um item com 10 unidades (ex: "teclado").
* Tentar remover 15 unidades desse item.
* Verificar se o programa exibiu uma mensagem de erro clara.
* Verificar se o Inventario.dat (e o estado em memória) ainda mostra 10 unidades.
* Verificar se o Auditoria.log contém uma LogEntry com StatusLog (Falha ...).
  
## Cenário 3: Geração de Relatório de Erros
* Após executar o Cenário 2, executar o comando report.
* Verificar se o relatório gerado (especificamente pela função logsDeErro) exibe a entrada de log referente à falha registrada no Cenário 2 (a tentativa de remover estoque insuficiente).

