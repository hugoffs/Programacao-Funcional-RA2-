-- deve refatorar para tudo em português
-- Deixar comentários simples que orientem o usuário


-- está no documento a biblioteca utilizada. A recomendação e prática comum é usar as duas
--Importa tudo do módulo Data.Map. Precisa usar o prefixo Map. para acessar qualquer coisa (Evita conflito com o Prelude)
import qualified Data.Map as Map
--Importa apenas o tipo Map. Para usar funções, você ainda precisa importar ou usar prefixo
import Data.Map (Map)
--Para conseguir ver o tempo
import Data.Time (UTCTime, getCurrentTime)


data Item = Item
  { 
    itemID      :: String,
    nome        :: String,
    quantidade  :: Int,
    categoria   :: String
  }

-- Volumetria de testes hardcoded, precisa refatorar para ser dinâmico
--Inventario funciona associando Chave:Valor, por isso tem ids duplicados, se pensar em SQL fará mais sentido
type Inventario = Map String Item
myInventory = Map.fromList
[ 
("001", Item "001" "Espada" 2 "Armas") , 
("002", Item "002" "ArcoFlecha" 1 "ArmasDistancia") , 
("003", Item "003" "Bandagem" 5 "Utilitarios") 
]

-- AcaoLog pode ser qualquer uma das opções. Tipo com múltiplas variantes. Adicionar o Read
data AcaoLog = Add | Remove | Update | QueryFail

-- Parecido com o ação log, mas esse precisa que a falha devolva uma String.
data StatusLog 
  = Sucesso
  | Falha String
  
 -- Gera a data de quando o log ocorreu, a ação derivando do AcaoLog. Detalhes adicionais e o Status também derivando.
data LogEntry = LogEntry
  { 
     timestamp :: UTCTime,
     acao      :: AcaoLog,
     detalhes  :: String,   
     status    :: StatusLog
  }








  
