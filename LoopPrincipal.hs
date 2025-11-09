module LoopPrincipal where
import Data.Time (UTCTime, getCurrentTime)
import Funcoes
import EstruturaDados

-- Funções temporárias (você precisa implementar depois)
addItemIO :: IO ()
addItemIO = do
    putStrLn "\n=== Adicionar Novo Item ==="
    putStr "ID do Item: "
    idItem <- getLine
    putStr "Nome do Item: "
    nomeItem <- getLine
    putStr "Quantidade: "
    qtdStr <- getLine
    putStr "Categoria: "
    categoria <- getLine

    let qtd = read qtdStr :: Int
    horario <- getCurrentTime
    case Funcoes.addItem horario idItem nomeItem qtd categoria myInventory of
        Left erro -> putStrLn $ "Erro: " ++ erro
        Right (novoInventario, logEntry) -> do
            putStrLn "Item adicionado corretamente."
            print logEntry
            print novoInventario


removeItem :: IO ()
removeItem = putStrLn "Função removerItem ainda não implementada"

relatorio :: IO ()
relatorio = putStrLn "Função relatorio ainda não implementada"

execucaoLoop :: String -> IO ()
execucaoLoop conferiOpcao
    | conferiOpcao == "1" = addItemIO >> menu
    | conferiOpcao == "2" = removeItem >> menu
    | conferiOpcao == "3" = relatorio >> menu
    | conferiOpcao == "0" = putStrLn "Saindo do programa..."
    | otherwise = putStrLn "Operacao nao valida!" >> menu

menu :: IO ()
menu = do
    putStrLn "\nEscolha a operacao que sera realizada:"
    putStrLn "1: Adiciona um novo Item"
    putStrLn "2: Remover Item"
    putStrLn "3: Relatorio"
    putStrLn "0: Sair do Programa"
    opcao <- getLine
    execucaoLoop opcao