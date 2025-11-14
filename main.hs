{- LINKS 
    link de leitura de Arquivo: https://kuniga.wordpress.com/2012/06/17/leitura-e-escrita-de-dados-em-haskell/
    link Do catch: https://stackoverflow.com/questions/6009384/exception-handling-in-haskell
    link entra e saida de dados: https://www.facom.ufu.br/~madriana/PF/IOHaskell.pdf
    link seq : https://wiki.haskell.org/index.php?title=Seq
-}
module Main where
import EstruturaDados
import Funcoes
import System.IO
import Control.Exception (catch, IOException)
import Data.Time (UTCTime, getCurrentTime)
import System.IO (hFlush, stdout)

-- Salva uma operação de log no arquivo Auditoria.log
registrarLog :: String -> IO ()
registrarLog linha = appendFile "Auditoria.log" (linha ++ "\n")

-- Salva o inventário atualizado no arquivo Inventario.dat
salvarInventario :: Inventario -> IO ()
salvarInventario inv = writeFile "Inventario.dat" (show inv)

-- Executa a operação de sincronização
sincronizacao :: FilePath -> IO ()
sincronizacao arq =
    writeFile arq "fromList []"
    
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

-- Seguranca de input
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

--Funcoes do inventario
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
    categoria <- getSafeInput "Categoria: "

    horario <- getCurrentTime

    case Funcoes.addItem horario idItem nomeItem qtd categoria inventarioAtual of
        Left erro -> do 
            let logErro = LogEntry horario Add erro (Falha erro)
            registrarLog (show logErro)
            putStrLn ("Erro: " ++ erro)

        Right (novoInventario, logEntry) -> do
            registrarLog (show logEntry)
            salvarInventario novoInventario
            putStrLn "Item adicionado com sucesso!"

removeItemIO :: IO ()
removeItemIO = do
    putStrLn "\n=== Remover Item ==="
    hFlush stdout
    
    idItem <- getSafeInput "ID do Item: "
    qtd <- getSafeInputInt "Quantidade a remover: "
    horario <- getCurrentTime
    
    inventarioAtual <- carregarInventario
    
    case Funcoes.removeItem horario idItem qtd inventarioAtual of
        Left erro -> do
            let logErro = LogEntry horario Remove erro (Falha erro)
            registrarLog (show logErro)
            putStrLn ("Erro: " ++ erro)

        Right (novoInventario, logEntry) -> do
            registrarLog (show logEntry)
            salvarInventario novoInventario
            putStrLn "Item removido com sucesso!"


updateItemIO :: IO ()
updateItemIO = do
    putStrLn "\n=== Atualizar Quantidade do Item ==="
    hFlush stdout

    idItem <- getSafeInput "ID do Item: "
    qtd <- getSafeInputInt "Nova quantidade: "
    horario <- getCurrentTime
    
    inventarioAtual <- carregarInventario
    case Funcoes.updateQty horario idItem qtd inventarioAtual of
        Left erro -> do
            let logErro = LogEntry horario Update erro (Falha erro)
            registrarLog (show logErro)
            putStrLn ("Erro: " ++ erro)

        Right (novoInventario, logEntry) -> do
            registrarLog (show logEntry)
            salvarInventario novoInventario
            putStrLn "Item atualizado com sucesso!"


relatorio :: IO ()
relatorio = putStrLn "Função relatório ainda não implementada"




-- MENU PRINCIPAL


execucaoLoop :: String -> IO ()
execucaoLoop conferiOpcao
    | conferiOpcao == "1" = addItemIO >> menu
    | conferiOpcao == "2" = removeItemIO >> menu
    | conferiOpcao == "3" = updateItemIO >> menu
    | conferiOpcao == "4" = relatorio >> menu
    | conferiOpcao == "0" = putStrLn "Saindo do programa..."
    | otherwise           = putStrLn "Operação não válida!" >> menu


menu :: IO () 
menu = do
    putStrLn "\nEscolha a operação:"
    putStrLn "1: Adicionar Item"
    putStrLn "2: Remover Item"
    putStrLn "3: Atualizar Quantidade"
    putStrLn "4: Relatório"
    putStrLn "0: Sair"
    opcao <- getLine
    execucaoLoop opcao

main :: IO ()
main = do 
    inicializacao ["Inventario.dat", "Auditoria.log"] 
    putStrLn "Arquivos inicializados!"
    menu