{- LINKS 
    link de leitura de Arquivo: https://kuniga.wordpress.com/2012/06/17/leitura-e-escrita-de-dados-em-haskell/
    link Do catch: https://stackoverflow.com/questions/6009384/exception-handling-in-haskell
    link entra e saida de dados: https://www.facom.ufu.br/~madriana/PF/IOHaskell.pdf
    link seq : https://wiki.haskell.org/index.php?title=Seq
-}
module Main where

-- Importação dos Módulos 
import EstruturaDados
import LoopPrincipal

import System.IO
import Control.Exception (catch, IOException)

-- Executa a operação de sincronização
sincronizacao :: FilePath -> String -> IO ()
sincronizacao arq test
    | test == "append" = appendFile arq "Nova linha\n" -- alterar isso no refatoramento 
    | test == "write" = writeFile arq ""
    | otherwise = error "Operação do arquivo Errado"


-- Inicializa um único arquivo
inicializarArquivos :: FilePath -> IO () 
inicializarArquivos arq = do
    catch (do
        lerArquivo <- openFile arq ReadMode  
        hClose lerArquivo
        return ()) 
        (\(_ :: IOException) -> sincronizacao arq "write") -- caso não exista o arquivo ele vai ser criado 

-- Inicializa múltiplos arquivos
inicializacao :: [FilePath] -> IO ()
inicializacao arqs = mapM_ inicializarArquivos arqs  

main :: IO ()
main = do 
    inicializacao ["Inventario.dat", "Auditoria.log"] -- caso não exista os arquivos vai ter q fechar e abrir o codigo novamente 
    putStrLn "Arquivos inicializados com sucesso!"
    menu  -- Chama o menu principal