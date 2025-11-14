
module LoopPrincipal where
import Data.Time (UTCTime, getCurrentTime)
import Funcoes
import EstruturaDados
import System.IO (hFlush, stdout)

-- Funções temporárias (você precisa implementar depois)

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

addItemIO :: IO ()
addItemIO = do
    putStrLn "\n=== Adicionar Novo Item ==="
    hFlush stdout
    
    idItem <- getSafeInput "ID do Item: "
    nomeItem <- getSafeInput "Nome do Item: "
    qtdStr <- getSafeInput "Quantidade: "
    categoria <- getSafeInput "Categoria:"
    
    let qtd = read qtdStr :: Int
    horario <- getCurrentTime
    
    either 
        (\erro -> putStrLn $ "Erro: " ++ erro)
        (\(novoInventario, logEntry) -> do
            putStrLn "Item adicionado com sucesso!"
            print logEntry
            print novoInventario
        )
        (Funcoes.addItem horario idItem nomeItem qtd categoria myInventory)
    

    
removeItemIO :: IO ()
removeItemIO = do
    putStrLn "\n=== Remover Item ==="
    hFlush stdout

    idItem <- getSafeInput "ID di Item"
    qtdStr <- getSafeInput "Quantidade a remover "
    
    let qtd = read qtdStr :: Int
    horario <- getCurrentTime
    
    either 
        (\erro -> putStrLn $ "Erro: " ++ erro)
        (\(novoInventario, logEntry) -> do
            putStrLn "Item removido com sucesso!"
            print logEntry
            print novoInventario
        )
        (Funcoes.removeItem horario idItem qtd myInventory)

updateItemIO :: IO ()
updateItemIO = do
    putStrLn "\n=== Atualizar Quantidade do Item ==="
    hFlush stdout

    idItem <- getSafeInput "ID do Item: "
    qtdStr <- getSafeInput "Nova Quantidade "

    let qtd = read qtdStr :: Int
    horario <- getCurrentTime

    either
        (\erro -> putStrLn $ "Erro: " ++ erro)
        (\(novoInventario, logEntry) -> do
            putStrLn "Item atualizado com sucesso!"
            print logEntry
            print novoInventario
        )
        (Funcoes.updateQty horario idItem qtd myInventory)

relatorio :: IO ()
relatorio = putStrLn "Função relatorio ainda não implementada"

execucaoLoop :: String -> IO ()
execucaoLoop conferiOpcao
    | conferiOpcao == "1" = addItemIO >> menu
    | conferiOpcao == "2" = removeItemIO >> menu
    | conferiOpcao == "3" = updateItemIO >> menu
    | conferiOpcao == "4" = relatorio >> menu
    | conferiOpcao == "0" = putStrLn "Saindo do programa..."
    | otherwise = putStrLn "Operacao nao valida!" >> menu

menu :: IO ()
menu = do
    putStrLn "\nEscolha a operacao que sera realizada:"
    putStrLn "1: Adiciona um novo Item"
    putStrLn "2: Remover Item"
    putStrLn "3: Atualizar Quantidade"
    putStrLn "4: Relatorio"
    putStrLn "0: Sair do Programa"
    opcao <- getLine
    execucaoLoop opcao
