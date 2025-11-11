module Funcoes where

import qualified Data.Map as Map
import Data.Time (UTCTime)
import Data.Map (Map)
import EstruturaDados

addItem :: UTCTime -> String -> String -> Int -> String -> Inventario -> Either String ResultadoOperacao
addItem horario idItem nomeItem qtd categ inventario
  | qtd <= 0 =
    let logEntry = LogEntry
            { timestamp = horario
            , acao = Add
            , detalhes = "Falha ao adicionar item " ++ nomeItem ++ ": quantidade menor que 0"
            , status = Falha "Quantidade menor ou igual a zero"
            }
    in Right (inventario, logEntry)

  | Map.member idItem inventario = 
      let logEntry = LogEntry
            { timestamp = horario
            , acao = Add
            , detalhes = "Falha ao adicionar item duplicado: " ++ idItem
            , status = Falha "Item já existente"
            }
      in Right (inventario, logEntry)

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
      let logEntry = LogEntry
            { timestamp = horario
            , acao = Remove
            , detalhes = "Erro: quantidade menor ou igual a zero (" ++ show qtd ++ ")"
            , status = Falha "Quantidade deve ser positiva"
            }
      in Right (inventario, logEntry)

  | Map.notMember idItem inventario =
      let logEntry = LogEntry horario Remove
            ("Item não encontrado: " ++ idItem)
            (Falha "Item inexistente no inventário")
      in Right (inventario, logEntry)

  | qtdAtual < qtd =
      let logEntry = LogEntry horario Remove
            ("Falha ao remover item " ++ idItem ++ ": estoque insuficiente")
            (Falha "Estoque insuficiente")
      in Right (inventario, logEntry)

  | otherwise =
      let itemAtual = inventario Map.! idItem
          novaQtd = qtdAtual - qtd
          itemAtualizado = itemAtual { quantidade = novaQtd }
          novoInventario = if novaQtd == 0
                           then Map.delete idItem inventario
                           else Map.insert idItem itemAtualizado inventario
          logEntry = LogEntry
            { timestamp = horario
            , acao = Remove
            , detalhes = "Item removido: " ++ nome itemAtual ++
                          " (ID: " ++ idItem ++
                          ", Qtd removida: " ++ show qtd ++
                          ", Qtd restante: " ++ show novaQtd ++ ")"
            , status = Sucesso
            }
      in Right (novoInventario, logEntry)
  where
    qtdAtual = maybe 0 quantidade (Map.lookup idItem inventario)
    
    
updateQty :: UTCTime -> String -> Int -> Inventario -> Either String ResultadoOperacao
updateQty horario idItem novaQtd inventario
    | novaQtd < 0 =
        let logEntry = LogEntry
              { timestamp = horario
              , acao = Update
              , detalhes = "Falha, quantidade incorreta" ++ idItem ++ ": quantidade negativa"
              , status = Falha "Quantidade não pode ser menor que 0."
              }
        in Right (inventario, logEntry)

    | Map.notMember idItem inventario =
        let logEntry = LogEntry
              { timestamp = horario
              , acao = Update
              , detalhes = "Falha ao atualizar:" ++ idItem ++ " não existe no inventário"
              , status = Falha "Item nao existe"
              }
        in Right (inventario, logEntry)


    | otherwise =
      let itemAtual = inventario Map.! idItem
          qtdAnterior = quantidade itemAtual
          itemAtualizado = itemAtual { quantidade = novaQtd }
          novoInventario = if novaQtd == 0
                           then Map.delete idItem inventario
                           else Map.insert idItem itemAtualizado inventario
          logEntry = LogEntry
            { timestamp = horario
            , acao = Update
            , detalhes = "Item atualizado: " ++ nome itemAtual ++
                          " (ID: " ++ idItem ++
                          ", Qtd anterior: " ++ show qtdAnterior ++
                          ", Nova qtd: " ++ show novaQtd ++ ")"
            , status = Sucesso
            }
      in Right (novoInventario, logEntry)