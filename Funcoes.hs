module Funcoes where

import qualified Data.Map as Map
import Data.Time (UTCTime)
import Data.Map (Map)
import EstruturaDados
import Data.List (isInfixOf, maximumBy)
import Data.Ord (comparing)

addItem :: UTCTime -> String -> String -> Int -> String -> Inventario -> Either String ResultadoOperacao
addItem horario idItem nomeItem qtd categ inventario
  | qtd <= 0 =
    Left "O estoque tem que ser maior ou igual a zero"

  | Map.member idItem inventario =
      Left "Um item do inventario ja possui esse ID"
  | otherwise =
      let novoItem = Item
            { itemID = idItem
            , nome = nomeItem
            , quantidade = qtd
            , categoria = categ
            }
          novoInventario = Map.insert idItem novoItem inventario
          logEntry = LogEntry
            { timestamp = horario
            , acao = Add
            , detalhes = "Item adicionado: " ++ nomeItem ++
                          " (ID: " ++ idItem ++
                          ", Qtd: " ++ show qtd ++
                          ", Cat: " ++ categ ++ ")"
            , status = Sucesso
            }
      in Right (novoInventario, logEntry)

removeItem :: UTCTime -> String -> Int -> Inventario 
           -> Either String ResultadoOperacao
removeItem horario idItem qtd inventario
    | qtd <= 0 =
        Left "A quantia removida tem que ser maior que zero"
    | Map.notMember idItem inventario =
        Left "Item a ser removido nao existe no inventario"
    | quantidade itemAtual < qtd =
        Left "Estoque insuficiente para remover"
    | novaQtd == 0 = Right (inventarioZerado, logZerado)
    | otherwise = Right (inventarioAtualizado, logEntry)
  where
    Just itemAtual = Map.lookup idItem inventario
    novaQtd = quantidade itemAtual - qtd

    inventarioZerado = Map.delete idItem inventario
    logZerado = LogEntry
        { timestamp = horario
        , acao = Remove
        , detalhes =
            "Item removido totalmente: " ++ nome itemAtual ++
            " (ID: " ++ idItem ++
            ", Removido: " ++ show qtd ++
            ", Estoque zerado e item deletado)"
        , status = Sucesso
        }
    
    itemModificado = itemAtual { quantidade = novaQtd }
    inventarioAtualizado = Map.insert idItem itemModificado inventario
    logEntry = LogEntry
        { timestamp = horario
        , acao = Remove
        , detalhes =
            "Remocao de item: " ++ nome itemAtual ++
            " (ID: " ++ idItem ++
            ", Removido: " ++ show qtd ++
            ", Nova quantidade: " ++ show novaQtd ++ ")"
        , status = Sucesso
        }

updateQty :: UTCTime -> String -> Int -> Inventario -> Either String ResultadoOperacao
updateQty horario idItem novaQtd inventario
    | Map.notMember idItem inventario =
        Left "Item a ser removido nao existe no inventario"
    | otherwise =
        let itemAtual = inventario Map.! idItem
            qtdAnterior = quantidade itemAtual
            qtdFinal = qtdAnterior + novaQtd
        in
            if qtdFinal < 0
            then Left "Estoque insuficiente para remover essa quantidade"
            else
                let itemModificado = itemAtual { quantidade = qtdFinal }
                    inventarioAtualizado = Map.insert idItem itemModificado inventario
                    detalheTexto =
                        if novaQtd >= 0
                        then "Item atualizado: " ++ nome itemAtual ++
                             " (ID: " ++ idItem ++
                             ", Qtd anterior: " ++ show qtdAnterior ++
                             ", Adicionado: +" ++ show novaQtd ++
                             ", Nova qtd: " ++ show qtdFinal ++ ")"
                        else "Item atualizado: " ++ nome itemAtual ++
                             " (ID: " ++ idItem ++
                             ", Qtd anterior: " ++ show qtdAnterior ++
                             ", Removido: " ++ show novaQtd ++
                             ", Nova qtd: " ++ show qtdFinal ++ ")"
                    logEntry = LogEntry
                        { timestamp = horario
                        , acao = Update
                        , detalhes = detalheTexto
                        , status = Sucesso
                        }
                in Right (inventarioAtualizado, logEntry)


historicoPorItem :: String -> [LogEntry] -> [LogEntry]
historicoPorItem itemId logs =
    filter (\log -> itemId `isInfixOf` detalhes log) logs


logsDeErro :: [LogEntry] -> [LogEntry]
logsDeErro logs = filter eErro logs
  where
    eErro log = case status log of
        Falha _ -> True
        Sucesso -> False

logsdeAcertos :: [LogEntry] -> [LogEntry]
logsdeAcertos logs = filter eSucesso logs
  where
    eSucesso log = case status log of
        Sucesso -> True
        Falha _ -> False
        
listarItens :: Inventario -> [(String, Item)]
listarItens inventario = Map.toList inventario

itemMaisMovimentado :: Inventario -> [LogEntry] -> String
itemMaisMovimentado inventario logs =
    let
        acertos = logsdeAcertos logs

        itens =
            [ (idItem, nome item)
            | (idItem, item) <- Map.toList inventario
            ]

        contagens =
            [ (idItem, length (filter (\log -> nomeItem `isInfixOf` detalhes log) acertos))
            | (idItem, nomeItem) <- itens
            ]

        (idMais, qtdMais) =
            maximumBy (comparing snd) contagens

    in "Item mais movimentado: " ++ idMais ++
       " (" ++ show qtdMais ++ " movimentações)"