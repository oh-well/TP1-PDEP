import Test.Hspec
import Kars


cantidadDeParticipantesSegun :: Trampa -> Carrera -> Int
cantidadDeParticipantesSegun trampa = cantidadDeParticipantes.trampa

cantidadDeParticipantes :: Carrera -> Int
cantidadDeParticipantes = length.participantes

yaNoParticipaDeLaCarrera :: Auto -> Trampa -> Carrera -> Bool
yaNoParticipaDeLaCarrera unAuto trampa = not.(elem (nombre unAuto)).nombreDeAutosEnLista.participantes.trampa

nombreDeAutosEnLista :: [Auto] -> [String]
nombreDeAutosEnLista = map nombre

velocidadParticipanteSegun :: Trampa -> ([Auto] -> Auto) -> Carrera -> Velocidad
velocidadParticipanteSegun trampa funcion  = velocidad.(participanteSegun funcion).trampa 

participanteSegun :: ([Auto] -> Auto) -> Carrera -> Auto
participanteSegun funcion carrera = funcion (participantes carrera)

nivelDeNaftaPrimerParticipante :: Trampa -> Carrera -> Nafta
nivelDeNaftaPrimerParticipante trampa  = nivelDeNafta.(participanteSegun head).trampa

esUnicoParticipante :: Carrera -> Auto -> Bool
esUnicoParticipante carrera unAuto = ((nombre (participanteSegun head carrera)) == (nombre unAuto)) && ((cantidadDeParticipantes carrera) == 1)

darDosVueltas :: Carrera -> Carrera
darDosVueltas = darVuelta.darVuelta

---------------------------------------------------------------------------------------------------------------------------------
main :: IO ()
main = hspec $ do
    describe "Casos De Prueba" $ do

        describe "Punto 3.0" $ do

            it "La cantidad de nafta de rochaMcQueen luego de hacer su truco favorito es 300" $ do
             (nivelDeNafta.trucoParticular rochaMcQueen) rochaMcQueen `shouldBe` 300

            it "La cantidad de nafta de rodra tras deReversa es 10" $ do
             (nivelDeNafta.deReversa) rodra `shouldBe` 10
        
        describe "Punto 3.2" $ do

            it "La cantidad de participantes luego de sacarAlPistero en potreroFunes es 3" $ do
             (cantidadDeParticipantesSegun) sacarAlPistero potreroFunes `shouldBe` 3

            it "rochaMcQueen ya no participa en potreroFunes tras sacarAlPistero igual a True" $ do
             (yaNoParticipaDeLaCarrera) rochaMcQueen sacarAlPistero potreroFunes `shouldBe` True
            
            it "la cantidad de participantes luego de pocaReserva en potreroFunes es 3" $ do
             (cantidadDeParticipantesSegun) pocaReserva potreroFunes  `shouldBe` 3

            it "Rodra ya no participa en potreroFunes tras pocaReserva igual a False" $ do
             (yaNoParticipaDeLaCarrera) rochaMcQueen pocaReserva potreroFunes `shouldBe` False

            it "La cantidad de participantes luego de podio en potreroFunes es 3" $ do
             (cantidadDeParticipantesSegun) podio potreroFunes `shouldBe` 3

            it "La velocidad del último participante de potreroFunes (rodra) luego de la lluvia es 40" $ do
				velocidadParticipanteSegun lluvia last potreroFunes `shouldBe` 40
{-
       describe "Punto 3.3" $ do

			it "El nivel de nafta del primer participante (biankerr porque rochaMcQueen quedó afuera) luego de dar una vuelta en potreroFunes es 490" $ do
				nivelDeNaftaPrimerParticipante darVuelta potreroFunes `shouldBe` 490

			it "La velocidad del primer participante (biankerr porque rochaMcQueen quedó afuera) luego de dar una vuelta en potreroFunes es 40" $ do
				velocidadParticipanteSegun darVuelta head potreroFunes `shouldBe` 40

			it "la cantidad de participantes tras dar dos vueltas en potrero funes es 2" $ do
				cantidadDeParticipantesSegun darDosVueltas potreroFunes `shouldBe` 2

			it "Luego de dos vueltas, el nivelDeNafta del primer participante (gushtav) es 70" $ do
				nivelDeNaftaPrimerParticipante darDosVueltas potreroFunes `shouldBe` 70

            it "Rodra debe ser el único participante luego de correr la carrera de potreroFunes" $ do
                esUnicoParticipante potreroFunes rodra `shouldBe` True
-}
        describe "Punto 3.4" $ do
			
            it "El ganador de potreroFunes es rodra" $ do
                (nombre.quienGana) potreroFunes `shouldBe` "Rodra"
        
        describe "Punto 3.5" $ do

            it "La velocidad de rodra tras realizar elGranTruco con nitro, deReversa e impresionar es 130" $ do
                (velocidad.elGranTruco [nitro, deReversa, impresionar] ) rodra `shouldBe` 130

            it "El nivelDeNafta de rodra tras realizar elGranTruco con nitro, deReversa e impresionar es 13" $ do
                (nivelDeNafta.elGranTruco [nitro, deReversa, impresionar] ) rodra `shouldBe` 13