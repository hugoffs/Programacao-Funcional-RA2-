module EstruturaDados where


import qualified Data.Map as Map
import Data.Map (Map)
import Data.Time (UTCTime, getCurrentTime)


-- Define a estrutura de um item que estará em Inventario
data Item = Item
  { 
    itemID      :: String,
    nome        :: String,
    quantidade  :: Int,
    categoria   :: String
  }deriving (Show, Read)


-- Define um 'Inventario' como um alias de tipo para um 'Map'. Que armazena elementos do tipo Item
type Inventario = Map String Item


-- Define a estrutura de registro de ações no sistema
data AcaoLog = Add | Remove | Update | QueryFail
    deriving (Show, Read)

-- Define a estrutura de sucesso/falha do registo de ações
data StatusLog 
  = Sucesso
  | Falha String
  deriving (Show, Read)


 -- Gera a data de quando o log ocorreu, a ação derivando do AcaoLog. Detalhes adicionais e o Status também derivando.
data LogEntry = LogEntry
  { 
     timestamp :: UTCTime,
     acao      :: AcaoLog,
     detalhes  :: String,
     status    :: StatusLog
  } deriving (Show, Read)
  
  
type ResultadoOperacao = (Inventario, LogEntry)
