module Funcoes where

import qualified Data.Map as Map
import Data.Time (UTCTime)
import Data.Map (Map)
import EstruturaDados

addItem :: UTCTime -> String -> String -> Int -> String -> Inventario -> Either String ResultadoOperacao
addItem horario idItem nomeItem qtd categ inventarioArmazenado
  | qtd <= 0 = 
      Left "Quantidade deve ser positiva"

  | Map.member idItem inventarioArmazenado = 
      Left "Item com mesmo ID ja existe no inventario"

  | otherwise =
      let novoItem = Item
            { itemID = idItem
            , nome = nomeItem
            , quantidade = qtd
            , categoria = categ
            }
          novoInventario = Map.insert idItem novoItem inventarioArmazenado
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
