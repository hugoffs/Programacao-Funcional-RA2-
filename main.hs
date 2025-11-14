module Main where

-- Importação dos Módulos
import EstruturaDados
import Funcoes
import System.IO

import Control.Exception (catch, IOException)
import Data.Time (UTCTime, getCurrentTime)
import System.IO (hFlush, stdout)

import qualified Data.Map as Map
import Data.Map (Map)

--  SALVAR OPERAÇÕES NO ARQUIVO

-- Salva uma operação de log no arquivo Auditoria.log
registrarLog :: String -> IO ()
registrarLog linha = appendFile "Auditoria.log" (linha ++ "\n")

-- Salva o inventário atualizado no arquivo Inventario.dat
salvarInventario :: Inventario -> IO ()
salvarInventario inv = writeFile "Inventario.dat" (show inv)

--  INICIALIZAÇÃO DOS ARQUIVOS

-- Executa a operação de sincronização
sincronizacao :: FilePath -> IO ()
sincronizacao arq =
    case arq of
        "Inventario.dat" -> writeFile arq (show (Map.empty :: Inventario))
        "Auditoria.log"  -> writeFile arq ""
        _ -> writeFile arq ""

-- Inicializa um único arquivo
inicializarArquivos :: FilePath -> IO ()
inicializarArquivos arq = do
    catch (do
        lerArquivo <- openFile arq ReadMode
        hClose lerArquivo
        return ())
        (\(_ :: IOException) -> sincronizacao arq )

-- Inicializa múltiplos arquivos
inicializacao :: [FilePath] -> IO ()
inicializacao arqs = mapM_ inicializarArquivos arqs

historicoPorItem :: String -> [LogEntry] -> [LogEntry]
historicoPorItem itemId logs =
    filter (contemItemId itemId) logs
  where
    contemItemId idBuscado log =
        elem idBuscado (words (detalhes log))

logsDeErro :: [LogEntry] -> [LogEntry]
logsDeErro logs = filter ehErro logs
  where
    ehErro log = case status log of
        Falha _ -> True
        Sucesso -> False

logsDeSucesso :: [LogEntry] -> [LogEntry]
logsDeSucesso logs = filter ehSucesso logs
  where
    ehSucesso log = case status log of
        Sucesso -> True
        Falha _ -> False

--------------------------------------------------------------------------------
-- FUNÇÕES DE INPUT SEGURO
--------------------------------------------------------------------------------

getSafeInput :: String -> IO String
getSafeInput text = do
    putStrLn text
    hFlush stdout
    temp <- getLine
    conferirVazio temp
  where
    conferirVazio isEmpty
        | null isEmpty = do
            putStrLn "Erro: A entrada não pode ser vazia!"
            getSafeInput text
        | otherwise = return isEmpty


getSafeInputInt :: String -> IO Int
getSafeInputInt text = do
    putStrLn text
    hFlush stdout
    temp <- getLine
    conferirInteiro temp
   where
    conferirInteiro isInt
     | null isInt = do
        putStrLn "Erro: A entrada não pode ser vazia!"
        getSafeInputInt text
     | all (`elem` "0123456789") isInt = return (read isInt :: Int)
     | otherwise = do
        putStrLn "Erro: Digite um número, não um caractere."
        getSafeInputInt text

-- OPERAÇÕES DO INVENTÁRIO

carregarInventario :: IO Inventario
carregarInventario = do
    conteudo <- readFile "Inventario.dat"
    return (read conteudo :: Inventario)

addItemIO :: IO ()
addItemIO = do
    putStrLn "\n=== Adicionar Novo Item ==="
    hFlush stdout

    inventarioAtual <- carregarInventario

    idItem <- getSafeInput "ID do Item: "
    nomeItem <- getSafeInput "Nome do Item: "
    qtd <- getSafeInputInt "Quantidade: "
    categoria <- getSafeInput "Categoria:"
    horario <- getCurrentTime
    case Funcoes.addItem horario idItem nomeItem qtd categoria inventarioAtual of
        Left erro -> do
            putStrLn $ "Erro: " ++ erro

            let logErro = LogEntry
                    { timestamp = horario
                    , acao = Add
                    , detalhes = "Erro ao adicionar - ID: " ++ idItem ++
                                 " - Nome: " ++ nomeItem ++
                                 " - " ++ erro
                    , status = Falha erro
                    }

            registrarLog (show logErro)
            putStrLn "Erro registrado em Auditoria.log."

        Right (novoInventario, logEntry) -> do
            putStrLn "Item adicionado com sucesso!"
            registrarLog (show logEntry)
            salvarInventario novoInventario
            putStrLn "Operação registrada em Auditoria.log."

removeItemIO :: IO ()
removeItemIO = do
    putStrLn "\n=== Remover Item ==="
    hFlush stdout

    inventarioAtual <- carregarInventario  -- CARREGA O INVENTÁRIO

    idItem <- getSafeInput "ID do Item: "
    qtd <- getSafeInputInt "Quantidade a remover: "

    horario <- getCurrentTime

    case Funcoes.removeItem horario idItem qtd inventarioAtual of
        Left erro -> do
            putStrLn $ "Erro: " ++ erro

            let logErro = LogEntry
                    { timestamp = horario
                    , acao = Remove
                    , detalhes = "Falha ao remover - ID: " ++ idItem ++
                                 " - Qtd Tentada: " ++ show qtd ++
                                 " - " ++ erro
                    , status = Falha erro
                    }

            registrarLog (show logErro)
            putStrLn "Erro registrado em Auditoria.log."


updateItemIO :: IO ()
updateItemIO = do
    putStrLn "\n=== Atualizar Quantidade do Item ==="
    hFlush stdout

    inventarioAtual <- carregarInventario

    idItem <- getSafeInput "ID do Item: "
    putStr "Quantidade a adicionar ou remover"
    hFlush stdout
    qtdStr <- getLine
    let qtd = read qtdStr :: Int

    horario <- getCurrentTime

    case Funcoes.updateQty horario idItem qtd inventarioAtual of
        Left erro -> do
            putStrLn $ "Erro: " ++ erro
            let logErro = LogEntry
                    { timestamp = horario
                    , acao = Update
                    , detalhes = "Falha ao atualizar - ID: " ++ idItem ++
                                " - Delta Qtd: " ++ show qtd ++
                                " - " ++ erro
                    , status = Falha erro
                    }
            registrarLog (show logErro)
            putStrLn "Erro registrado em Auditoria.log."
        Right (novoInventario, logEntry) -> do
            putStrLn "Item atualizado com sucesso!"
            registrarLog (show logEntry)
            salvarInventario novoInventario
            putStrLn "Operacao registrada em Auditoria.log."


relatorio :: IO ()
relatorio = do
    putStrLn "\n=== RELATORIOS ==="
    putStrLn "1. Historico de item"
    putStrLn "2. Ver erros"
    putStrLn "3. Ver sucessos"
    putStrLn "4. Item mais movimentado"
    putStr "Escolha: "
    hFlush stdout
    opcao <- getLine

    case opcao of
        "1" -> testarHistorico
        "2" -> relatorioErros
        "3" -> relatorioSucessos
        "4" -> relatorioItemMaisMovimentado
        _   -> putStrLn "Opcao invalida!"

carregarLogs :: IO [LogEntry]
carregarLogs = do
    conteudo <- readFile "Auditoria.log" `catch` tratarErro
    if null conteudo
    then return []
    else return (map read (lines conteudo) :: [LogEntry])
  where
    tratarErro :: IOException -> IO String
    tratarErro _ = return ""

testarHistorico :: IO ()
testarHistorico = do
    putStrLn "\n=== HISTORICO POR ITEM ==="
    putStr "Digite o ID do item: "
    hFlush stdout
    itemId <- getLine

    logs <- carregarLogs
    let historico = Funcoes.historicoPorItem itemId logs

    putStrLn $ "\nOperacoes encontradas: " ++ show (length historico)
    mapM_ print historico

relatorioErros :: IO ()
relatorioErros = do
    putStrLn "\n=== RELATORIO DE ERROS ==="
    logs <- carregarLogs
    let erros = Funcoes.logsDeErro logs

    putStrLn $ "Total de erros: " ++ show (length erros)
    mapM_ print erros

relatorioSucessos :: IO ()
relatorioSucessos = do
    putStrLn "\n=== RELATORIO DE SUCESSOS ==="
    logs <- carregarLogs
    let sucessos = Funcoes.logsdeAcertos  logs

    putStrLn $ "Total de sucessos: " ++ show (length sucessos)
    mapM_ print (take 5 sucessos)
    
relatorioItemMaisMovimentado :: IO ()
relatorioItemMaisMovimentado = do
    putStrLn "\n=== ITEM MAIS MOVIMENTADO ==="

    inventario <- carregarInventario
    logs <- carregarLogs

    let resultado = Funcoes.itemMaisMovimentado inventario logs

    putStrLn resultado


inserirDezItens :: IO()
inserirDezItens = do
    putStrLn "\n=== Inserindo 10 itens ==="

    inventarioAtual <- carregarInventario

    horario <- getCurrentTime

    let itens = [
            ("001", "Notebook Dell", 5, "Computadores"),
            ("002", "Mouse Logitech", 25, "Perifericos"),
            ("003", "Teclado Mecanico", 15, "Perifericos"),
            ("004", "Monitor LG 24", 8, "Monitores"),
            ("005", "Webcam HD", 12, "Perifericos"),
            ("006", "Headset Gamer", 18, "Perifericos"),
            ("007", "SSD 500GB", 30, "Armazenamento"),
            ("008", "Memoria RAM 8GB", 40, "Componentes"),
            ("009", "Cadeira Gamer", 6, "Mobiliario"),
            ("010", "Mesa para Computador", 4, "Mobilario")
          ]

    inserirRecursivo inventarioAtual itens 1
  where
    inserirRecursivo _ [] _ = putStrLn "\n10 itens inseridos com sucesso!"
    inserirRecursivo inv ((id, nome, qtd, cat):resto) n = do
        horario <- getCurrentTime
        case Funcoes.addItem horario id nome qtd cat inv of
            Left erro -> do
                putStrLn $ "Item " ++ show n ++ " - Erro: " ++ erro
                inserirRecursivo inv resto (n + 1)
            Right (novoInv, logEntry) -> do
                registrarLog (show logEntry)
                salvarInventario novoInv
                putStrLn $ "Item " ++ show n ++ " adicionado: " ++ nome
                inserirRecursivo novoInv resto (n + 1)


menu :: IO ()
menu = do
    putStrLn "\nEscolha a operação:"
    putStrLn "1: Adicionar Item"
    putStrLn "2: Remover Item"
    putStrLn "3: Atualizar Quantidade"
    putStrLn "4: Relatório"
    putStrLn "5: Insira 10 Itens"
    putStrLn "0: Sair"
    opcao <- getLine
    execucaoLoop opcao
  where
    execucaoLoop conferiOpcao
        | conferiOpcao == "1" = addItemIO >> menu
        | conferiOpcao == "2" = removeItemIO >> menu
        | conferiOpcao == "3" = updateItemIO >> menu
        | conferiOpcao == "4" = relatorio >> menu
        | conferiOpcao == "5" = inserirDezItens >> menu
        | conferiOpcao == "0" = putStrLn "Saindo do programa..."
        | otherwise           = putStrLn "Operação não válida!" >> menu

main :: IO ()
main = do
    inicializacao ["Inventario.dat", "Auditoria.log"]
    putStrLn "Arquivos inicializados!"
    menu