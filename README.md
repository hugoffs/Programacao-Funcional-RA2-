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

Link para execução GDD: https://onlinegdb.com/qLmnZkfmq

---

# INSTRUÇÕES DE EXECUÇÃO

O programa pode ser rodado diretamente no navegador, sem instalações.

Link para execução no Online GDB:
https://onlinegdb.com/qLmnZkfmq

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
```
[?2004l
Arquivos inicializados!

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
5

=== Inserindo 10 itens ===
Item 1 adicionado: Notebook Dell
Item 2 adicionado: Mouse Logitech
Item 3 adicionado: Teclado Mecanico
Item 4 adicionado: Monitor LG 24
Item 5 adicionado: Webcam HD
Item 6 adicionado: Headset Gamer
Item 7 adicionado: SSD 500GB
Item 8 adicionado: Memoria RAM 8GB
Item 9 adicionado: Cadeira Gamer
Item 10 adicionado: Mesa para Computador

10 itens inseridos com sucesso!

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
 ```
  
* Adicionar 3 itens. \
  **Adiciona cada item através da opção "Adicionar Item"**
```
[?2004l
Arquivos inicializados!

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
5

=== Inserindo 10 itens ===
Item 1 adicionado: Notebook Dell
Item 2 adicionado: Mouse Logitech
Item 3 adicionado: Teclado Mecanico
Item 4 adicionado: Monitor LG 24
Item 5 adicionado: Webcam HD
Item 6 adicionado: Headset Gamer
Item 7 adicionado: SSD 500GB
Item 8 adicionado: Memoria RAM 8GB
Item 9 adicionado: Cadeira Gamer
Item 10 adicionado: Mesa para Computador

10 itens inseridos com sucesso!

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
1

=== Adicionar Novo Item ===
ID do Item: 
1
Nome do Item: 
cueca
Quantidade: 
10  1 1
Categoria:
roupa
Item adicionado com sucesso!
Operação registrada em Auditoria.log.

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
1

=== Adicionar Novo Item ===
ID do Item: 
2
Nome do Item: 
pao
Quantidade: 
1
Categoria:
alimento
Item adicionado com sucesso!
Operação registrada em Auditoria.log.

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
1

=== Adicionar Novo Item ===
ID do Item: 
3
Nome do Item: 
Box DVD DR House 1 Temporada
Quantidade: 
1
Categoria:
DVD
Item adicionado com sucesso!
Operação registrada em Auditoria.log.

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
0
Saindo do programa...
[?2004h
  ```
  
* Fechar o programa.
* Verificar se os arquivos Inventario.dat e Auditoria.log foram criados. \
 **Sim, foram criados**
```
  fromList [("001",Item {itemID = "001", nome = "Notebook Dell", quantidade = 5, categoria = "Computadores"}),("002",Item {itemID = "002", nome = "Mouse Logitech", quantidade = 25, categoria = "Perifericos"}),("003",Item {itemID = "003", nome = "Teclado Mecanico", quantidade = 15, categoria = "Perifericos"}),("004",Item {itemID = "004", nome = "Monitor LG 24", quantidade = 8, categoria = "Monitores"}),("005",Item {itemID = "005", nome = "Webcam HD", quantidade = 12, categoria = "Perifericos"}),("006",Item {itemID = "006", nome = "Headset Gamer", quantidade = 18, categoria = "Perifericos"}),("007",Item {itemID = "007", nome = "SSD 500GB", quantidade = 30, categoria = "Armazenamento"}),("008",Item {itemID = "008", nome = "Memoria RAM 8GB", quantidade = 40, categoria = "Componentes"}),("009",Item {itemID = "009", nome = "Cadeira Gamer", quantidade = 6, categoria = "Mobiliario"}),("010",Item {itemID = "010", nome = "Mesa para Computador", quantidade = 4, categoria = "Mobilario"}),("1",Item {itemID = "1", nome = "cueca", quantidade = 1, categoria = "roupa"}),("2",Item {itemID = "2", nome = "pao", quantidade = 1, categoria = "alimento"}),("3",Item {itemID = "3", nome = "Box DVD DR House 1 Temporada", quantidade = 1, categoria = "DVD"})]
```
  
* Reiniciar o programa. 
* Executar um comando de "listar" (a ser criado) ou verificar se o estado carregado em memória contém os 3 itens. \
  **Contém os três itens**
```
LogEntry {timestamp = 2025-11-15 01:24:24.898555154 UTC, acao = Add, detalhes = "Item adicionado: Notebook Dell (ID: 001, Qtd: 5, Cat: Computadores)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:24:24.898842093 UTC, acao = Add, detalhes = "Item adicionado: Mouse Logitech (ID: 002, Qtd: 25, Cat: Perifericos)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:24:24.898987143 UTC, acao = Add, detalhes = "Item adicionado: Teclado Mecanico (ID: 003, Qtd: 15, Cat: Perifericos)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:24:24.899129951 UTC, acao = Add, detalhes = "Item adicionado: Monitor LG 24 (ID: 004, Qtd: 8, Cat: Monitores)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:24:24.899261934 UTC, acao = Add, detalhes = "Item adicionado: Webcam HD (ID: 005, Qtd: 12, Cat: Perifericos)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:24:24.899389238 UTC, acao = Add, detalhes = "Item adicionado: Headset Gamer (ID: 006, Qtd: 18, Cat: Perifericos)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:24:24.899528699 UTC, acao = Add, detalhes = "Item adicionado: SSD 500GB (ID: 007, Qtd: 30, Cat: Armazenamento)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:24:24.899712353 UTC, acao = Add, detalhes = "Item adicionado: Memoria RAM 8GB (ID: 008, Qtd: 40, Cat: Componentes)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:24:24.899923369 UTC, acao = Add, detalhes = "Item adicionado: Cadeira Gamer (ID: 009, Qtd: 6, Cat: Mobiliario)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:24:24.900078506 UTC, acao = Add, detalhes = "Item adicionado: Mesa para Computador (ID: 010, Qtd: 4, Cat: Mobilario)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:25:45.204796935 UTC, acao = Add, detalhes = "Item adicionado: cueca (ID: 1, Qtd: 1, Cat: roupa)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:26:32.978152612 UTC, acao = Add, detalhes = "Item adicionado: pao (ID: 2, Qtd: 1, Cat: alimento)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:26:59.338366494 UTC, acao = Add, detalhes = "Item adicionado: Box DVD DR House 1 Temporada (ID: 3, Qtd: 1, Cat: DVD)", status = Sucesso}

```
```
[?2004l
Arquivos inicializados!

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
4

=== RELATORIOS ===
1. Historico de item
2. Ver erros
3. Ver sucessos
4. Item mais movimentado
5. Item carregados na memoria
Escolha: 5

=== ITENS EM INVENTARIO ===
Total de itens: 13

ID: 001
  Nome: Notebook Dell
  Quantidade: 5
  Categoria: Computadores

ID: 002
  Nome: Mouse Logitech
  Quantidade: 25
  Categoria: Perifericos

ID: 003
  Nome: Teclado Mecanico
  Quantidade: 15
  Categoria: Perifericos

ID: 004
  Nome: Monitor LG 24
  Quantidade: 8
  Categoria: Monitores

ID: 005
  Nome: Webcam HD
  Quantidade: 12
  Categoria: Perifericos

ID: 006
  Nome: Headset Gamer
  Quantidade: 18
  Categoria: Perifericos

ID: 007
  Nome: SSD 500GB
  Quantidade: 30
  Categoria: Armazenamento

ID: 008
  Nome: Memoria RAM 8GB
  Quantidade: 40
  Categoria: Componentes

ID: 009
  Nome: Cadeira Gamer
  Quantidade: 6
  Categoria: Mobiliario

ID: 010
  Nome: Mesa para Computador
  Quantidade: 4
  Categoria: Mobilario

ID: 1
  Nome: cueca
  Quantidade: 1
  Categoria: roupa

ID: 2
  Nome: pao
  Quantidade: 1
  Categoria: alimento

ID: 3
  Nome: Box DVD DR House 1 Temporada
  Quantidade: 1
  Categoria: DVD

Escolha a operaç�o:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
```

## Cenário 2: Erro de Lógica (Estoque Insuficiente) 
* Adicionar um item com 10 unidades (ex: "teclado"). \
  **Adicionado através da função criada para testes**
 ```
[?2004l
Arquivos inicializados!

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
5

=== Inserindo 10 itens ===
Item 1 adicionado: Notebook Dell
Item 2 adicionado: Mouse Logitech
Item 3 adicionado: Teclado Mecanico
Item 4 adicionado: Monitor LG 24
Item 5 adicionado: Webcam HD
Item 6 adicionado: Headset Gamer
Item 7 adicionado: SSD 500GB
Item 8 adicionado: Memoria RAM 8GB
Item 9 adicionado: Cadeira Gamer
Item 10 adicionado: Mesa para Computador

10 itens inseridos com sucesso!

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
1

=== Adicionar Novo Item ===
ID do Item: 
1
Nome do Item: 
teclado
Quantidade: 
10
Categoria:
periferico
Item adicionado com sucesso!
Operação registrada em Auditoria.log.

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
2

=== Remover Item ===
ID do Item: 
1
Quantidade a remover: 
15
Erro: Estoque insuficiente para remover
Erro registrado em Auditoria.log

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
4

=== RELATORIOS ===
1. Historico de item
2. Ver erros
3. Ver sucessos
4. Item mais movimentado
5. Item carregados na memoria
Escolha: 5

=== ITENS EM INVENTARIO ===
Total de itens: 11

ID: 001
  Nome: Notebook Dell
  Quantidade: 5
  Categoria: Computadores

ID: 002
  Nome: Mouse Logitech
  Quantidade: 25
  Categoria: Perifericos

ID: 003
  Nome: Teclado Mecanico
  Quantidade: 15
  Categoria: Perifericos

ID: 004
  Nome: Monitor LG 24
  Quantidade: 8
  Categoria: Monitores

ID: 005
  Nome: Webcam HD
  Quantidade: 12
  Categoria: Perifericos

ID: 006
  Nome: Headset Gamer
  Quantidade: 18
  Categoria: Perifericos

ID: 007
  Nome: SSD 500GB
  Quantidade: 30
  Categoria: Armazenamento

ID: 008
  Nome: Memoria RAM 8GB
  Quantidade: 40
  Categoria: Componentes

ID: 009
  Nome: Cadeira Gamer
  Quantidade: 6
  Categoria: Mobiliario

ID: 010
  Nome: Mesa para Computador
  Quantidade: 4
  Categoria: Mobilario

ID: 1
  Nome: teclado
  Quantidade: 10
  Categoria: periferico

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
4

=== RELATORIOS ===
1. Historico de item
2. Ver erros
3. Ver sucessos
4. Item mais movimentado
5. Item carregados na memoria
Escolha: 2

=== RELATORIO DE ERROS ===
Total de erros: 1
LogEntry {timestamp = 2025-11-15 01:44:28.162143901 UTC, acao = Remove, detalhes = "Falha ao remover - ID: 1 - Qtd Tentada: 15 - Estoque insuficiente para remover", status = Falha "Estoque insuficiente para remover"}

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
0
Saindo do programa...
[?2004h
  ```
  
* Tentar remover 15 unidades desse item. \
  **Não permitirá e resultará num log de erro (Impossível deduzir a mais do que a quantidade existente)**
```
fromList [("001",Item {itemID = "001", nome = "Notebook Dell", quantidade = 5, categoria = "Computadores"}),("002",Item {itemID = "002", nome = "Mouse Logitech", quantidade = 25, categoria = "Perifericos"}),("003",Item {itemID = "003", nome = "Teclado Mecanico", quantidade = 15, categoria = "Perifericos"}),("004",Item {itemID = "004", nome = "Monitor LG 24", quantidade = 8, categoria = "Monitores"}),("005",Item {itemID = "005", nome = "Webcam HD", quantidade = 12, categoria = "Perifericos"}),("006",Item {itemID = "006", nome = "Headset Gamer", quantidade = 18, categoria = "Perifericos"}),("007",Item {itemID = "007", nome = "SSD 500GB", quantidade = 30, categoria = "Armazenamento"}),("008",Item {itemID = "008", nome = "Memoria RAM 8GB", quantidade = 40, categoria = "Componentes"}),("009",Item {itemID = "009", nome = "Cadeira Gamer", quantidade = 6, categoria = "Mobiliario"}),("010",Item {itemID = "010", nome = "Mesa para Computador", quantidade = 4, categoria = "Mobilario"}),("1",Item {itemID = "1", nome = "teclado", quantidade = 10, categoria = "periferico"})]
```
  
* Verificar se o programa exibiu uma mensagem de erro clara. \
  **Exibe**
  
* Verificar se o Inventario.dat (e o estado em memória) ainda mostra 10 unidades. \
  **Ainda mostra o Item com 10 unidades.**
  
* Verificar se o Auditoria.log contém uma LogEntry com StatusLog (Falha ...). \
  **Contém.**


 ```
LogEntry {timestamp = 2025-11-15 01:43:40.19952963 UTC, acao = Add, detalhes = "Item adicionado: Notebook Dell (ID: 001, Qtd: 5, Cat: Computadores)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:43:40.20000596 UTC, acao = Add, detalhes = "Item adicionado: Mouse Logitech (ID: 002, Qtd: 25, Cat: Perifericos)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:43:40.20021715 UTC, acao = Add, detalhes = "Item adicionado: Teclado Mecanico (ID: 003, Qtd: 15, Cat: Perifericos)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:43:40.20049804 UTC, acao = Add, detalhes = "Item adicionado: Monitor LG 24 (ID: 004, Qtd: 8, Cat: Monitores)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:43:40.20073464 UTC, acao = Add, detalhes = "Item adicionado: Webcam HD (ID: 005, Qtd: 12, Cat: Perifericos)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:43:40.20096146 UTC, acao = Add, detalhes = "Item adicionado: Headset Gamer (ID: 006, Qtd: 18, Cat: Perifericos)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:43:40.20114482 UTC, acao = Add, detalhes = "Item adicionado: SSD 500GB (ID: 007, Qtd: 30, Cat: Armazenamento)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:43:40.20132405 UTC, acao = Add, detalhes = "Item adicionado: Memoria RAM 8GB (ID: 008, Qtd: 40, Cat: Componentes)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:43:40.2015367 UTC, acao = Add, detalhes = "Item adicionado: Cadeira Gamer (ID: 009, Qtd: 6, Cat: Mobiliario)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:43:40.2018257 UTC, acao = Add, detalhes = "Item adicionado: Mesa para Computador (ID: 010, Qtd: 4, Cat: Mobilario)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:44:06.96745871 UTC, acao = Add, detalhes = "Item adicionado: teclado (ID: 1, Qtd: 10, Cat: periferico)", status = Sucesso}
LogEntry {timestamp = 2025-11-15 01:44:28.162143901 UTC, acao = Remove, detalhes = "Falha ao remover - ID: 1 - Qtd Tentada: 15 - Estoque insuficiente para remover", status = Falha "Estoque insuficiente para remover"}
```

  
## Cenário 3: Geração de Relatório de Erros
* Após executar o Cenário 2, executar o comando report.
* Verificar se o relatório gerado (especificamente pela função logsDeErro) exibe a entrada de log referente à falha registrada no Cenário 2 (a tentativa de remover estoque insuficiente). \
  **Exibe a log de erro do cenário anterior**

```
[?2004l
Arquivos inicializados!

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
4

=== RELATORIOS ===
1. Historico de item
2. Ver erros
3. Ver sucessos
4. Item mais movimentado
5. Item carregados na memoria
Escolha: 2

=== RELATORIO DE ERROS ===
Total de erros: 1
LogEntry {timestamp = 2025-11-15 01:44:28.162143901 UTC, acao = Remove, detalhes = "Falha ao remover - ID: 1 - Qtd Tentada: 15 - Estoque insuficiente para remover", status = Falha "Estoque insuficiente para remover"}

Escolha a operação:
1: Adicionar Item
2: Remover Item
3: Atualizar Quantidade
4: Relatório
5: Insira 10 Itens
0: Sair
0
Saindo do programa...
[?2004h
```

