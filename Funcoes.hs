module Funcoes where

import qualified Data.Map as Map
import Data.Time (UTCTime)
import Data.Map (Map)
import EstruturaDados

addItem :: UTCTime -> String -> String -> Int -> String -> Inventario -> Either String ResultadoOperacao
addItem horario idItem nomeItem qtd categ inventarioArmazenado
  | qtd <= 0 =
      let logEntry = LogEntry
            { timestamp = horario
            , acao = Add
            , detalhes = "Tentativa de inserção com quantidade inválida"
            , status = Falha "Quantidade deve ser positiva"
            }
      in Left "Quantidade deve ser positiva"

  | Map.member idItem inventarioArmazenado =
      let logEntry = LogEntry
            { timestamp = horario
            , acao = Add
            , detalhes = "Tentativa de inserção duplicada"
            , status = Falha "Item já existe no inventário"
            }
      in Left "Item já existe no inventário"

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
