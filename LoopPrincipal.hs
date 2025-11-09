module LoopPrincipal where

-- Funções temporárias (você precisa implementar depois)
addItem :: IO ()
addItem = putStrLn "Função addItem ainda não implementada"

removerIntem :: IO ()
removerIntem = putStrLn "Função removerIntem ainda não implementada"

relatorio :: IO ()
relatorio = putStrLn "Função relatorio ainda não implementada"

execucaoLoop :: String -> IO ()
execucaoLoop conferiOpcao
    | conferiOpcao == "1" = addItem >> menu
    | conferiOpcao == "2" = removerIntem >> menu
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