{- LINKS 
    link de leitura de Arquivo: https://kuniga.wordpress.com/2012/06/17/leitura-e-escrita-de-dados-em-haskell/
    link Do catch: https://stackoverflow.com/questions/6009384/exception-handling-in-haskell
    link entra e saida de dados: https://www.facom.ufu.br/~madriana/PF/IOHaskell.pdf
-}

import System.IO
import Control.Exception (catch, IOException, evaluate)


inserirInformacao :: FilePath -> IO ()
{-
    Atualmente função provisoria que adicona cada uma linha sem chamar nada novo  
-}
inserirInformacao arquivo = do
    appendFile arquivo "Nova Linha\n"
    putStrLn "Informação inserida com sucesso!"


criarArquivo :: FilePath -> IO ()
{-
    -- Função que insere informação no arquivo existente
-}
criarArquivo arq = do
    putStrLn "Arquivo não existe. Criando..."
    writeFile arq ""


inicializar :: FilePath -> IO ()
{- 
 Confere se o arquivo Existe criando um contener "tank" armazenado no conteudo 
 forcarLeitura -> força a leitura para que 'catch' funcione
 
 Caso o Arquivo não exite ele criarar um novo arquivo Usando a função criarArquivo
 
-}
inicializar arquivo = do
    (do conteudo <- readFile arquivo  
        forcarLeitura (length conteudo)  
        inserirInformacao arquivo)
        `catch` (\(_ :: IOException) -> criarArquivo arquivo)

-- Programa principal
main :: IO ()
main = do
    inicializar "teste1.txt"
    putStrLn "Funcionou"
