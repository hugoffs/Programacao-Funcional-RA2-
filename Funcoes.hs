module Funcoes where

import qualified Data.Map as Map
import Data.Time (UTCTime)
import Data.Map (Map)
import EstruturaDados

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

removeItem :: UTCTime -> String -> Int -> Inventario -> Either String ResultadoOperacao
removeItem horario idItem qtd inventario
    | qtd <= 0 =
        Left "A quantia removida tem que ser maior que zero"

    | Map.notMember idItem inventario =
        Left "Item a ser removido nao existe no inventario"

    | quantidade itemAtual < qtd =
        Left "Estoque insuficiente para remover"

    | otherwise =
        if novaQtd == 0
        then
            let inventarioZerado = Map.delete idItem inventario
                logZerado = LogEntry
                    { timestamp = horario
                    , acao = Remove
                    , detalhes =
                        "Removidas " ++ show qtd ++
                        " unidades de " ++ nome itemAtual ++
                        " - estoque zerado, item removido"
                    , status = Sucesso
                    }
            in Right (inventarioZerado, logZerado)

        else
            let itemModificado = itemAtual { quantidade = novaQtd }
                inventarioAtualizado = Map.insert idItem itemModificado inventario
                logEntry = LogEntry
                    { timestamp = horario
                    , acao = Remove
                    , detalhes =
                        "Removidas " ++ show qtd ++
                        " unidades de " ++ nome itemAtual ++
                        " (nova qtd: " ++ show novaQtd ++ ")"
                    , status = Sucesso
                    }
            in Right (inventarioAtualizado, logEntry)
  where
    itemAtual = inventario Map.! idItem
    novaQtd = quantidade itemAtual - qtd
    
updateQty :: UTCTime -> String -> Int -> Inventario -> Either String ResultadoOperacao
updateQty horario idItem novaQtd inventario
    | novaQtd < 0 =
        Left "A quantia alterada tem que ser maior que zero" 

    | Map.notMember idItem inventario =
        Left "Item a ser removido nao existe no inventario"
    | otherwise =
        let itemAtual = inventario Map.! idItem
            qtdAnterior = quantidade itemAtual

            itemModificado = itemAtual { quantidade = novaQtd }
            inventarioAtualizado = Map.insert idItem itemModificado inventario

            logEntry = LogEntry
                { timestamp = horario
                , acao = Update
                , detalhes =
                    "Item atualizado: " ++ nome itemAtual ++
                    " (ID: " ++ idItem ++
                    ", Qtd anterior: " ++ show qtdAnterior ++
                    ", Nova qtd: " ++ show novaQtd ++ ")"
                , status = Sucesso
                }
        in Right (inventarioAtualizado, logEntry)