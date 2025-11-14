module LoopPrincipal where
import Data.Time (UTCTime, getCurrentTime)
import Funcoes
import EstruturaDados
import System.IO (hFlush, stdout)

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
     | all (`elem` "0123456789") isInt = return (read isInt :: Int)  -- So pode estar passar se for digitado um numero e retornar um Int 
     | otherwise = do
        putStrLn "Erro: Digi um numero nao um caracter "
        getSafeInputInt text

addItemIO :: IO ()
addItemIO = do
    putStrLn "\n=== Adicionar Novo Item ==="
    hFlush stdout
    
    idItem <- getSafeInput "ID do Item: "
    nomeItem <- getSafeInput "Nome do Item: "
    qtd <- getSafeInputInt "Quantidade: " 
    categoria <- getSafeInput "Categoria:"
    
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
    qtd <- getSafeInputInt "Quantidade a remover " 
    
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
    qtd <- getSafeInputInt "Nova Quantidade " 

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