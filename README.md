* ### **Instituição:** Pontifícia Universidade Católica do Paraná
* ### **Disciplina:** Programação Lógica e Funcional
* ### **Professor:** [Frank Coelho de Alcantara](https://frankalcantara.com/)

---

### Integrantes do Grupo

* **Angelo Andrioli Netho** ([@angelonetho](https://github.com/angelonetho))
* **Eduardo Mendes Carbonera** ([@EduCarbonera](https://github.com/EduCarbonera))
* **Hugo Fagundes Faria** ([@hugoffs](https://github.com/hugoffs))
* **Kaio Gonçalves Teles** ([@Kaio-333](https://github.com/Kaio-333))

---

Link para execução GDD: https://onlinegdb.com/-ONYwrP9h

---

# INSTRUÇÕES DE EXECUÇÃO

O programa pode ser rodado diretamente no navegador, sem instalações.

Link para execução no Online GDB:
https://onlinegdb.com/-ONYwrP9h

Como executar
Acesse o link acima
Clique em Run
Utilize os comandos no terminal inferior

### Exemplos de Uso

**Inserir 10 itens de teste** \
Escolha: 5

**Adicionar item manualmente** \
Escolha: 1 \
ID do Item: 011 \
Nome do Item: Impressora HP \
Quantidade: 5 \
Categoria: Perifericos

**Remover item** \
Escolha: 2 \
ID do Item: 002 \
Quantidade a remover: 10

**Atualizar quantidade (adicionar)** \
Escolha: 3 \
ID do Item: 007
Quantidade a adicionar ou remover: 20 

**Atualizar quantidade (remover)** \
Escolha: 3 \
ID do Item: 008
Quantidade a adicionar ou remover: -5 

**Ver histórico de um item** \
Escolha: 4 \
Escolha: 1
Digite o ID do item: 002 

**Ver todos os erros** \
Escolha: 4 \
Escolha: 2 

**Ver sucessos** \
Escolha: 4 \
Escolha: 3 

**Item mais movimentado** \
Escolha: 4 \
Escolha: 4 

**Sair** \
Escolha: 0 

---

# Testes
## Cenário 1: Persistência de Estado (Sucesso) 
* Iniciar o programa (sem arquivos de dados). \
 **Quando iniciado sem arquivos de dados, ele cria os arquivos inventario e auditoria. Que só aparecerão depois de encerrar o programa**
  
* Adicionar 3 itens. \
  **Adiciona cada item através da opção "Adicionar Item"**
  
* Fechar o programa.
* Verificar se os arquivos Inventario.dat e Auditoria.log foram criados. \
 **Sim, foram criados**
  
* Reiniciar o programa. 
* Executar um comando de "listar" (a ser criado) ou verificar se o estado carregado em memória contém os 3 itens. \
  **Contém os três itens** 

## Cenário 2: Erro de Lógica (Estoque Insuficiente) 
* Adicionar um item com 10 unidades (ex: "teclado"). \
  **Adicionado através da função criada para testes**
  
* Tentar remover 15 unidades desse item. \
  **Não permitirá e resultará num log de erro (Impossível deduzir a mais do que a quantidade existente)**
  
* Verificar se o programa exibiu uma mensagem de erro clara. \
  **Exibe**
  
* Verificar se o Inventario.dat (e o estado em memória) ainda mostra 10 unidades. \
  **Ainda mostra o Item com 10 unidades.**
  
* Verificar se o Auditoria.log contém uma LogEntry com StatusLog (Falha ...). \
  **Contém.**
  
## Cenário 3: Geração de Relatório de Erros
* Após executar o Cenário 2, executar o comando report.
* Verificar se o relatório gerado (especificamente pela função logsDeErro) exibe a entrada de log referente à falha registrada no Cenário 2 (a tentativa de remover estoque insuficiente). \
  **Exibe a log de erro do cenário anterior**

