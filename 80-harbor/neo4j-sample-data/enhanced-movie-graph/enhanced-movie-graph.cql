// Step 1: Create the initial Movie Graph, default to Neo4j.

CREATE (TheMatrix:Movie {title:'The Matrix', released:1999, tagline:'Welcome to the Real World'})
CREATE (Keanu:Person {name:'Keanu Reeves', born:1964})
CREATE (Carrie:Person {name:'Carrie-Anne Moss', born:1967})
CREATE (Laurence:Person {name:'Laurence Fishburne', born:1961})
CREATE (Hugo:Person {name:'Hugo Weaving', born:1960})
CREATE (LillyW:Person {name:'Lilly Wachowski', born:1967})
CREATE (LanaW:Person {name:'Lana Wachowski', born:1965})
CREATE (JoelS:Person {name:'Joel Silver', born:1952})
CREATE
(Keanu)-[:ACTED_IN {roles:['Neo']}]->(TheMatrix),
(Carrie)-[:ACTED_IN {roles:['Trinity']}]->(TheMatrix),
(Laurence)-[:ACTED_IN {roles:['Morpheus']}]->(TheMatrix),
(Hugo)-[:ACTED_IN {roles:['Agent Smith']}]->(TheMatrix),
(LillyW)-[:DIRECTED]->(TheMatrix),
(LanaW)-[:DIRECTED]->(TheMatrix),
(JoelS)-[:PRODUCED]->(TheMatrix)

CREATE (Emil:Person {name:"Emil Eifrem", born:1978})
CREATE (Emil)-[:ACTED_IN {roles:["Emil"]}]->(TheMatrix)

CREATE (TheMatrixReloaded:Movie {title:'The Matrix Reloaded', released:2003, tagline:'Free your mind'})
CREATE
(Keanu)-[:ACTED_IN {roles:['Neo']}]->(TheMatrixReloaded),
(Carrie)-[:ACTED_IN {roles:['Trinity']}]->(TheMatrixReloaded),
(Laurence)-[:ACTED_IN {roles:['Morpheus']}]->(TheMatrixReloaded),
(Hugo)-[:ACTED_IN {roles:['Agent Smith']}]->(TheMatrixReloaded),
(LillyW)-[:DIRECTED]->(TheMatrixReloaded),
(LanaW)-[:DIRECTED]->(TheMatrixReloaded),
(JoelS)-[:PRODUCED]->(TheMatrixReloaded)

CREATE (TheMatrixRevolutions:Movie {title:'The Matrix Revolutions', released:2003, tagline:'Everything that has a beginning has an end'})
CREATE
(Keanu)-[:ACTED_IN {roles:['Neo']}]->(TheMatrixRevolutions),
(Carrie)-[:ACTED_IN {roles:['Trinity']}]->(TheMatrixRevolutions),
(Laurence)-[:ACTED_IN {roles:['Morpheus']}]->(TheMatrixRevolutions),
(Hugo)-[:ACTED_IN {roles:['Agent Smith']}]->(TheMatrixRevolutions),
(LillyW)-[:DIRECTED]->(TheMatrixRevolutions),
(LanaW)-[:DIRECTED]->(TheMatrixRevolutions),
(JoelS)-[:PRODUCED]->(TheMatrixRevolutions)

CREATE (TheDevilsAdvocate:Movie {title:"The Devil's Advocate", released:1997, tagline:'Evil has its winning ways'})
CREATE (Charlize:Person {name:'Charlize Theron', born:1975})
CREATE (Al:Person {name:'Al Pacino', born:1940})
CREATE (Taylor:Person {name:'Taylor Hackford', born:1944})
CREATE
(Keanu)-[:ACTED_IN {roles:['Kevin Lomax']}]->(TheDevilsAdvocate),
(Charlize)-[:ACTED_IN {roles:['Mary Ann Lomax']}]->(TheDevilsAdvocate),
(Al)-[:ACTED_IN {roles:['John Milton']}]->(TheDevilsAdvocate),
(Taylor)-[:DIRECTED]->(TheDevilsAdvocate)

CREATE (AFewGoodMen:Movie {title:"A Few Good Men", released:1992, tagline:"In the heart of the nation's capital, in a courthouse of the U.S. government, one man will stop at nothing to keep his honor, and one will stop at nothing to find the truth."})
CREATE (TomC:Person {name:'Tom Cruise', born:1962})
CREATE (JackN:Person {name:'Jack Nicholson', born:1937})
CREATE (DemiM:Person {name:'Demi Moore', born:1962})
CREATE (KevinB:Person {name:'Kevin Bacon', born:1958})
CREATE (KieferS:Person {name:'Kiefer Sutherland', born:1966})
CREATE (NoahW:Person {name:'Noah Wyle', born:1971})
CREATE (CubaG:Person {name:'Cuba Gooding Jr.', born:1968})
CREATE (KevinP:Person {name:'Kevin Pollak', born:1957})
CREATE (JTW:Person {name:'J.T. Walsh', born:1943})
CREATE (JamesM:Person {name:'James Marshall', born:1967})
CREATE (ChristopherG:Person {name:'Christopher Guest', born:1948})
CREATE (RobR:Person {name:'Rob Reiner', born:1947})
CREATE (AaronS:Person {name:'Aaron Sorkin', born:1961})
CREATE
(TomC)-[:ACTED_IN {roles:['Lt. Daniel Kaffee']}]->(AFewGoodMen),
(JackN)-[:ACTED_IN {roles:['Col. Nathan R. Jessup']}]->(AFewGoodMen),
(DemiM)-[:ACTED_IN {roles:['Lt. Cdr. JoAnne Galloway']}]->(AFewGoodMen),
(KevinB)-[:ACTED_IN {roles:['Capt. Jack Ross']}]->(AFewGoodMen),
(KieferS)-[:ACTED_IN {roles:['Lt. Jonathan Kendrick']}]->(AFewGoodMen),
(NoahW)-[:ACTED_IN {roles:['Cpl. Jeffrey Barnes']}]->(AFewGoodMen),
(CubaG)-[:ACTED_IN {roles:['Cpl. Carl Hammaker']}]->(AFewGoodMen),
(KevinP)-[:ACTED_IN {roles:['Lt. Sam Weinberg']}]->(AFewGoodMen),
(JTW)-[:ACTED_IN {roles:['Lt. Col. Matthew Andrew Markinson']}]->(AFewGoodMen),
(JamesM)-[:ACTED_IN {roles:['Pfc. Louden Downey']}]->(AFewGoodMen),
(ChristopherG)-[:ACTED_IN {roles:['Dr. Stone']}]->(AFewGoodMen),
(AaronS)-[:ACTED_IN {roles:['Man in Bar']}]->(AFewGoodMen),
(RobR)-[:DIRECTED]->(AFewGoodMen),
(AaronS)-[:WROTE]->(AFewGoodMen)

CREATE (TopGun:Movie {title:"Top Gun", released:1986, tagline:'I feel the need, the need for speed.'})
CREATE (KellyM:Person {name:'Kelly McGillis', born:1957})
CREATE (ValK:Person {name:'Val Kilmer', born:1959})
CREATE (AnthonyE:Person {name:'Anthony Edwards', born:1962})
CREATE (TomS:Person {name:'Tom Skerritt', born:1933})
CREATE (MegR:Person {name:'Meg Ryan', born:1961})
CREATE (TonyS:Person {name:'Tony Scott', born:1944})
CREATE (JimC:Person {name:'Jim Cash', born:1941})
CREATE
(TomC)-[:ACTED_IN {roles:['Maverick']}]->(TopGun),
(KellyM)-[:ACTED_IN {roles:['Charlie']}]->(TopGun),
(ValK)-[:ACTED_IN {roles:['Iceman']}]->(TopGun),
(AnthonyE)-[:ACTED_IN {roles:['Goose']}]->(TopGun),
(TomS)-[:ACTED_IN {roles:['Viper']}]->(TopGun),
(MegR)-[:ACTED_IN {roles:['Carole']}]->(TopGun),
(TonyS)-[:DIRECTED]->(TopGun),
(JimC)-[:WROTE]->(TopGun)

CREATE (JerryMaguire:Movie {title:'Jerry Maguire', released:2000, tagline:'The rest of his life begins now.'})
CREATE (ReneeZ:Person {name:'Renee Zellweger', born:1969})
CREATE (KellyP:Person {name:'Kelly Preston', born:1962})
CREATE (JerryO:Person {name:"Jerry O'Connell", born:1974})
CREATE (JayM:Person {name:'Jay Mohr', born:1970})
CREATE (BonnieH:Person {name:'Bonnie Hunt', born:1961})
CREATE (ReginaK:Person {name:'Regina King', born:1971})
CREATE (JonathanL:Person {name:'Jonathan Lipnicki', born:1996})
CREATE (CameronC:Person {name:'Cameron Crowe', born:1957})
CREATE
(TomC)-[:ACTED_IN {roles:['Jerry Maguire']}]->(JerryMaguire),
(CubaG)-[:ACTED_IN {roles:['Rod Tidwell']}]->(JerryMaguire),
(ReneeZ)-[:ACTED_IN {roles:['Dorothy Boyd']}]->(JerryMaguire),
(KellyP)-[:ACTED_IN {roles:['Avery Bishop']}]->(JerryMaguire),
(JerryO)-[:ACTED_IN {roles:['Frank Cushman']}]->(JerryMaguire),
(JayM)-[:ACTED_IN {roles:['Bob Sugar']}]->(JerryMaguire),
(BonnieH)-[:ACTED_IN {roles:['Laurel Boyd']}]->(JerryMaguire),
(ReginaK)-[:ACTED_IN {roles:['Marcee Tidwell']}]->(JerryMaguire),
(JonathanL)-[:ACTED_IN {roles:['Ray Boyd']}]->(JerryMaguire),
(CameronC)-[:DIRECTED]->(JerryMaguire),
(CameronC)-[:PRODUCED]->(JerryMaguire),
(CameronC)-[:WROTE]->(JerryMaguire)

CREATE (StandByMe:Movie {title:"Stand By Me", released:1986, tagline:"For some, it's the last real taste of innocence, and the first real taste of life. But for everyone, it's the time that memories are made of."})
CREATE (RiverP:Person {name:'River Phoenix', born:1970})
CREATE (CoreyF:Person {name:'Corey Feldman', born:1971})
CREATE (WilW:Person {name:'Wil Wheaton', born:1972})
CREATE (JohnC:Person {name:'John Cusack', born:1966})
CREATE (MarshallB:Person {name:'Marshall Bell', born:1942})
CREATE
(WilW)-[:ACTED_IN {roles:['Gordie Lachance']}]->(StandByMe),
(RiverP)-[:ACTED_IN {roles:['Chris Chambers']}]->(StandByMe),
(JerryO)-[:ACTED_IN {roles:['Vern Tessio']}]->(StandByMe),
(CoreyF)-[:ACTED_IN {roles:['Teddy Duchamp']}]->(StandByMe),
(JohnC)-[:ACTED_IN {roles:['Denny Lachance']}]->(StandByMe),
(KieferS)-[:ACTED_IN {roles:['Ace Merrill']}]->(StandByMe),
(MarshallB)-[:ACTED_IN {roles:['Mr. Lachance']}]->(StandByMe),
(RobR)-[:DIRECTED]->(StandByMe)

CREATE (AsGoodAsItGets:Movie {title:'As Good as It Gets', released:1997, tagline:'A comedy from the heart that goes for the throat.'})
CREATE (HelenH:Person {name:'Helen Hunt', born:1963})
CREATE (GregK:Person {name:'Greg Kinnear', born:1963})
CREATE (JamesB:Person {name:'James L. Brooks', born:1940})
CREATE
(JackN)-[:ACTED_IN {roles:['Melvin Udall']}]->(AsGoodAsItGets),
(HelenH)-[:ACTED_IN {roles:['Carol Connelly']}]->(AsGoodAsItGets),
(GregK)-[:ACTED_IN {roles:['Simon Bishop']}]->(AsGoodAsItGets),
(CubaG)-[:ACTED_IN {roles:['Frank Sachs']}]->(AsGoodAsItGets),
(JamesB)-[:DIRECTED]->(AsGoodAsItGets)

CREATE (WhatDreamsMayCome:Movie {title:'What Dreams May Come', released:1998, tagline:'After life there is more. The end is just the beginning.'})
CREATE (AnnabellaS:Person {name:'Annabella Sciorra', born:1960})
CREATE (MaxS:Person {name:'Max von Sydow', born:1929})
CREATE (WernerH:Person {name:'Werner Herzog', born:1942})
CREATE (Robin:Person {name:'Robin Williams', born:1951})
CREATE (VincentW:Person {name:'Vincent Ward', born:1956})
CREATE
(Robin)-[:ACTED_IN {roles:['Chris Nielsen']}]->(WhatDreamsMayCome),
(CubaG)-[:ACTED_IN {roles:['Albert Lewis']}]->(WhatDreamsMayCome),
(AnnabellaS)-[:ACTED_IN {roles:['Annie Collins-Nielsen']}]->(WhatDreamsMayCome),
(MaxS)-[:ACTED_IN {roles:['The Tracker']}]->(WhatDreamsMayCome),
(WernerH)-[:ACTED_IN {roles:['The Face']}]->(WhatDreamsMayCome),
(VincentW)-[:DIRECTED]->(WhatDreamsMayCome)

CREATE (SnowFallingonCedars:Movie {title:'Snow Falling on Cedars', released:1999, tagline:'First loves last. Forever.'})
CREATE (EthanH:Person {name:'Ethan Hawke', born:1970})
CREATE (RickY:Person {name:'Rick Yune', born:1971})
CREATE (JamesC:Person {name:'James Cromwell', born:1940})
CREATE (ScottH:Person {name:'Scott Hicks', born:1953})
CREATE
(EthanH)-[:ACTED_IN {roles:['Ishmael Chambers']}]->(SnowFallingonCedars),
(RickY)-[:ACTED_IN {roles:['Kazuo Miyamoto']}]->(SnowFallingonCedars),
(MaxS)-[:ACTED_IN {roles:['Nels Gudmundsson']}]->(SnowFallingonCedars),
(JamesC)-[:ACTED_IN {roles:['Judge Fielding']}]->(SnowFallingonCedars),
(ScottH)-[:DIRECTED]->(SnowFallingonCedars)

CREATE (YouveGotMail:Movie {title:"You've Got Mail", released:1998, tagline:'At odds in life... in love on-line.'})
CREATE (ParkerP:Person {name:'Parker Posey', born:1968})
CREATE (DaveC:Person {name:'Dave Chappelle', born:1973})
CREATE (SteveZ:Person {name:'Steve Zahn', born:1967})
CREATE (TomH:Person {name:'Tom Hanks', born:1956})
CREATE (NoraE:Person {name:'Nora Ephron', born:1941})
CREATE
(TomH)-[:ACTED_IN {roles:['Joe Fox']}]->(YouveGotMail),
(MegR)-[:ACTED_IN {roles:['Kathleen Kelly']}]->(YouveGotMail),
(GregK)-[:ACTED_IN {roles:['Frank Navasky']}]->(YouveGotMail),
(ParkerP)-[:ACTED_IN {roles:['Patricia Eden']}]->(YouveGotMail),
(DaveC)-[:ACTED_IN {roles:['Kevin Jackson']}]->(YouveGotMail),
(SteveZ)-[:ACTED_IN {roles:['George Pappas']}]->(YouveGotMail),
(NoraE)-[:DIRECTED]->(YouveGotMail)

CREATE (SleeplessInSeattle:Movie {title:'Sleepless in Seattle', released:1993, tagline:'What if someone you never met, someone you never saw, someone you never knew was the only someone for you?'})
CREATE (RitaW:Person {name:'Rita Wilson', born:1956})
CREATE (BillPull:Person {name:'Bill Pullman', born:1953})
CREATE (VictorG:Person {name:'Victor Garber', born:1949})
CREATE (RosieO:Person {name:"Rosie O'Donnell", born:1962})
CREATE
(TomH)-[:ACTED_IN {roles:['Sam Baldwin']}]->(SleeplessInSeattle),
(MegR)-[:ACTED_IN {roles:['Annie Reed']}]->(SleeplessInSeattle),
(RitaW)-[:ACTED_IN {roles:['Suzy']}]->(SleeplessInSeattle),
(BillPull)-[:ACTED_IN {roles:['Walter']}]->(SleeplessInSeattle),
(VictorG)-[:ACTED_IN {roles:['Greg']}]->(SleeplessInSeattle),
(RosieO)-[:ACTED_IN {roles:['Becky']}]->(SleeplessInSeattle),
(NoraE)-[:DIRECTED]->(SleeplessInSeattle)

CREATE (JoeVersustheVolcano:Movie {title:'Joe Versus the Volcano', released:1990, tagline:'A story of love, lava and burning desire.'})
CREATE (JohnS:Person {name:'John Patrick Stanley', born:1950})
CREATE (Nathan:Person {name:'Nathan Lane', born:1956})
CREATE
(TomH)-[:ACTED_IN {roles:['Joe Banks']}]->(JoeVersustheVolcano),
(MegR)-[:ACTED_IN {roles:['DeDe', 'Angelica Graynamore', 'Patricia Graynamore']}]->(JoeVersustheVolcano),
(Nathan)-[:ACTED_IN {roles:['Baw']}]->(JoeVersustheVolcano),
(JohnS)-[:DIRECTED]->(JoeVersustheVolcano)

CREATE (WhenHarryMetSally:Movie {title:'When Harry Met Sally', released:1998, tagline:'Can two friends sleep together and still love each other in the morning?'})
CREATE (BillyC:Person {name:'Billy Crystal', born:1948})
CREATE (CarrieF:Person {name:'Carrie Fisher', born:1956})
CREATE (BrunoK:Person {name:'Bruno Kirby', born:1949})
CREATE
(BillyC)-[:ACTED_IN {roles:['Harry Burns']}]->(WhenHarryMetSally),
(MegR)-[:ACTED_IN {roles:['Sally Albright']}]->(WhenHarryMetSally),
(CarrieF)-[:ACTED_IN {roles:['Marie']}]->(WhenHarryMetSally),
(BrunoK)-[:ACTED_IN {roles:['Jess']}]->(WhenHarryMetSally),
(RobR)-[:DIRECTED]->(WhenHarryMetSally),
(RobR)-[:PRODUCED]->(WhenHarryMetSally),
(NoraE)-[:PRODUCED]->(WhenHarryMetSally),
(NoraE)-[:WROTE]->(WhenHarryMetSally)

CREATE (ThatThingYouDo:Movie {title:'That Thing You Do', released:1996, tagline:'In every life there comes a time when that thing you dream becomes that thing you do'})
CREATE (LivT:Person {name:'Liv Tyler', born:1977})
CREATE
(TomH)-[:ACTED_IN {roles:['Mr. White']}]->(ThatThingYouDo),
(LivT)-[:ACTED_IN {roles:['Faye Dolan']}]->(ThatThingYouDo),
(Charlize)-[:ACTED_IN {roles:['Tina']}]->(ThatThingYouDo),
(TomH)-[:DIRECTED]->(ThatThingYouDo)

CREATE (TheReplacements:Movie {title:'The Replacements', released:2000, tagline:'Pain heals, Chicks dig scars... Glory lasts forever'})
CREATE (Brooke:Person {name:'Brooke Langton', born:1970})
CREATE (Gene:Person {name:'Gene Hackman', born:1930})
CREATE (Orlando:Person {name:'Orlando Jones', born:1968})
CREATE (Howard:Person {name:'Howard Deutch', born:1950})
CREATE
(Keanu)-[:ACTED_IN {roles:['Shane Falco']}]->(TheReplacements),
(Brooke)-[:ACTED_IN {roles:['Annabelle Farrell']}]->(TheReplacements),
(Gene)-[:ACTED_IN {roles:['Jimmy McGinty']}]->(TheReplacements),
(Orlando)-[:ACTED_IN {roles:['Clifford Franklin']}]->(TheReplacements),
(Howard)-[:DIRECTED]->(TheReplacements)

CREATE (RescueDawn:Movie {title:'RescueDawn', released:2006, tagline:"Based on the extraordinary true story of one man's fight for freedom"})
CREATE (ChristianB:Person {name:'Christian Bale', born:1974})
CREATE (ZachG:Person {name:'Zach Grenier', born:1954})
CREATE
(MarshallB)-[:ACTED_IN {roles:['Admiral']}]->(RescueDawn),
(ChristianB)-[:ACTED_IN {roles:['Dieter Dengler']}]->(RescueDawn),
(ZachG)-[:ACTED_IN {roles:['Squad Leader']}]->(RescueDawn),
(SteveZ)-[:ACTED_IN {roles:['Duane']}]->(RescueDawn),
(WernerH)-[:DIRECTED]->(RescueDawn)

CREATE (TheBirdcage:Movie {title:'The Birdcage', released:1996, tagline:'Come as you are'})
CREATE (MikeN:Person {name:'Mike Nichols', born:1931})
CREATE
(Robin)-[:ACTED_IN {roles:['Armand Goldman']}]->(TheBirdcage),
(Nathan)-[:ACTED_IN {roles:['Albert Goldman']}]->(TheBirdcage),
(Gene)-[:ACTED_IN {roles:['Sen. Kevin Keeley']}]->(TheBirdcage),
(MikeN)-[:DIRECTED]->(TheBirdcage)

CREATE (Unforgiven:Movie {title:'Unforgiven', released:1992, tagline:"It's a hell of a thing, killing a man"})
CREATE (RichardH:Person {name:'Richard Harris', born:1930})
CREATE (ClintE:Person {name:'Clint Eastwood', born:1930})
CREATE
(RichardH)-[:ACTED_IN {roles:['English Bob']}]->(Unforgiven),
(ClintE)-[:ACTED_IN {roles:['Bill Munny']}]->(Unforgiven),
(Gene)-[:ACTED_IN {roles:['Little Bill Daggett']}]->(Unforgiven),
(ClintE)-[:DIRECTED]->(Unforgiven)

CREATE (JohnnyMnemonic:Movie {title:'Johnny Mnemonic', released:1995, tagline:'The hottest data on earth. In the coolest head in town'})
CREATE (Takeshi:Person {name:'Takeshi Kitano', born:1947})
CREATE (Dina:Person {name:'Dina Meyer', born:1968})
CREATE (IceT:Person {name:'Ice-T', born:1958})
CREATE (RobertL:Person {name:'Robert Longo', born:1953})
CREATE
(Keanu)-[:ACTED_IN {roles:['Johnny Mnemonic']}]->(JohnnyMnemonic),
(Takeshi)-[:ACTED_IN {roles:['Takahashi']}]->(JohnnyMnemonic),
(Dina)-[:ACTED_IN {roles:['Jane']}]->(JohnnyMnemonic),
(IceT)-[:ACTED_IN {roles:['J-Bone']}]->(JohnnyMnemonic),
(RobertL)-[:DIRECTED]->(JohnnyMnemonic)

CREATE (CloudAtlas:Movie {title:'Cloud Atlas', released:2012, tagline:'Everything is connected'})
CREATE (HalleB:Person {name:'Halle Berry', born:1966})
CREATE (JimB:Person {name:'Jim Broadbent', born:1949})
CREATE (TomT:Person {name:'Tom Tykwer', born:1965})
CREATE (DavidMitchell:Person {name:'David Mitchell', born:1969})
CREATE (StefanArndt:Person {name:'Stefan Arndt', born:1961})
CREATE
(TomH)-[:ACTED_IN {roles:['Zachry', 'Dr. Henry Goose', 'Isaac Sachs', 'Dermot Hoggins']}]->(CloudAtlas),
(Hugo)-[:ACTED_IN {roles:['Bill Smoke', 'Haskell Moore', 'Tadeusz Kesselring', 'Nurse Noakes', 'Boardman Mephi', 'Old Georgie']}]->(CloudAtlas),
(HalleB)-[:ACTED_IN {roles:['Luisa Rey', 'Jocasta Ayrs', 'Ovid', 'Meronym']}]->(CloudAtlas),
(JimB)-[:ACTED_IN {roles:['Vyvyan Ayrs', 'Captain Molyneux', 'Timothy Cavendish']}]->(CloudAtlas),
(TomT)-[:DIRECTED]->(CloudAtlas),
(LillyW)-[:DIRECTED]->(CloudAtlas),
(LanaW)-[:DIRECTED]->(CloudAtlas),
(DavidMitchell)-[:WROTE]->(CloudAtlas),
(StefanArndt)-[:PRODUCED]->(CloudAtlas)

CREATE (TheDaVinciCode:Movie {title:'The Da Vinci Code', released:2006, tagline:'Break The Codes'})
CREATE (IanM:Person {name:'Ian McKellen', born:1939})
CREATE (AudreyT:Person {name:'Audrey Tautou', born:1976})
CREATE (PaulB:Person {name:'Paul Bettany', born:1971})
CREATE (RonH:Person {name:'Ron Howard', born:1954})
CREATE
(TomH)-[:ACTED_IN {roles:['Dr. Robert Langdon']}]->(TheDaVinciCode),
(IanM)-[:ACTED_IN {roles:['Sir Leight Teabing']}]->(TheDaVinciCode),
(AudreyT)-[:ACTED_IN {roles:['Sophie Neveu']}]->(TheDaVinciCode),
(PaulB)-[:ACTED_IN {roles:['Silas']}]->(TheDaVinciCode),
(RonH)-[:DIRECTED]->(TheDaVinciCode)

CREATE (VforVendetta:Movie {title:'V for Vendetta', released:2006, tagline:'Freedom! Forever!'})
CREATE (NatalieP:Person {name:'Natalie Portman', born:1981})
CREATE (StephenR:Person {name:'Stephen Rea', born:1946})
CREATE (JohnH:Person {name:'John Hurt', born:1940})
CREATE (BenM:Person {name: 'Ben Miles', born:1967})
CREATE
(Hugo)-[:ACTED_IN {roles:['V']}]->(VforVendetta),
(NatalieP)-[:ACTED_IN {roles:['Evey Hammond']}]->(VforVendetta),
(StephenR)-[:ACTED_IN {roles:['Eric Finch']}]->(VforVendetta),
(JohnH)-[:ACTED_IN {roles:['High Chancellor Adam Sutler']}]->(VforVendetta),
(BenM)-[:ACTED_IN {roles:['Dascomb']}]->(VforVendetta),
(JamesM)-[:DIRECTED]->(VforVendetta),
(LillyW)-[:PRODUCED]->(VforVendetta),
(LanaW)-[:PRODUCED]->(VforVendetta),
(JoelS)-[:PRODUCED]->(VforVendetta),
(LillyW)-[:WROTE]->(VforVendetta),
(LanaW)-[:WROTE]->(VforVendetta)

CREATE (SpeedRacer:Movie {title:'Speed Racer', released:2008, tagline:'Speed has no limits'})
CREATE (EmileH:Person {name:'Emile Hirsch', born:1985})
CREATE (JohnG:Person {name:'John Goodman', born:1960})
CREATE (SusanS:Person {name:'Susan Sarandon', born:1946})
CREATE (MatthewF:Person {name:'Matthew Fox', born:1966})
CREATE (ChristinaR:Person {name:'Christina Ricci', born:1980})
CREATE (Rain:Person {name:'Rain', born:1982})
CREATE
(EmileH)-[:ACTED_IN {roles:['Speed Racer']}]->(SpeedRacer),
(JohnG)-[:ACTED_IN {roles:['Pops']}]->(SpeedRacer),
(SusanS)-[:ACTED_IN {roles:['Mom']}]->(SpeedRacer),
(MatthewF)-[:ACTED_IN {roles:['Racer X']}]->(SpeedRacer),
(ChristinaR)-[:ACTED_IN {roles:['Trixie']}]->(SpeedRacer),
(Rain)-[:ACTED_IN {roles:['Taejo Togokahn']}]->(SpeedRacer),
(BenM)-[:ACTED_IN {roles:['Cass Jones']}]->(SpeedRacer),
(LillyW)-[:DIRECTED]->(SpeedRacer),
(LanaW)-[:DIRECTED]->(SpeedRacer),
(LillyW)-[:WROTE]->(SpeedRacer),
(LanaW)-[:WROTE]->(SpeedRacer),
(JoelS)-[:PRODUCED]->(SpeedRacer)

CREATE (NinjaAssassin:Movie {title:'Ninja Assassin', released:2009, tagline:'Prepare to enter a secret world of assassins'})
CREATE (NaomieH:Person {name:'Naomie Harris'})
CREATE
(Rain)-[:ACTED_IN {roles:['Raizo']}]->(NinjaAssassin),
(NaomieH)-[:ACTED_IN {roles:['Mika Coretti']}]->(NinjaAssassin),
(RickY)-[:ACTED_IN {roles:['Takeshi']}]->(NinjaAssassin),
(BenM)-[:ACTED_IN {roles:['Ryan Maslow']}]->(NinjaAssassin),
(JamesM)-[:DIRECTED]->(NinjaAssassin),
(LillyW)-[:PRODUCED]->(NinjaAssassin),
(LanaW)-[:PRODUCED]->(NinjaAssassin),
(JoelS)-[:PRODUCED]->(NinjaAssassin)

CREATE (TheGreenMile:Movie {title:'The Green Mile', released:1999, tagline:"Walk a mile you'll never forget."})
CREATE (MichaelD:Person {name:'Michael Clarke Duncan', born:1957})
CREATE (DavidM:Person {name:'David Morse', born:1953})
CREATE (SamR:Person {name:'Sam Rockwell', born:1968})
CREATE (GaryS:Person {name:'Gary Sinise', born:1955})
CREATE (PatriciaC:Person {name:'Patricia Clarkson', born:1959})
CREATE (FrankD:Person {name:'Frank Darabont', born:1959})
CREATE
(TomH)-[:ACTED_IN {roles:['Paul Edgecomb']}]->(TheGreenMile),
(MichaelD)-[:ACTED_IN {roles:['John Coffey']}]->(TheGreenMile),
(DavidM)-[:ACTED_IN {roles:['Brutus "Brutal" Howell']}]->(TheGreenMile),
(BonnieH)-[:ACTED_IN {roles:['Jan Edgecomb']}]->(TheGreenMile),
(JamesC)-[:ACTED_IN {roles:['Warden Hal Moores']}]->(TheGreenMile),
(SamR)-[:ACTED_IN {roles:['"Wild Bill" Wharton']}]->(TheGreenMile),
(GaryS)-[:ACTED_IN {roles:['Burt Hammersmith']}]->(TheGreenMile),
(PatriciaC)-[:ACTED_IN {roles:['Melinda Moores']}]->(TheGreenMile),
(FrankD)-[:DIRECTED]->(TheGreenMile)

CREATE (FrostNixon:Movie {title:'Frost/Nixon', released:2008, tagline:'400 million people were waiting for the truth.'})
CREATE (FrankL:Person {name:'Frank Langella', born:1938})
CREATE (MichaelS:Person {name:'Michael Sheen', born:1969})
CREATE (OliverP:Person {name:'Oliver Platt', born:1960})
CREATE
(FrankL)-[:ACTED_IN {roles:['Richard Nixon']}]->(FrostNixon),
(MichaelS)-[:ACTED_IN {roles:['David Frost']}]->(FrostNixon),
(KevinB)-[:ACTED_IN {roles:['Jack Brennan']}]->(FrostNixon),
(OliverP)-[:ACTED_IN {roles:['Bob Zelnick']}]->(FrostNixon),
(SamR)-[:ACTED_IN {roles:['James Reston, Jr.']}]->(FrostNixon),
(RonH)-[:DIRECTED]->(FrostNixon)

CREATE (Hoffa:Movie {title:'Hoffa', released:1992, tagline:"He didn't want law. He wanted justice."})
CREATE (DannyD:Person {name:'Danny DeVito', born:1944})
CREATE (JohnR:Person {name:'John C. Reilly', born:1965})
CREATE
(JackN)-[:ACTED_IN {roles:['Hoffa']}]->(Hoffa),
(DannyD)-[:ACTED_IN {roles:['Robert "Bobby" Ciaro']}]->(Hoffa),
(JTW)-[:ACTED_IN {roles:['Frank Fitzsimmons']}]->(Hoffa),
(JohnR)-[:ACTED_IN {roles:['Peter "Pete" Connelly']}]->(Hoffa),
(DannyD)-[:DIRECTED]->(Hoffa)

CREATE (Apollo13:Movie {title:'Apollo 13', released:1995, tagline:'Houston, we have a problem.'})
CREATE (EdH:Person {name:'Ed Harris', born:1950})
CREATE (BillPax:Person {name:'Bill Paxton', born:1955})
CREATE
(TomH)-[:ACTED_IN {roles:['Jim Lovell']}]->(Apollo13),
(KevinB)-[:ACTED_IN {roles:['Jack Swigert']}]->(Apollo13),
(EdH)-[:ACTED_IN {roles:['Gene Kranz']}]->(Apollo13),
(BillPax)-[:ACTED_IN {roles:['Fred Haise']}]->(Apollo13),
(GaryS)-[:ACTED_IN {roles:['Ken Mattingly']}]->(Apollo13),
(RonH)-[:DIRECTED]->(Apollo13)

CREATE (Twister:Movie {title:'Twister', released:1996, tagline:"Don't Breathe. Don't Look Back."})
CREATE (PhilipH:Person {name:'Philip Seymour Hoffman', born:1967})
CREATE (JanB:Person {name:'Jan de Bont', born:1943})
CREATE
(BillPax)-[:ACTED_IN {roles:['Bill Harding']}]->(Twister),
(HelenH)-[:ACTED_IN {roles:['Dr. Jo Harding']}]->(Twister),
(ZachG)-[:ACTED_IN {roles:['Eddie']}]->(Twister),
(PhilipH)-[:ACTED_IN {roles:['Dustin "Dusty" Davis']}]->(Twister),
(JanB)-[:DIRECTED]->(Twister)

CREATE (CastAway:Movie {title:'Cast Away', released:2000, tagline:'At the edge of the world, his journey begins.'})
CREATE (RobertZ:Person {name:'Robert Zemeckis', born:1951})
CREATE
(TomH)-[:ACTED_IN {roles:['Chuck Noland']}]->(CastAway),
(HelenH)-[:ACTED_IN {roles:['Kelly Frears']}]->(CastAway),
(RobertZ)-[:DIRECTED]->(CastAway)

CREATE (OneFlewOvertheCuckoosNest:Movie {title:"One Flew Over the Cuckoo's Nest", released:1975, tagline:"If he's crazy, what does that make you?"})
CREATE (MilosF:Person {name:'Milos Forman', born:1932})
CREATE
(JackN)-[:ACTED_IN {roles:['Randle McMurphy']}]->(OneFlewOvertheCuckoosNest),
(DannyD)-[:ACTED_IN {roles:['Martini']}]->(OneFlewOvertheCuckoosNest),
(MilosF)-[:DIRECTED]->(OneFlewOvertheCuckoosNest)

CREATE (SomethingsGottaGive:Movie {title:"Something's Gotta Give", released:2003})
CREATE (DianeK:Person {name:'Diane Keaton', born:1946})
CREATE (NancyM:Person {name:'Nancy Meyers', born:1949})
CREATE
(JackN)-[:ACTED_IN {roles:['Harry Sanborn']}]->(SomethingsGottaGive),
(DianeK)-[:ACTED_IN {roles:['Erica Barry']}]->(SomethingsGottaGive),
(Keanu)-[:ACTED_IN {roles:['Julian Mercer']}]->(SomethingsGottaGive),
(NancyM)-[:DIRECTED]->(SomethingsGottaGive),
(NancyM)-[:PRODUCED]->(SomethingsGottaGive),
(NancyM)-[:WROTE]->(SomethingsGottaGive)

CREATE (BicentennialMan:Movie {title:'Bicentennial Man', released:1999, tagline:"One robot's 200 year journey to become an ordinary man."})
CREATE (ChrisC:Person {name:'Chris Columbus', born:1958})
CREATE
(Robin)-[:ACTED_IN {roles:['Andrew Marin']}]->(BicentennialMan),
(OliverP)-[:ACTED_IN {roles:['Rupert Burns']}]->(BicentennialMan),
(ChrisC)-[:DIRECTED]->(BicentennialMan)

CREATE (CharlieWilsonsWar:Movie {title:"Charlie Wilson's War", released:2007, tagline:"A stiff drink. A little mascara. A lot of nerve. Who said they couldn't bring down the Soviet empire."})
CREATE (JuliaR:Person {name:'Julia Roberts', born:1967})
CREATE
(TomH)-[:ACTED_IN {roles:['Rep. Charlie Wilson']}]->(CharlieWilsonsWar),
(JuliaR)-[:ACTED_IN {roles:['Joanne Herring']}]->(CharlieWilsonsWar),
(PhilipH)-[:ACTED_IN {roles:['Gust Avrakotos']}]->(CharlieWilsonsWar),
(MikeN)-[:DIRECTED]->(CharlieWilsonsWar)

CREATE (ThePolarExpress:Movie {title:'The Polar Express', released:2004, tagline:'This Holiday Season... Believe'})
CREATE
(TomH)-[:ACTED_IN {roles:['Hero Boy', 'Father', 'Conductor', 'Hobo', 'Scrooge', 'Santa Claus']}]->(ThePolarExpress),
(RobertZ)-[:DIRECTED]->(ThePolarExpress)

CREATE (ALeagueofTheirOwn:Movie {title:'A League of Their Own', released:1992, tagline:'Once in a lifetime you get a chance to do something different.'})
CREATE (Madonna:Person {name:'Madonna', born:1954})
CREATE (GeenaD:Person {name:'Geena Davis', born:1956})
CREATE (LoriP:Person {name:'Lori Petty', born:1963})
CREATE (PennyM:Person {name:'Penny Marshall', born:1943})
CREATE
(TomH)-[:ACTED_IN {roles:['Jimmy Dugan']}]->(ALeagueofTheirOwn),
(GeenaD)-[:ACTED_IN {roles:['Dottie Hinson']}]->(ALeagueofTheirOwn),
(LoriP)-[:ACTED_IN {roles:['Kit Keller']}]->(ALeagueofTheirOwn),
(RosieO)-[:ACTED_IN {roles:['Doris Murphy']}]->(ALeagueofTheirOwn),
(Madonna)-[:ACTED_IN {roles:['"All the Way" Mae Mordabito']}]->(ALeagueofTheirOwn),
(BillPax)-[:ACTED_IN {roles:['Bob Hinson']}]->(ALeagueofTheirOwn),
(PennyM)-[:DIRECTED]->(ALeagueofTheirOwn)

CREATE (PaulBlythe:Person {name:'Paul Blythe'})
CREATE (AngelaScope:Person {name:'Angela Scope'})
CREATE (JessicaThompson:Person {name:'Jessica Thompson'})
CREATE (JamesThompson:Person {name:'James Thompson'})

CREATE
(JamesThompson)-[:FOLLOWS]->(JessicaThompson),
(AngelaScope)-[:FOLLOWS]->(JessicaThompson),
(PaulBlythe)-[:FOLLOWS]->(AngelaScope)

CREATE
(JessicaThompson)-[:REVIEWED {summary:'An amazing journey', rating:95}]->(CloudAtlas),
(JessicaThompson)-[:REVIEWED {summary:'Silly, but fun', rating:65}]->(TheReplacements),
(JamesThompson)-[:REVIEWED {summary:'The coolest football movie ever', rating:100}]->(TheReplacements),
(AngelaScope)-[:REVIEWED {summary:'Pretty funny at times', rating:62}]->(TheReplacements),
(JessicaThompson)-[:REVIEWED {summary:'Dark, but compelling', rating:85}]->(Unforgiven),
(JessicaThompson)-[:REVIEWED {summary:"Slapstick redeemed only by the Robin Williams and Gene Hackman's stellar performances", rating:45}]->(TheBirdcage),
(JessicaThompson)-[:REVIEWED {summary:'A solid romp', rating:68}]->(TheDaVinciCode),
(JamesThompson)-[:REVIEWED {summary:'Fun, but a little far fetched', rating:65}]->(TheDaVinciCode),
(JessicaThompson)-[:REVIEWED {summary:'You had me at Jerry', rating:92}]->(JerryMaguire)

WITH TomH as a
MATCH (a)-[:ACTED_IN]->(m)<-[:DIRECTED]-(d) RETURN a,m,d LIMIT 10;

// Generated data.

// Create a new movie with various data types
CREATE (Inception:Movie:GeneratedByClaudeAI {
    title: 'Inception',
    released: 2010,
    tagline: 'Your mind is the scene of the crime',
    budget: 160000000,
    revenue: 836800000,
    runtime_minutes: 148,
    rating_avg: 8.9,
    releaseDate: date('2010-07-16'),
    digitalRelease: datetime('2010-12-03T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Inception'})
SET m.ratings = [8.8, 9.2, 8.7, 8.9]
SET m.genres = ['sci-fi', 'action', 'thriller']
SET m.certifications = ['PG-13', '12A']
SET m.filmingLocationLat = [37.7749, 48.8566, -33.8688]
SET m.filmingLocationLong = [-122.4194, 2.3522, 151.2093]
SET m.boxOfficeNA = 292576195
SET m.boxOfficeEurope = 273417430
SET m.boxOfficeAsia = 159265823
SET m.boxOfficeOther = 111540552;

// Create a director with temporal, boolean, spatial data types
CREATE (ChristopherN:Person:GeneratedByClaudeAI {
    name: 'Christopher Nolan',
    born: 1970,
    birthdate: date('1970-07-30'),
    nationality: 'British-American',
    oscarNominations: 5,
    activeYears: duration({years: 25}),
    isActive: true,
    residenceLat: 34.0522,
    residenceLong: -118.2437,
    lastDirected: datetime('2023-07-21T00:00:00Z'),
    typicalFilmLengthHrs: 2.5
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'})
SET p.preferredAspectRatios = ['2.20:1', '2.35:1', '1.43:1']
SET p.collaborators = ['Hans Zimmer', 'Hoyte van Hoytema', 'Lee Smith'];

// Create an actor with mixed data types
CREATE (LeonardoD:Person:GeneratedByClaudeAI {
    name: 'Leonardo DiCaprio',
    born: 1974, 
    birthdate: date('1974-11-11'),
    oscarWins: 1,
    oscarNominations: 7,
    netWorth: 260000000,
    isActive: true,
    heightInMeters: 1.83,
    firstOscarWin: date('2016-02-28'),
    actingRangeScore: 9.5,
    typicalShootScheduleMonths: 4
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Leonardo DiCaprio'})
SET p.languages = ['English', 'Italian']
SET p.residenceLats = [34.0522, 40.7128]
SET p.residenceLongs = [-118.2437, -74.0060]
SET p.filmCountDrama = 12
SET p.filmCountThriller = 8
SET p.filmCountCrime = 5
SET p.filmCountRomance = 3
SET p.filmCountWestern = 1;

// Create another actress with additional temporal data
CREATE (MarionC:Person:GeneratedByClaudeAI {
    name: 'Marion Cotillard',
    born: 1975,
    birthdate: date('1975-09-30'),
    nationality: 'French',
    oscarWins: 1,
    isActive: true,
    firstFilm: datetime('1994-01-15T00:00:00Z'),
    oscarCeremony: localdatetime('2008-02-24T18:30:00'),
    typicalDay: localtime('08:00:00'),
    acceptedFilmStart: time('09:00:00+01:00')
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Marion Cotillard'})
SET p.languages = ['French', 'English', 'Italian']
SET p.filmography_titles = ['La Vie en Rose', 'Inception', 'The Dark Knight Rises']
SET p.filmography_years = [2007, 2010, 2012]
SET p.filmography_roles = ['Édith Piaf', 'Mal Cobb', 'Miranda Tate'];

// Create an actor with null values
CREATE (JosephG:Person:GeneratedByClaudeAI {
    name: 'Joseph Gordon-Levitt',
    born: 1981,
    birthdate: date('1981-02-17'),
    spouseName: null,
    oscarWins: 0,
    height: 178,
    weight: 70,
    upcomingProjects: null,
    isCurrentlyFilming: false
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Joseph Gordon-Levitt'})
SET p.activityDays = ['Monday', 'Wednesday', 'Friday']
SET p.activityTypes = ['Rehearsal', 'Filming', 'Voice work']
SET p.activityDurations = [6, 12, 4];

// Create an award ceremony with date, time, and duration
CREATE (AcademyAwards:Ceremony:GeneratedByClaudeAI {
    name: 'Academy Awards',
    nickname: 'Oscars',
    established: date('1929-05-16'),
    ceremonyTime: localtime('17:00:00'),
    typicalDurationHrs: 3.5,
    isPrestigious: true,
    locationLat: 34.1022,
    locationLong: -118.3437,
    locationHeight: 10,
    nextCeremony: datetime('2026-02-28T17:00:00-08:00')
})
WITH 1 as dummy
MATCH (c:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
SET c.categories = ['Best Picture', 'Best Director', 'Best Actor', 'Best Actress']
SET c.viewership2020 = 23600000
SET c.viewership2021 = 10400000
SET c.viewership2022 = 16600000
SET c.viewership2023 = 18700000;

// Create a Studio with array properties
CREATE (WarnerBros:Studio:GeneratedByClaudeAI {
    name: 'Warner Bros. Pictures',
    founded: date('1923-04-04'),
    headquartersLat: 34.1516,
    headquartersLong: -118.3376,
    yearlyRevenue2020: 12500000000,
    yearlyRevenue2021: 15800000000,
    yearlyRevenue2022: 17200000000,
    digitalStreamingDate: datetime('2021-05-15T00:00:00Z'),
    isPublic: true,
    marketShare: 0.184
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'})
SET s.subsidiaries = ['New Line Cinema', 'DC Films', 'Warner Animation Group']
SET s.distributionMarkets = ['North America', 'Europe', 'Asia', 'Oceania', 'Africa']
SET s.studioLotsLat = [34.1516, 51.5400]
SET s.studioLotsLong = [-118.3376, -0.4178];

// Create a filming event with date, time, and duration
CREATE (InceptionFilming:Production:GeneratedByClaudeAI {
    name: 'Inception Principal Photography',
    startDate: date('2009-07-13'),
    endDate: date('2009-11-22'),
    durationMonths: 4,
    durationDays: 9, 
    startTime: localtime('07:30:00'),
    isCompleted: true,
    budgetPersonnel: 40000000,
    budgetEquipment: 15000000,
    budgetLocations: 25000000,
    budgetVFX: 50000000,
    budgetOther: 30000000,
    weatherGood: 75,
    weatherAcceptable: 20,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Inception Principal Photography'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['05:00:00', '07:00:00', '07:30:00', '19:30:00']
SET p.scheduleDurations = [2, 0.5, 12, 1];

// Add review with mixed types
CREATE (InceptionReview:Review:GeneratedByClaudeAI {
    title: 'A Mind-Bending Masterpiece',
    stars: 4.8,
    date: date('2010-07-18'),
    time: time('14:23:45+01:00'),
    isVerified: true,
    aspectDirection: 5.0, 
    aspectActing: 4.9,
    aspectVisuals: 5.0,
    aspectMusic: 4.8,
    aspectPlot: 4.5,
    reviewText: 'Christopher Nolan delivers a mind-bending masterpiece with Inception. The intricate plot about dream thieves attempting the impossible task of inception is executed brilliantly.',
    upvotes: 3452
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'A Mind-Bending Masterpiece'})
SET r.commentTimestamps = [datetime('2010-07-18T17:22:43Z'), datetime('2010-07-19T08:15:12Z'), datetime('2010-07-20T21:32:01Z')]
SET r.keywords = ['mind-bending', 'dreams', 'sci-fi', 'heist']
SET r.readerLocationsLat = [40.7128, 51.5074, 48.8566]
SET r.readerLocationsLong = [-74.0060, -0.1278, 2.3522];

// Create relationships between nodes with various data types
MATCH 
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (c)-[:DIRECTED {
    year: 2010,
    daysOnSet: 133,
    satisfaction: 4.9,
    awardNominations: 8,
    completionDate: date('2009-12-15'),
    premiereEvent: datetime('2010-07-08T19:00:00+01:00'),
    durationMonths: 5,
    isFirstCollaboration: false
}]->(i);

// Actor to Movie relationships
MATCH
  (l:Person:GeneratedByClaudeAI {name: 'Leonardo DiCaprio'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (l)-[:ACTED_IN {
    roles: ['Dom Cobb'],
    salary: 20000000,
    screenTimeMinutes: 148,
    startDate: date('2009-07-13'),
    endDate: date('2009-11-22'),
    scheduleConflicts: false,
    criticScore: 95,
    audienceScore: 91,
    awardNominations: 3
}]->(i);

MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Marion Cotillard'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (m)-[:ACTED_IN {
    roles: ['Mal Cobb'],
    salary: 2000000,
    screenTimeMinutes: 45,
    startDate: date('2009-08-10'),
    endDate: date('2009-09-30'),
    scheduleConflicts: false,
    performanceRating: 4.8
}]->(i);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Joseph Gordon-Levitt'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (j)-[:ACTED_IN {
    roles: ['Arthur'],
    salary: 1500000,
    screenTimeMinutes: 73,
    startDate: date('2009-07-13'),
    endDate: date('2009-10-15'),
    stuntPerformed: true,
    trainingPeriodWeeks: 3
}]->(i);

// Production relationships
MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (w)-[:PRODUCED {
    investment: 160000000,
    return: 836800000,
    roi: 5.23,
    contractSigned: date('2008-12-01'),
    studioShare: 0.6,
    directorShare: 0.15,
    producerShare: 0.15,
    topCastShare: 0.1,
    marketingBudget: 100000000,
    isProfitable: true,
    marketingStart: datetime('2010-01-15T00:00:00Z')
}]->(i);

// Studio to filming relationship
MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (p:Production:GeneratedByClaudeAI {name: 'Inception Principal Photography'})
CREATE (w)-[:FINANCED {
    contractDate: date('2008-12-01'),
    amount: 160000000,
    isFullyPaid: true
}]->(p);

// Filming to movie relationship
MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Inception Principal Photography'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 4,
    durationDays: 9,
    locationCount: 6,
    dailyAverageCost: 480000,
    scheduleAdherence: 0.95,
    weatherDelaysDays: 5,
    originalScheduledEnd: date('2009-11-15')
}]->(i);

// Review relationships
MATCH
  (j:Person {name: 'Jessica Thompson'}), // Original person from the graph
  (r:Review:GeneratedByClaudeAI {title: 'A Mind-Bending Masterpiece'})
CREATE (j)-[:WROTE {
    date: date('2010-07-18'),
    timeSpentMinutes: 45,
    wordCount: 523,
    isVerified: true,
    submissionTime: time('14:23:45+01:00')
}]->(r);

MATCH
  (r:Review:GeneratedByClaudeAI {title: 'A Mind-Bending Masterpiece'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (r)-[:FOR_MOVIE {
    isPublished: true,
    views: 128634,
    shares: 4327,
    comments: 1252,
    featuredDurationDays: 14,
    publicationDateTime: datetime('2010-07-18T14:30:00+01:00')
}]->(i);

// Award relationship
MATCH
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (i)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 2011,
    ceremony: 83,
    isWinner: false,
    ceremonyDate: date('2011-02-27'),
    announcementTime: localtime('21:45:00'),
    votesFor: 2345,
    votesAgainst: 2567
}]->(a);

MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (c)-[:NOMINATED_FOR {
    category: 'Best Director',
    year: 2011,
    ceremony: 83,
    isWinner: false,
    ceremonyDate: date('2011-02-27'),
    announcementTime: localtime('20:30:00'),
    votesFor: 2132,
    votesAgainst: 2780
}]->(a);

// Additional connections to existing graph
MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (t:Person {name: 'Tom Hanks'}) // Original person from the graph
CREATE (c)-[:KNOWS {
    since: date('2002-01-15'),
    projects: 3,
    relationship: 'Professional',
    lastContact: datetime('2023-05-15T14:30:00Z'),
    nextMeeting: datetime('2025-04-10T09:00:00Z')
}]->(t);

MATCH
  (l:Person:GeneratedByClaudeAI {name: 'Leonardo DiCaprio'}),
  (t:Person {name: 'Tom Hanks'}) // Original person from the graph
CREATE (l)-[:KNOWS {
    since: date('1997-10-12'),
    relationship: 'Friends',
    lastCollaboration: date('2015-12-25'),
    durationYears: 26,
    project1: 'The Revenant',
    year1: 2015,
    project2: 'Django Unchained',
    year2: 2012
}]->(t);

// Set transfer times for the FINANCED relationship
MATCH (:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'})-[r:FINANCED]-(:Production:GeneratedByClaudeAI {name: 'Inception Principal Photography'})
SET r.transferTime1 = datetime('2009-01-15T00:00:00Z')
SET r.transferTime2 = datetime('2009-04-15T00:00:00Z')
SET r.transferTime3 = datetime('2009-07-15T00:00:00Z')
SET r.paymentDate1 = date('2009-01-15')
SET r.paymentAmount1 = 40000000
SET r.paymentDate2 = date('2009-04-15')
SET r.paymentAmount2 = 60000000
SET r.paymentDate3 = date('2009-07-15')
SET r.paymentAmount3 = 60000000;

// Set presenters for NOMINATED_FOR relationship
MATCH (:Movie:GeneratedByClaudeAI {title: 'Inception'})-[r:NOMINATED_FOR]-(:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
SET r.presenter1 = 'Tom Hanks'
SET r.presenter2 = 'Natalie Portman';

// STEP 2: add additionald ata types.
// Create a new movie with various data types
CREATE (Inception:Movie:GeneratedByClaudeAI {
    title: 'Inception',
    released: 2010,
    tagline: 'Your mind is the scene of the crime',
    budget: 160000000,
    revenue: 836800000,
    runtime_minutes: 148,
    rating_avg: 8.9,
    releaseDate: date('2010-07-16'),
    digitalRelease: datetime('2010-12-03T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Inception'})
SET m.ratings = [8.8, 9.2, 8.7, 8.9]
SET m.genres = ['sci-fi', 'action', 'thriller']
SET m.certifications = ['PG-13', '12A']
SET m.filmingLocationLat = [37.7749, 48.8566, -33.8688]
SET m.filmingLocationLong = [-122.4194, 2.3522, 151.2093]
SET m.boxOfficeNA = 292576195
SET m.boxOfficeEurope = 273417430
SET m.boxOfficeAsia = 159265823
SET m.boxOfficeOther = 111540552;

// Create a director with temporal, boolean, spatial data types
CREATE (ChristopherN:Person:GeneratedByClaudeAI {
    name: 'Christopher Nolan',
    born: 1970,
    birthdate: date('1970-07-30'),
    nationality: 'British-American',
    oscarNominations: 5,
    activeYears: duration({years: 25}),
    isActive: true,
    residenceLat: 34.0522,
    residenceLong: -118.2437,
    lastDirected: datetime('2023-07-21T00:00:00Z'),
    typicalFilmLengthHrs: 2.5
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'})
SET p.preferredAspectRatios = ['2.20:1', '2.35:1', '1.43:1']
SET p.collaborators = ['Hans Zimmer', 'Hoyte van Hoytema', 'Lee Smith'];

// Create an actor with mixed data types
CREATE (LeonardoD:Person:GeneratedByClaudeAI {
    name: 'Leonardo DiCaprio',
    born: 1974, 
    birthdate: date('1974-11-11'),
    oscarWins: 1,
    oscarNominations: 7,
    netWorth: 260000000,
    isActive: true,
    heightInMeters: 1.83,
    firstOscarWin: date('2016-02-28'),
    actingRangeScore: 9.5,
    typicalShootScheduleMonths: 4
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Leonardo DiCaprio'})
SET p.languages = ['English', 'Italian']
SET p.residenceLats = [34.0522, 40.7128]
SET p.residenceLongs = [-118.2437, -74.0060]
SET p.filmCountDrama = 12
SET p.filmCountThriller = 8
SET p.filmCountCrime = 5
SET p.filmCountRomance = 3
SET p.filmCountWestern = 1;

// Create another actress with additional temporal data
CREATE (MarionC:Person:GeneratedByClaudeAI {
    name: 'Marion Cotillard',
    born: 1975,
    birthdate: date('1975-09-30'),
    nationality: 'French',
    oscarWins: 1,
    isActive: true,
    firstFilm: datetime('1994-01-15T00:00:00Z'),
    oscarCeremony: localdatetime('2008-02-24T18:30:00'),
    typicalDay: localtime('08:00:00'),
    acceptedFilmStart: time('09:00:00+01:00')
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Marion Cotillard'})
SET p.languages = ['French', 'English', 'Italian']
SET p.filmography_titles = ['La Vie en Rose', 'Inception', 'The Dark Knight Rises']
SET p.filmography_years = [2007, 2010, 2012]
SET p.filmography_roles = ['Édith Piaf', 'Mal Cobb', 'Miranda Tate'];

// Create an actor with null values
CREATE (JosephG:Person:GeneratedByClaudeAI {
    name: 'Joseph Gordon-Levitt',
    born: 1981,
    birthdate: date('1981-02-17'),
    spouseName: null,
    oscarWins: 0,
    height: 178,
    weight: 70,
    upcomingProjects: null,
    isCurrentlyFilming: false
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Joseph Gordon-Levitt'})
SET p.activityDays = ['Monday', 'Wednesday', 'Friday']
SET p.activityTypes = ['Rehearsal', 'Filming', 'Voice work']
SET p.activityDurations = [6, 12, 4];

// Create an award ceremony with date, time, and duration
CREATE (AcademyAwards:Ceremony:GeneratedByClaudeAI {
    name: 'Academy Awards',
    nickname: 'Oscars',
    established: date('1929-05-16'),
    ceremonyTime: localtime('17:00:00'),
    typicalDurationHrs: 3.5,
    isPrestigious: true,
    locationLat: 34.1022,
    locationLong: -118.3437,
    locationHeight: 10,
    nextCeremony: datetime('2026-02-28T17:00:00-08:00')
})
WITH 1 as dummy
MATCH (c:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
SET c.categories = ['Best Picture', 'Best Director', 'Best Actor', 'Best Actress']
SET c.viewership2020 = 23600000
SET c.viewership2021 = 10400000
SET c.viewership2022 = 16600000
SET c.viewership2023 = 18700000;

// Create a Studio with array properties
CREATE (WarnerBros:Studio:GeneratedByClaudeAI {
    name: 'Warner Bros. Pictures',
    founded: date('1923-04-04'),
    headquartersLat: 34.1516,
    headquartersLong: -118.3376,
    yearlyRevenue2020: 12500000000,
    yearlyRevenue2021: 15800000000,
    yearlyRevenue2022: 17200000000,
    digitalStreamingDate: datetime('2021-05-15T00:00:00Z'),
    isPublic: true,
    marketShare: 0.184
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'})
SET s.subsidiaries = ['New Line Cinema', 'DC Films', 'Warner Animation Group']
SET s.distributionMarkets = ['North America', 'Europe', 'Asia', 'Oceania', 'Africa']
SET s.studioLotsLat = [34.1516, 51.5400]
SET s.studioLotsLong = [-118.3376, -0.4178];

// Create a filming event with date, time, and duration
CREATE (InceptionFilming:Production:GeneratedByClaudeAI {
    name: 'Inception Principal Photography',
    startDate: date('2009-07-13'),
    endDate: date('2009-11-22'),
    durationMonths: 4,
    durationDays: 9, 
    startTime: localtime('07:30:00'),
    isCompleted: true,
    budgetPersonnel: 40000000,
    budgetEquipment: 15000000,
    budgetLocations: 25000000,
    budgetVFX: 50000000,
    budgetOther: 30000000,
    weatherGood: 75,
    weatherAcceptable: 20,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Inception Principal Photography'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['05:00:00', '07:00:00', '07:30:00', '19:30:00']
SET p.scheduleDurations = [2, 0.5, 12, 1];

// Add review with mixed types
CREATE (InceptionReview:Review:GeneratedByClaudeAI {
    title: 'A Mind-Bending Masterpiece',
    stars: 4.8,
    date: date('2010-07-18'),
    time: time('14:23:45+01:00'),
    isVerified: true,
    aspectDirection: 5.0, 
    aspectActing: 4.9,
    aspectVisuals: 5.0,
    aspectMusic: 4.8,
    aspectPlot: 4.5,
    reviewText: 'Christopher Nolan delivers a mind-bending masterpiece with Inception. The intricate plot about dream thieves attempting the impossible task of inception is executed brilliantly.',
    upvotes: 3452
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'A Mind-Bending Masterpiece'})
SET r.commentTimestamps = [datetime('2010-07-18T17:22:43Z'), datetime('2010-07-19T08:15:12Z'), datetime('2010-07-20T21:32:01Z')]
SET r.keywords = ['mind-bending', 'dreams', 'sci-fi', 'heist']
SET r.readerLocationsLat = [40.7128, 51.5074, 48.8566]
SET r.readerLocationsLong = [-74.0060, -0.1278, 2.3522];

// Create relationships between nodes with various data types
MATCH 
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (c)-[:DIRECTED {
    year: 2010,
    daysOnSet: 133,
    satisfaction: 4.9,
    awardNominations: 8,
    completionDate: date('2009-12-15'),
    premiereEvent: datetime('2010-07-08T19:00:00+01:00'),
    durationMonths: 5,
    isFirstCollaboration: false
}]->(i);

// Actor to Movie relationships
MATCH
  (l:Person:GeneratedByClaudeAI {name: 'Leonardo DiCaprio'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (l)-[:ACTED_IN {
    roles: ['Dom Cobb'],
    salary: 20000000,
    screenTimeMinutes: 148,
    startDate: date('2009-07-13'),
    endDate: date('2009-11-22'),
    scheduleConflicts: false,
    criticScore: 95,
    audienceScore: 91,
    awardNominations: 3
}]->(i);

MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Marion Cotillard'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (m)-[:ACTED_IN {
    roles: ['Mal Cobb'],
    salary: 2000000,
    screenTimeMinutes: 45,
    startDate: date('2009-08-10'),
    endDate: date('2009-09-30'),
    scheduleConflicts: false,
    performanceRating: 4.8
}]->(i);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Joseph Gordon-Levitt'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (j)-[:ACTED_IN {
    roles: ['Arthur'],
    salary: 1500000,
    screenTimeMinutes: 73,
    startDate: date('2009-07-13'),
    endDate: date('2009-10-15'),
    stuntPerformed: true,
    trainingPeriodWeeks: 3
}]->(i);

// Production relationships
MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (w)-[:PRODUCED {
    investment: 160000000,
    return: 836800000,
    roi: 5.23,
    contractSigned: date('2008-12-01'),
    studioShare: 0.6,
    directorShare: 0.15,
    producerShare: 0.15,
    topCastShare: 0.1,
    marketingBudget: 100000000,
    isProfitable: true,
    marketingStart: datetime('2010-01-15T00:00:00Z')
}]->(i);

// Studio to filming relationship
MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (p:Production:GeneratedByClaudeAI {name: 'Inception Principal Photography'})
CREATE (w)-[:FINANCED {
    contractDate: date('2008-12-01'),
    amount: 160000000,
    isFullyPaid: true
}]->(p);

// Filming to movie relationship
MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Inception Principal Photography'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 4,
    durationDays: 9,
    locationCount: 6,
    dailyAverageCost: 480000,
    scheduleAdherence: 0.95,
    weatherDelaysDays: 5,
    originalScheduledEnd: date('2009-11-15')
}]->(i);

// Review relationships
MATCH
  (j:Person {name: 'Jessica Thompson'}), // Original person from the graph
  (r:Review:GeneratedByClaudeAI {title: 'A Mind-Bending Masterpiece'})
CREATE (j)-[:WROTE {
    date: date('2010-07-18'),
    timeSpentMinutes: 45,
    wordCount: 523,
    isVerified: true,
    submissionTime: time('14:23:45+01:00')
}]->(r);

MATCH
  (r:Review:GeneratedByClaudeAI {title: 'A Mind-Bending Masterpiece'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (r)-[:FOR_MOVIE {
    isPublished: true,
    views: 128634,
    shares: 4327,
    comments: 1252,
    featuredDurationDays: 14,
    publicationDateTime: datetime('2010-07-18T14:30:00+01:00')
}]->(i);

// Award relationship
MATCH
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (i)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 2011,
    ceremony: 83,
    isWinner: false,
    ceremonyDate: date('2011-02-27'),
    announcementTime: localtime('21:45:00'),
    votesFor: 2345,
    votesAgainst: 2567
}]->(a);

MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (c)-[:NOMINATED_FOR {
    category: 'Best Director',
    year: 2011,
    ceremony: 83,
    isWinner: false,
    ceremonyDate: date('2011-02-27'),
    announcementTime: localtime('20:30:00'),
    votesFor: 2132,
    votesAgainst: 2780
}]->(a);

// Additional connections to existing graph
MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (t:Person {name: 'Tom Hanks'}) // Original person from the graph
CREATE (c)-[:KNOWS {
    since: date('2002-01-15'),
    projects: 3,
    relationship: 'Professional',
    lastContact: datetime('2023-05-15T14:30:00Z'),
    nextMeeting: datetime('2025-04-10T09:00:00Z')
}]->(t);

MATCH
  (l:Person:GeneratedByClaudeAI {name: 'Leonardo DiCaprio'}),
  (t:Person {name: 'Tom Hanks'}) // Original person from the graph
CREATE (l)-[:KNOWS {
    since: date('1997-10-12'),
    relationship: 'Friends',
    lastCollaboration: date('2015-12-25'),
    durationYears: 26,
    project1: 'The Revenant',
    year1: 2015,
    project2: 'Django Unchained',
    year2: 2012
}]->(t);

// Set transfer times for the FINANCED relationship
MATCH (:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'})-[r:FINANCED]-(:Production:GeneratedByClaudeAI {name: 'Inception Principal Photography'})
SET r.transferTime1 = datetime('2009-01-15T00:00:00Z')
SET r.transferTime2 = datetime('2009-04-15T00:00:00Z')
SET r.transferTime3 = datetime('2009-07-15T00:00:00Z')
SET r.paymentDate1 = date('2009-01-15')
SET r.paymentAmount1 = 40000000
SET r.paymentDate2 = date('2009-04-15')
SET r.paymentAmount2 = 60000000
SET r.paymentDate3 = date('2009-07-15')
SET r.paymentAmount3 = 60000000;

// Set presenters for NOMINATED_FOR relationship
MATCH (:Movie:GeneratedByClaudeAI {title: 'Inception'})-[r:NOMINATED_FOR]-(:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
SET r.presenter1 = 'Tom Hanks'
SET r.presenter2 = 'Natalie Portman';

// STEP 3: expanding the movie graph... a lot.
// Create a new modern movie with various data types
CREATE (Interstellar:Movie:GeneratedByClaudeAI {
    title: 'Interstellar', 
    released: 2014,
    tagline: 'Mankind was born on Earth. It was never meant to die here.',
    budget: 165000000,
    revenue: 701800000,
    runtime_minutes: 169,
    rating_avg: 8.6,
    releaseDate: date('2014-11-07'),
    digitalRelease: datetime('2015-03-31T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Interstellar'})
SET m.ratings = [8.5, 8.9, 8.3, 8.7]
SET m.genres = ['sci-fi', 'drama', 'adventure']
SET m.certifications = ['PG-13', '12A']
SET m.filmingLocationLat = [36.4071, 49.3988, -33.9249]
SET m.filmingLocationLong = [-116.9703, 8.5685, 18.4241]
SET m.boxOfficeNA = 188020017
SET m.boxOfficeEurope = 228700000
SET m.boxOfficeAsia = 124300000
SET m.boxOfficeOther = 160779983;

// Create a second contemporary film
CREATE (Arrival:Movie:GeneratedByClaudeAI {
    title: 'Arrival',
    released: 2016,
    tagline: 'Why are they here?',
    budget: 47000000,
    revenue: 203400000,
    runtime_minutes: 116,
    rating_avg: 7.9,
    releaseDate: date('2016-11-11'),
    digitalRelease: datetime('2017-02-14T00:00:00Z'),
    isOscarWinner: false
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Arrival'})
SET m.ratings = [7.8, 8.1, 7.6, 8.0]
SET m.genres = ['sci-fi', 'drama', 'mystery']
SET m.certifications = ['PG-13', '12A']
SET m.filmingLocationLat = [45.5017, 50.1109]
SET m.filmingLocationLong = [-73.5673, 8.6821]
SET m.boxOfficeNA = 100546139
SET m.boxOfficeEurope = 50400000
SET m.boxOfficeAsia = 36800000
SET m.boxOfficeOther = 15653861;

// Create another actress with temporal data
CREATE (AmyA:Person:GeneratedByClaudeAI {
    name: 'Amy Adams',
    born: 1974,
    birthdate: date('1974-08-20'),
    nationality: 'American',
    oscarNominations: 6,
    oscarWins: 0,
    isActive: true,
    firstFilm: datetime('1999-04-23T00:00:00Z'),
    typicalDay: localtime('06:30:00'),
    heightInMeters: 1.63,
    netWorth: 60000000,
    methodActingScore: 8.7
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Amy Adams'})
SET p.languages = ['English', 'Italian']
SET p.filmography_titles = ['Arrival', 'American Hustle', 'Enchanted']
SET p.filmography_years = [2016, 2013, 2007]
SET p.filmography_roles = ['Dr. Louise Banks', 'Sydney Prosser', 'Giselle'];

// Create another director with mixed data types
CREATE (DenisV:Person:GeneratedByClaudeAI {
    name: 'Denis Villeneuve',
    born: 1967,
    birthdate: date('1967-10-03'),
    nationality: 'Canadian',
    oscarNominations: 4,
    activeYears: duration({years: 30}),
    isActive: true,
    residenceLat: 45.5017,
    residenceLong: -73.5673,
    lastDirected: datetime('2023-11-03T00:00:00Z'),
    typicalFilmLengthHrs: 2.4
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Denis Villeneuve'})
SET p.preferredAspectRatios = ['2.39:1', '1.85:1']
SET p.collaborators = ['Roger Deakins', 'Joe Walker', 'Jóhann Jóhannsson'];

// Create another actor with null values and mixed types
CREATE (MatthewM:Person:GeneratedByClaudeAI {
    name: 'Matthew McConaughey',
    born: 1969,
    birthdate: date('1969-11-04'),
    spouseName: 'Camila Alves',
    marriageDate: date('2012-06-09'),
    oscarWins: 1,
    oscarWinDate: date('2014-03-02'),
    height: 183,
    weight: 84,
    upcomingProjects: null,
    isCurrentlyFilming: true,
    typicalRolePreparationMonths: 3.5
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Matthew McConaughey'})
SET p.activityDays = ['Monday', 'Tuesday', 'Thursday', 'Friday']
SET p.activityTypes = ['Script reading', 'Physical training', 'Character research']
SET p.activityDurations = [3, 2, 4]
SET p.filmCountDrama = 14
SET p.filmCountThriller = 6
SET p.filmCountComedy = 8
SET p.filmCountSciFi = 3;

// Create a new actress
CREATE (JessicaC:Person:GeneratedByClaudeAI {
    name: 'Jessica Chastain',
    born: 1977,
    birthdate: date('1977-03-24'),
    nationality: 'American',
    oscarWins: 1,
    oscarNominations: 3,
    isActive: true,
    firstFilm: datetime('2008-09-07T00:00:00Z'),
    oscarCeremony: localdatetime('2022-03-27T20:15:00'),
    heightInMeters: 1.63,
    netWorth: 50000000
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Jessica Chastain'})
SET p.languages = ['English', 'French']
SET p.filmography_titles = ['The Help', 'Zero Dark Thirty', 'Interstellar']
SET p.filmography_years = [2011, 2012, 2014]
SET p.filmography_roles = ['Celia Foote', 'Maya', 'Murphy Cooper'];

// Create a new production company
CREATE (A24:Studio:GeneratedByClaudeAI {
    name: 'A24',
    founded: date('2012-08-20'),
    headquartersLat: 40.7405,
    headquartersLong: -74.0022,
    yearlyRevenue2020: 165000000,
    yearlyRevenue2021: 225000000,
    yearlyRevenue2022: 275000000,
    digitalStreamingDate: datetime('2022-06-30T00:00:00Z'),
    isPublic: false,
    marketShare: 0.035
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'A24'})
SET s.subsidiaries = ['A24 Films', 'A24 Television']
SET s.distributionMarkets = ['North America', 'Europe', 'Asia', 'Australia']
SET s.studioLotsLat = [40.7405]
SET s.studioLotsLong = [-74.0022];

// Create a filming event for Interstellar
CREATE (InterstellarFilming:Production:GeneratedByClaudeAI {
    name: 'Interstellar Principal Photography',
    startDate: date('2013-08-13'),
    endDate: date('2013-12-14'),
    durationMonths: 4,
    durationDays: 1,
    startTime: localtime('06:45:00'),
    isCompleted: true,
    budgetPersonnel: 45000000,
    budgetEquipment: 18000000,
    budgetLocations: 30000000,
    budgetVFX: 55000000,
    budgetOther: 17000000,
    weatherGood: 70,
    weatherAcceptable: 25,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Interstellar Principal Photography'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['04:30:00', '06:30:00', '07:00:00', '19:00:00']
SET p.scheduleDurations = [2, 0.5, 12, 1.5];

// Create a filming event for Arrival
CREATE (ArrivalFilming:Production:GeneratedByClaudeAI {
    name: 'Arrival Principal Photography',
    startDate: date('2015-06-07'),
    endDate: date('2015-08-28'),
    durationMonths: 2,
    durationDays: 21,
    startTime: localtime('07:00:00'),
    isCompleted: true,
    budgetPersonnel: 12000000,
    budgetEquipment: 5000000,
    budgetLocations: 8000000,
    budgetVFX: 16000000,
    budgetOther: 6000000,
    weatherGood: 65,
    weatherAcceptable: 30,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Arrival Principal Photography'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['05:00:00', '07:00:00', '07:30:00', '18:30:00']
SET p.scheduleDurations = [2, 0.5, 11, 1];

// Add a review for Interstellar
CREATE (InterstellarReview:Review:GeneratedByClaudeAI {
    title: 'A Cosmic Emotional Journey',
    stars: 4.7,
    date: date('2014-11-10'),
    time: time('16:42:18+01:00'),
    isVerified: true,
    aspectDirection: 5.0,
    aspectActing: 4.8,
    aspectVisuals: 5.0,
    aspectMusic: 5.0,
    aspectPlot: 4.5,
    reviewText: 'Christopher Nolan\'s Interstellar is a breathtaking cosmic journey that balances complex scientific concepts with profound emotional depth. The film\'s visual spectacle and Hans Zimmer\'s score create an immersive experience.',
    upvotes: 4267
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'A Cosmic Emotional Journey'})
SET r.commentTimestamps = [datetime('2014-11-10T18:22:43Z'), datetime('2014-11-11T09:15:12Z'), datetime('2014-11-12T14:32:01Z')]
SET r.keywords = ['space', 'relativity', 'time-dilation', 'love']
SET r.readerLocationsLat = [40.7128, 51.5074, 34.0522]
SET r.readerLocationsLong = [-74.0060, -0.1278, -118.2437];

// Add a review for Arrival
CREATE (ArrivalReview:Review:GeneratedByClaudeAI {
    title: 'A Linguistic Masterpiece',
    stars: 4.6,
    date: date('2016-11-14'),
    time: time('20:15:36+01:00'),
    isVerified: true,
    aspectDirection: 4.9,
    aspectActing: 4.8,
    aspectVisuals: 4.7,
    aspectMusic: 4.6,
    aspectPlot: 4.9,
    reviewText: 'Denis Villeneuve\'s Arrival is a thought-provoking exploration of language and time. Amy Adams delivers a nuanced performance as a linguist tasked with communicating with extraterrestrial visitors. The non-linear storytelling creates a powerful emotional revelation.',
    upvotes: 3842
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'A Linguistic Masterpiece'})
SET r.commentTimestamps = [datetime('2016-11-14T22:12:43Z'), datetime('2016-11-15T08:45:22Z'), datetime('2016-11-16T19:38:11Z')]
SET r.keywords = ['language', 'communication', 'aliens', 'time']
SET r.readerLocationsLat = [37.7749, 48.8566, 35.6762]
SET r.readerLocationsLong = [-122.4194, 2.3522, 139.6503];

// Add BAFTA Award ceremony
CREATE (BAFTA:Ceremony:GeneratedByClaudeAI {
    name: 'BAFTA Film Awards',
    nickname: 'BAFTAs',
    established: date('1947-05-29'),
    ceremonyTime: localtime('19:00:00'),
    typicalDurationHrs: 3.0,
    isPrestigious: true,
    locationLat: 51.5101,
    locationLong: -0.1305,
    locationHeight: 15,
    nextCeremony: datetime('2026-02-08T19:00:00Z')
})
WITH 1 as dummy
MATCH (c:Ceremony:GeneratedByClaudeAI {name: 'BAFTA Film Awards'})
SET c.categories = ['Best Film', 'Best Director', 'Best Actor', 'Best Actress']
SET c.viewership2020 = 3200000
SET c.viewership2021 = 2800000
SET c.viewership2022 = 3100000
SET c.viewership2023 = 3400000;

// Create a new film festival
CREATE (Cannes:Ceremony:GeneratedByClaudeAI {
    name: 'Cannes Film Festival',
    nickname: 'Festival de Cannes',
    established: date('1946-09-20'),
    ceremonyTime: localtime('19:30:00'),
    typicalDurationDays: 12,
    isPrestigious: true,
    locationLat: 43.5500,
    locationLong: 7.0167,
    locationHeight: 12,
    nextCeremony: datetime('2026-05-12T19:30:00+02:00')
})
WITH 1 as dummy
MATCH (c:Ceremony:GeneratedByClaudeAI {name: 'Cannes Film Festival'})
SET c.categories = ['Palme d\'Or', 'Grand Prix', 'Jury Prize', 'Best Director']
SET c.attendance2019 = 40000
SET c.attendance2021 = 28000
SET c.attendance2022 = 35000
SET c.attendance2023 = 38000;

// Create relationships between nodes with various data types
MATCH 
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Interstellar'})
CREATE (c)-[:DIRECTED {
    year: 2014,
    daysOnSet: 124,
    satisfaction: 4.8,
    awardNominations: 5,
    completionDate: date('2014-09-22'),
    premiereEvent: datetime('2014-10-26T18:30:00Z'),
    durationMonths: 4,
    isFirstCollaboration: false
}]->(i);

// Actor to Movie relationships for Interstellar
MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Matthew McConaughey'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Interstellar'})
CREATE (m)-[:ACTED_IN {
    roles: ['Joseph Cooper'],
    salary: 15000000,
    screenTimeMinutes: 135,
    startDate: date('2013-08-13'),
    endDate: date('2013-12-14'),
    scheduleConflicts: false,
    criticScore: 92,
    audienceScore: 94,
    awardNominations: 4
}]->(i);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Jessica Chastain'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Interstellar'})
CREATE (j)-[:ACTED_IN {
    roles: ['Murphy Cooper'],
    salary: 3500000,
    screenTimeMinutes: 45,
    startDate: date('2013-09-10'),
    endDate: date('2013-11-15'),
    scheduleConflicts: true,
    performanceRating: 4.7
}]->(i);

// Actor to Movie relationships for Arrival
MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Amy Adams'}),
  (r:Movie:GeneratedByClaudeAI {title: 'Arrival'})
CREATE (a)-[:ACTED_IN {
    roles: ['Dr. Louise Banks'],
    salary: 5000000,
    screenTimeMinutes: 104,
    startDate: date('2015-06-07'),
    endDate: date('2015-08-28'),
    scheduleConflicts: false,
    criticScore: 94,
    audienceScore: 89,
    awardNominations: 5
}]->(r);

// Director to Movie relationships for Arrival
MATCH
  (d:Person:GeneratedByClaudeAI {name: 'Denis Villeneuve'}),
  (r:Movie:GeneratedByClaudeAI {title: 'Arrival'})
CREATE (d)-[:DIRECTED {
    year: 2016,
    daysOnSet: 81,
    satisfaction: 4.9,
    awardNominations: 8,
    completionDate: date('2016-08-15'),
    premiereEvent: datetime('2016-09-01T20:15:00+02:00'),
    durationMonths: 3,
    isFirstCollaboration: true
}]->(r);

// Studio relationships
MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Interstellar'})
CREATE (w)-[:PRODUCED {
    investment: 165000000,
    return: 701800000,
    roi: 4.25,
    contractSigned: date('2012-08-15'),
    studioShare: 0.55,
    directorShare: 0.2,
    producerShare: 0.15,
    topCastShare: 0.1,
    marketingBudget: 80000000,
    isProfitable: true,
    marketingStart: datetime('2014-05-15T00:00:00Z')
}]->(i);

MATCH
  (a:Studio:GeneratedByClaudeAI {name: 'A24'}),
  (r:Movie:GeneratedByClaudeAI {title: 'Arrival'})
CREATE (a)-[:PRODUCED {
    investment: 47000000,
    return: 203400000,
    roi: 4.33,
    contractSigned: date('2014-11-10'),
    studioShare: 0.6,
    directorShare: 0.15,
    producerShare: 0.15,
    topCastShare: 0.1,
    marketingBudget: 30000000,
    isProfitable: true,
    marketingStart: datetime('2016-04-12T00:00:00Z')
}]->(r);

// Studio to filming relationship
MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (p:Production:GeneratedByClaudeAI {name: 'Interstellar Principal Photography'})
CREATE (w)-[:FINANCED {
    contractDate: date('2012-08-15'),
    amount: 165000000,
    isFullyPaid: true,
    transferTime1: datetime('2013-01-10T00:00:00Z'),
    transferTime2: datetime('2013-04-15T00:00:00Z'),
    transferTime3: datetime('2013-07-01T00:00:00Z'),
    paymentDate1: date('2013-01-10'),
    paymentAmount1: 50000000,
    paymentDate2: date('2013-04-15'),
    paymentAmount2: 65000000,
    paymentDate3: date('2013-07-01'),
    paymentAmount3: 50000000
}]->(p);

MATCH
  (a:Studio:GeneratedByClaudeAI {name: 'A24'}),
  (p:Production:GeneratedByClaudeAI {name: 'Arrival Principal Photography'})
CREATE (a)-[:FINANCED {
    contractDate: date('2014-11-10'),
    amount: 47000000,
    isFullyPaid: true,
    transferTime1: datetime('2015-01-15T00:00:00Z'),
    transferTime2: datetime('2015-03-30T00:00:00Z'),
    paymentDate1: date('2015-01-15'),
    paymentAmount1: 22000000,
    paymentDate2: date('2015-03-30'),
    paymentAmount2: 25000000
}]->(p);

// Filming to movie relationship
MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Interstellar Principal Photography'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Interstellar'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 4,
    durationDays: 1,
    locationCount: 8,
    dailyAverageCost: 520000,
    scheduleAdherence: 0.92,
    weatherDelaysDays: 8,
    originalScheduledEnd: date('2013-12-05')
}]->(i);

MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Arrival Principal Photography'}),
  (r:Movie:GeneratedByClaudeAI {title: 'Arrival'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 2,
    durationDays: 21,
    locationCount: 5,
    dailyAverageCost: 290000,
    scheduleAdherence: 0.98,
    weatherDelaysDays: 2,
    originalScheduledEnd: date('2015-08-25')
}]->(r);

// Review relationships
MATCH
  (j:Person {name: 'James Thompson'}), // Original person from the graph
  (r:Review:GeneratedByClaudeAI {title: 'A Cosmic Emotional Journey'})
CREATE (j)-[:WROTE {
    date: date('2014-11-10'),
    timeSpentMinutes: 50,
    wordCount: 612,
    isVerified: true,
    submissionTime: time('16:42:18+01:00')
}]->(r);

MATCH
  (a:Person {name: 'Angela Scope'}), // Original person from the graph
  (r:Review:GeneratedByClaudeAI {title: 'A Linguistic Masterpiece'})
CREATE (a)-[:WROTE {
    date: date('2016-11-14'),
    timeSpentMinutes: 45,
    wordCount: 568,
    isVerified: true,
    submissionTime: time('20:15:36+01:00')
}]->(r);

MATCH
  (r:Review:GeneratedByClaudeAI {title: 'A Cosmic Emotional Journey'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Interstellar'})
CREATE (r)-[:FOR_MOVIE {
    isPublished: true,
    views: 152487,
    shares: 6842,
    comments: 2156,
    featuredDurationDays: 21,
    publicationDateTime: datetime('2014-11-10T17:00:00+01:00')
}]->(i);

MATCH
  (r:Review:GeneratedByClaudeAI {title: 'A Linguistic Masterpiece'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Arrival'})
CREATE (r)-[:FOR_MOVIE {
    isPublished: true,
    views: 98245,
    shares: 3621,
    comments: 1583,
    featuredDurationDays: 14,
    publicationDateTime: datetime('2016-11-14T21:00:00+01:00')
}]->(i);

// Award relationships
MATCH
  (i:Movie:GeneratedByClaudeAI {title: 'Interstellar'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (i)-[:NOMINATED_FOR {
    category: 'Best Original Score',
    year: 2015,
    ceremony: 87,
    isWinner: false,
    ceremonyDate: date('2015-02-22'),
    announcementTime: localtime('21:15:00'),
    votesFor: 2856,
    votesAgainst: 3012
}]->(a);

MATCH
  (i:Movie:GeneratedByClaudeAI {title: 'Interstellar'}),
  (b:Ceremony:GeneratedByClaudeAI {name: 'BAFTA Film Awards'})
CREATE (i)-[:NOMINATED_FOR {
    category: 'Best Original Music',
    year: 2015,
    ceremony: 68,
    isWinner: true,
    ceremonyDate: date('2015-02-08'),
    announcementTime: localtime('20:45:00'),
    votesFor: 1523,
    votesAgainst: 1287
}]->(b);

MATCH
  (r:Movie:GeneratedByClaudeAI {title: 'Arrival'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (r)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 2017,
    ceremony: 89,
    isWinner: false,
    ceremonyDate: date('2017-02-26'),
    announcementTime: localtime('21:45:00'),
    votesFor: 2785,
    votesAgainst: 3142
}]->(a);

MATCH
  (d:Person:GeneratedByClaudeAI {name: 'Denis Villeneuve'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (d)-[:NOMINATED_FOR {
    category: 'Best Director',
    year: 2017,
    ceremony: 89,
    isWinner: false,
    ceremonyDate: date('2017-02-26'),
    announcementTime: localtime('21:00:00'),
    votesFor: 2456,
    votesAgainst: 3471
}]->(a);

// Professional relationships between people
MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (d:Person:GeneratedByClaudeAI {name: 'Denis Villeneuve'})
CREATE (c)-[:KNOWS {
    since: date('2010-09-12'),
    projects: 0,
    relationship: 'Professional Acquaintance',
    lastContact: datetime('2023-11-15T11:30:00Z'),
    nextMeeting: datetime('2025-06-20T14:00:00Z')
}]->(d);

MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Matthew McConaughey'}),
  (j:Person:GeneratedByClaudeAI {name: 'Jessica Chastain'})
CREATE (m)-[:WORKED_WITH {
    projects: 1,
    firstProject: 'Interstellar',
    firstYear: 2014,
    chemistry: 4.8,
    interviews: 15,
    jointSceneMinutes: 12,
    relationship: 'Co-stars',
    nextProjectPlanned: date('2026-03-15')
}]->(j);

MATCH
  (l:Person:GeneratedByClaudeAI {name: 'Leonardo DiCaprio'}),
  (m:Person:GeneratedByClaudeAI {name: 'Matthew McConaughey'})
CREATE (l)-[:KNOWS {
    since: date('2006-11-23'),
    relationship: 'Friends',
    lastMeeting: date('2023-12-15'),
    durationYears: 17,
    commonFriends: 8,
    commonProjects: 0
}]->(m);

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Amy Adams'}),
  (j:Person:GeneratedByClaudeAI {name: 'Jessica Chastain'})
CREATE (a)-[:KNOWS {
    since: date('2011-05-07'),
    relationship: 'Friends and Colleagues',
    lastMeeting: date('2024-01-22'),
    durationYears: 13,
    commonAwards: 5,
    commonGenres: ['Drama', 'Sci-Fi']
}]->(j);

// Connection with original graph
MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (t:Person {name: 'Tom Cruise'}) // Original person from the graph
CREATE (c)-[:ADMIRES {
    since: date('1998-07-25'),
    projects: 0,
    relationship: 'Professional Admiration',
    lastContact: null,
    inspirationLevel: 4.7,
    influencedWorks: ['Inception', 'Tenet']
}]->(t);

MATCH
  (d:Person:GeneratedByClaudeAI {name: 'Denis Villeneuve'}),
  (r:Person {name: 'Rob Reiner'}) // Original person from the graph
CREATE (d)-[:INSPIRED_BY {
    since: date('1987-10-15'),
    favouriteFilm: 'Stand By Me',
    impactLevel: 4.8,
    mentionedInInterviews: 12,
    influencedWorks: ['Arrival', 'Prisoners']
}]->(r);

// Create additional property types on existing relationships
MATCH (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'})-[r:DIRECTED]->(i:Movie:GeneratedByClaudeAI {title: 'Interstellar'})
SET r.technicalChallenges = ['IMAX filming', 'Practical effects', 'Rotating sets']
SET r.techChallengeRatings = [4.2, 4.8, 5.0]
SET r.consultants = ['Kip Thorne', 'Christopher Nolan']
SET r.consultationHours = [240, 500]
SET r.scriptChanges = 18
SET r.finalRuntime = duration({hours: 2, minutes: 49})
SET r.originalRuntime = duration({hours: 3, minutes: 15});

// Create additional node types
CREATE (TeslaModel:CarModel:GeneratedByClaudeAI {
    name: 'Tesla Model S',
    introduced: date('2012-06-22'),
    featured: true,
    featuredInMovies: ['Interstellar Behind the Scenes'],
    featuredInYears: [2014],
    productPlacementCost: 0,
    vehicleType: 'Electric Sedan',
    maxSpeed: 322,
    maxSpeedUnit: 'km/h',
    manufactureLocation: 'Fremont, California',
    manufactureLocationLat: 37.4924,
    manufactureLocationLong: -121.9465
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Interstellar'}),
      (c:CarModel:GeneratedByClaudeAI {name: 'Tesla Model S'})
CREATE (c)-[:FEATURED_IN {
    screenTimeSeconds: 45,
    isProminentPlacement: false,
    sceneCount: 2,
    firstAppearance: time('00:32:15'),
    lastAppearance: time('01:45:22'),
    contractDate: date('2013-05-12')
}]->(m);

// Create prop node
CREATE (InceptionTotem:Prop:GeneratedByClaudeAI {
    name: 'Spinning Top',
    movie: 'Inception',
    material: 'Metal',
    weight: 0.12,
    weightUnit: 'kg',
    createdDate: date('2009-05-22'),
    screenTime: duration({minutes: 6, seconds: 45}),
    isIconic: true,
    auctionValue: 15000,
    copiesMade: 5
})
WITH 1 as dummy
MATCH (i:Movie:GeneratedByClaudeAI {title: 'Inception'}),
      (p:Prop:GeneratedByClaudeAI {name: 'Spinning Top'})
CREATE (p)-[:USED_IN {
    scenes: ['Opening', 'Hotel', 'Ending'],
    sceneCount: 3,
    firstAppearance: time('00:04:15'),
    lastAppearance: time('02:28:15'),
    isCloseup: true,
    significance: 'Critical plot device'
}]->(i);

// Create soundtrack node
CREATE (InterstellarSoundtrack:Soundtrack:GeneratedByClaudeAI {
    title: 'Interstellar: Original Motion Picture Soundtrack',
    composer: 'Hans Zimmer',
    released: date('2014-11-18'),
    duration: duration({minutes: 71, seconds: 49}),
    trackCount: 16,
    recordingStudio: 'Air Lyndhurst Hall, London',
    recordingStudioLat: 51.5454,
    recordingStudioLong: -0.1388,
    peakChartPosition: 2,
    salesUnits: 250000,
    streamingCount: 150000000
})
WITH 1 as dummy
MATCH (i:Movie:GeneratedByClaudeAI {title: 'Interstellar'}),
      (s:Soundtrack:GeneratedByClaudeAI {title: 'Interstellar: Original Motion Picture Soundtrack'})
CREATE (s)-[:COMPOSED_FOR {
    contractDate: date('2013-01-15'),
    completion: date('2014-09-15'),
    nominatedAwards: ['Academy Award', 'BAFTA', 'Golden Globe'],
    wonAwards: ['BAFTA'],
    spotifyStreams: 250000000,
    youtubeViews: 45000000
}]->(i);

// Create location node
CREATE (IcelandLocation:FilmingLocation:GeneratedByClaudeAI {
    name: 'Svínafellsjökull',
    country: 'Iceland',
    region: 'Vatnajökull National Park',
    latitude: 64.0080,
    longitude: -16.3832,
    elevation: 120,
    elevationUnit: 'm',
    climate: 'Subarctic',
    permitCost: 85000,
    permitCurrency: 'USD',
    firstUsed: date('2013-09-25'),
    lastUsed: date('2013-10-12')
})
WITH 1 as dummy
MATCH (i:Movie:GeneratedByClaudeAI {title: 'Interstellar'}),
      (l:FilmingLocation:GeneratedByClaudeAI {name: 'Svínafellsjökull'})
CREATE (i)-[:FILMED_AT {
    startDate: date('2013-09-25'),
    endDate: date('2013-10-12'),
    sceneCount: 8,
    totalDays: 18,
    weatherDelayDays: 3,
    crewSize: 132,
    logisticsCost: 450000,
    accommodationCost: 320000,
    characterPresent: ['Cooper', 'Brand']
}]->(l);

// Create a new modern movie with various data types
CREATE (BladeRunner2049:Movie:GeneratedByClaudeAI {
    title: 'Blade Runner 2049',
    released: 2017,
    tagline: 'The key to the future is finally unearthed.',
    budget: 185000000,
    revenue: 259300000,
    runtime_minutes: 164,
    rating_avg: 8.0,
    releaseDate: date('2017-10-06'),
    digitalRelease: datetime('2018-01-16T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Blade Runner 2049'})
SET m.ratings = [8.1, 7.9, 8.2, 7.8]
SET m.genres = ['sci-fi', 'thriller', 'mystery']
SET m.certifications = ['R', '15']
SET m.filmingLocationLat = [31.7683, 36.7783, 34.0522]
SET m.filmingLocationLong = [-106.4460, -119.4179, -118.2437]
SET m.boxOfficeNA = 92054159
SET m.boxOfficeEurope = 106780000
SET m.boxOfficeAsia = 49560000
SET m.boxOfficeOther = 10905841;

// Create a classic film
CREATE (TheSilenceOfTheLambs:Movie:GeneratedByClaudeAI {
    title: 'The Silence of the Lambs',
    released: 1991,
    tagline: 'To enter the mind of a killer she must challenge the mind of a madman.',
    budget: 19000000,
    revenue: 272700000,
    runtime_minutes: 118,
    rating_avg: 8.6,
    releaseDate: date('1991-02-14'),
    digitalRelease: datetime('1997-10-25T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'})
SET m.ratings = [8.7, 8.5, 8.6, 8.6]
SET m.genres = ['crime', 'drama', 'thriller', 'horror']
SET m.certifications = ['R', '18']
SET m.filmingLocationLat = [40.4406, 40.7128, 38.9072]
SET m.filmingLocationLong = [-79.9959, -74.0060, -77.0369]
SET m.boxOfficeNA = 130726716
SET m.boxOfficeEurope = 75800000
SET m.boxOfficeAsia = 42500000
SET m.boxOfficeOther = 23673284;

// Create a recent animated film
CREATE (SpiderVerse:Movie:GeneratedByClaudeAI {
    title: 'Spider-Man: Into the Spider-Verse',
    released: 2018,
    tagline: 'More Than One Wears the Mask',
    budget: 90000000,
    revenue: 375500000,
    runtime_minutes: 117,
    rating_avg: 8.4,
    releaseDate: date('2018-12-14'),
    digitalRelease: datetime('2019-03-19T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Spider-Man: Into the Spider-Verse'})
SET m.ratings = [8.4, 8.5, 8.3, 8.4]
SET m.genres = ['animation', 'action', 'adventure']
SET m.certifications = ['PG', 'U']
SET m.animationStudioLat = [34.1593, 34.0901]
SET m.animationStudioLong = [-118.3263, -118.3676]
SET m.boxOfficeNA = 190241310
SET m.boxOfficeEurope = 85400000
SET m.boxOfficeAsia = 77900000
SET m.boxOfficeOther = 21958690;

// Create additional actors and directors
CREATE (JoannaL:Person:GeneratedByClaudeAI {
    name: 'Jodie Foster',
    born: 1962,
    birthdate: date('1962-11-19'),
    nationality: 'American',
    oscarWins: 2,
    oscarNominations: 4,
    isActive: true,
    firstFilm: datetime('1972-06-09T00:00:00Z'),
    directorDebut: date('1991-10-20'),
    heightInMeters: 1.60,
    netWorth: 100000000,
    methodActingScore: 9.3
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Jodie Foster'})
SET p.languages = ['English', 'French', 'Italian', 'Spanish']
SET p.filmography_titles = ['The Silence of the Lambs', 'Taxi Driver', 'Contact']
SET p.filmography_years = [1991, 1976, 1997]
SET p.filmography_roles = ['Clarice Starling', 'Iris Steensma', 'Dr. Eleanor Arroway'];

CREATE (AnthonyH:Person:GeneratedByClaudeAI {
    name: 'Anthony Hopkins',
    born: 1937,
    birthdate: date('1937-12-31'),
    nationality: 'British',
    oscarWins: 2,
    oscarNominations: 6,
    isActive: true,
    firstFilm: datetime('1968-11-15T00:00:00Z'),
    knighted: date('1993-02-23'),
    heightInMeters: 1.74,
    netWorth: 160000000,
    classicalTraining: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Anthony Hopkins'})
SET p.languages = ['English', 'Welsh']
SET p.filmography_titles = ['The Silence of the Lambs', 'The Remains of the Day', 'The Father']
SET p.filmography_years = [1991, 1993, 2020]
SET p.filmography_roles = ['Hannibal Lecter', 'James Stevens', 'Anthony'];

CREATE (JonathanD:Person:GeneratedByClaudeAI {
    name: 'Jonathan Demme',
    born: 1944,
    birthdate: date('1944-02-22'),
    deathdate: date('2017-04-26'),
    nationality: 'American',
    oscarWins: 1,
    oscarNominations: 1,
    isActive: false,
    firstFilm: datetime('1974-07-31T00:00:00Z'),
    lastFilm: datetime('2015-10-10T00:00:00Z'),
    careerLength: duration({years: 41, months: 2}),
    documentaryCount: 8
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Jonathan Demme'})
SET p.genres = ['Drama', 'Thriller', 'Documentary', 'Comedy']
SET p.collaborators = ['Tak Fujimoto', 'Jodie Foster', 'Tom Hanks']
SET p.filmography_titles = ['The Silence of the Lambs', 'Philadelphia', 'Stop Making Sense']
SET p.filmography_years = [1991, 1993, 1984];

CREATE (RyanG:Person:GeneratedByClaudeAI {
    name: 'Ryan Gosling',
    born: 1980,
    birthdate: date('1980-11-12'),
    nationality: 'Canadian',
    oscarNominations: 2,
    isActive: true,
    firstFilm: datetime('1997-01-12T00:00:00Z'),
    musicianSince: date('2009-09-02'),
    heightInMeters: 1.84,
    netWorth: 70000000,
    methodActingScore: 8.8
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Ryan Gosling'})
SET p.languages = ['English', 'French']
SET p.filmography_titles = ['Blade Runner 2049', 'La La Land', 'Drive']
SET p.filmography_years = [2017, 2016, 2011]
SET p.filmography_roles = ['Officer K', 'Sebastian Wilder', 'Driver']
SET p.musicalInstruments = ['Piano', 'Guitar', 'Vocals'];

CREATE (HaileeS:Person:GeneratedByClaudeAI {
    name: 'Hailee Steinfeld',
    born: 1996,
    birthdate: date('1996-12-11'),
    nationality: 'American',
    oscarNominations: 1,
    isActive: true,
    firstFilm: datetime('2010-12-22T00:00:00Z'),
    musicCareerStart: date('2015-08-07'),
    heightInMeters: 1.73,
    netWorth: 22000000,
    voiceActingScore: 9.2
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Hailee Steinfeld'})
SET p.languages = ['English', 'Spanish']
SET p.filmography_titles = ['Spider-Man: Into the Spider-Verse', 'True Grit', 'Bumblebee']
SET p.filmography_years = [2018, 2010, 2018]
SET p.filmography_roles = ['Gwen Stacy (Voice)', 'Mattie Ross', 'Charlie Watson']
SET p.musicGenres = ['Pop', 'Dance', 'Electronic'];

// Create new production companies
CREATE (SonyPictures:Studio:GeneratedByClaudeAI {
    name: 'Sony Pictures',
    founded: date('1987-12-21'),
    headquartersLat: 34.0211,
    headquartersLong: -118.3787,
    yearlyRevenue2020: 7870000000,
    yearlyRevenue2021: 9240000000,
    yearlyRevenue2022: 8450000000,
    digitalStreamingDate: datetime('2021-04-08T00:00:00Z'),
    isPublic: true,
    marketShare: 0.095
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Sony Pictures'})
SET s.subsidiaries = ['Columbia Pictures', 'TriStar Pictures', 'Sony Pictures Animation']
SET s.distributionMarkets = ['North America', 'Europe', 'Asia', 'Latin America', 'Africa', 'Oceania']
SET s.studioLotsLat = [34.0211, 35.6762]
SET s.studioLotsLong = [-118.3787, 139.6503];

CREATE (OrionPictures:Studio:GeneratedByClaudeAI {
    name: 'Orion Pictures',
    founded: date('1978-01-12'),
    relaunch: date('2020-08-08'),
    headquartersLat: 34.0522,
    headquartersLong: -118.2437,
    yearlyRevenue1991: 480000000,
    yearlyRevenue1992: 510000000,
    bankruptcyDate: date('1991-12-11'),
    acquisitionDate: date('1998-07-10'),
    isActive: true,
    peakMarketShare: 0.065
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Orion Pictures'})
SET s.subsidiaries = ['Orion Classics']
SET s.distributionMarkets = ['North America', 'Europe', 'Asia']
SET s.notableFilms = ['The Silence of the Lambs', 'Dances with Wolves', 'RoboCop']
SET s.notableYears = [1991, 1990, 1987];

// Create filming events
CREATE (BladeRunnerFilming:Production:GeneratedByClaudeAI {
    name: 'Blade Runner 2049 Principal Photography',
    startDate: date('2016-07-12'),
    endDate: date('2016-11-25'),
    durationMonths: 4,
    durationDays: 13,
    startTime: localtime('05:30:00'),
    isCompleted: true,
    budgetPersonnel: 55000000,
    budgetEquipment: 22000000,
    budgetLocations: 28000000,
    budgetVFX: 65000000,
    budgetOther: 15000000,
    weatherGood: 80,
    weatherAcceptable: 15,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Blade Runner 2049 Principal Photography'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['03:30:00', '05:30:00', '06:00:00', '19:00:00']
SET p.scheduleDurations = [2, 0.5, 13, 1.5];

CREATE (SilenceFilming:Production:GeneratedByClaudeAI {
    name: 'The Silence of the Lambs Principal Photography',
    startDate: date('1989-11-15'),
    endDate: date('1990-03-01'),
    durationMonths: 3,
    durationDays: 16,
    startTime: localtime('07:00:00'),
    isCompleted: true,
    budgetPersonnel: 6500000,
    budgetEquipment: 3500000,
    budgetLocations: 5000000,
    budgetVFX: 1000000,
    budgetOther: 3000000,
    weatherGood: 65,
    weatherAcceptable: 25,
    weatherPoor: 10
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'The Silence of the Lambs Principal Photography'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['05:00:00', '07:00:00', '07:30:00', '18:30:00']
SET p.scheduleDurations = [2, 0.5, 11, 1];

CREATE (SpiderVerseProduction:Production:GeneratedByClaudeAI {
    name: 'Spider-Verse Animation Production',
    startDate: date('2016-06-15'),
    endDate: date('2018-10-01'),
    durationMonths: 28,
    durationDays: 16,
    isCompleted: true,
    budgetPersonnel: 40000000,
    budgetTechnology: 15000000,
    budgetVoiceActing: 8000000,
    budgetRendering: 20000000,
    budgetOther: 7000000,
    animatorsCount: 177,
    renderFarmServers: 35000,
    renderingHours: 55800
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Spider-Verse Animation Production'})
SET p.productionPhases = ['Story', 'Design', 'Animation', 'Lighting', 'Rendering', 'Compositing']
SET p.phaseStartDates = ['2016-06-15', '2016-09-22', '2017-03-15', '2018-01-10', '2018-06-12', '2018-08-05']
SET p.phaseDurationsMonths = [3.25, 5.75, 10, 5, 2, 2];

// Add reviews
CREATE (BladeRunnerReview:Review:GeneratedByClaudeAI {
    title: 'A Worthy Successor to a Classic',
    stars: 4.5,
    date: date('2017-10-10'),
    time: time('18:23:45+01:00'),
    isVerified: true,
    aspectDirection: 5.0,
    aspectActing: 4.7,
    aspectVisuals: 5.0,
    aspectMusic: 4.8,
    aspectPlot: 4.3,
    reviewText: 'Denis Villeneuve\'s Blade Runner 2049 is a mesmerizing sequel that honors Ridley Scott\'s original masterpiece while expanding its universe in breathtaking ways. The cinematography by Roger Deakins is nothing short of revolutionary.',
    upvotes: 5291
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'A Worthy Successor to a Classic'})
SET r.commentTimestamps = [datetime('2017-10-10T20:12:33Z'), datetime('2017-10-11T08:45:22Z'), datetime('2017-10-12T14:36:51Z')]
SET r.keywords = ['sequel', 'dystopian', 'visually-stunning', 'philosophical']
SET r.readerLocationsLat = [40.7128, 51.5074, 48.8566]
SET r.readerLocationsLong = [-74.0060, -0.1278, 2.3522];

CREATE (SilenceReview:Review:GeneratedByClaudeAI {
    title: 'Masterful Psychological Horror',
    stars: 5.0,
    date: date('1991-02-20'),
    time: time('14:15:30-05:00'),
    isVerified: true,
    aspectDirection: 5.0,
    aspectActing: 5.0,
    aspectVisuals: 4.7,
    aspectMusic: 4.6,
    aspectPlot: 4.9,
    reviewText: 'The Silence of the Lambs is a perfect thriller that features career-defining performances from both Jodie Foster and Anthony Hopkins. Jonathan Demme\'s direction creates an atmosphere of dread and intensity that never lets up.',
    upvotes: 12853
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'Masterful Psychological Horror'})
SET r.commentTimestamps = [datetime('1991-02-20T16:22:13-05:00'), datetime('1991-02-21T09:45:32-05:00'), datetime('1991-02-22T20:12:41-05:00')]
SET r.keywords = ['thriller', 'psychological', 'oscar-winning', 'iconic']
SET r.readerLocationsLat = [40.7128, 34.0522, 41.8781]
SET r.readerLocationsLong = [-74.0060, -118.2437, -87.6298];

CREATE (SpiderVerseReview:Review:GeneratedByClaudeAI {
    title: 'Animation Revolution',
    stars: 4.9,
    date: date('2018-12-18'),
    time: time('21:34:18-08:00'),
    isVerified: true,
    aspectDirection: 5.0,
    aspectAnimation: 5.0,
    aspectVoiceActing: 4.8,
    aspectMusic: 4.7,
    aspectPlot: 4.8,
    reviewText: 'Spider-Man: Into the Spider-Verse is a groundbreaking achievement in animation that pushes the medium to new heights. The film combines various animation styles to create a comic book come to life, with heart and humor to match its visual splendor.',
    upvotes: 9426
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'Animation Revolution'})
SET r.commentTimestamps = [datetime('2018-12-18T22:15:43-08:00'), datetime('2018-12-19T08:22:51-08:00'), datetime('2018-12-20T15:37:22-08:00')]
SET r.keywords = ['animation', 'comic-book', 'multiverse', 'innovative']
SET r.readerLocationsLat = [37.7749, 40.7128, 35.6762]
SET r.readerLocationsLong = [-122.4194, -74.0060, 139.6503];

// Add Golden Globes Award ceremony
CREATE (GoldenGlobes:Ceremony:GeneratedByClaudeAI {
    name: 'Golden Globe Awards',
    nickname: 'Golden Globes',
    established: date('1944-01-20'),
    ceremonyTime: localtime('20:00:00'),
    typicalDurationHrs: 3.0,
    isPrestigious: true,
    locationLat: 34.0736,
    locationLong: -118.4004,
    locationHeight: 82,
    nextCeremony: datetime('2026-01-11T20:00:00-08:00')
})
WITH 1 as dummy
MATCH (c:Ceremony:GeneratedByClaudeAI {name: 'Golden Globe Awards'})
SET c.categories = ['Best Motion Picture - Drama', 'Best Motion Picture - Musical or Comedy', 'Best Director', 'Best Actor - Drama', 'Best Actress - Drama']
SET c.viewership2020 = 18300000
SET c.viewership2021 = 6900000
SET c.viewership2022 = 6300000
SET c.viewership2023 = 9250000;

// Create Annie Awards for animation
CREATE (AnnieAwards:Ceremony:GeneratedByClaudeAI {
    name: 'Annie Awards',
    nickname: 'Annies',
    established: date('1972-11-15'),
    ceremonyTime: localtime('19:00:00'),
    typicalDurationHrs: 2.5,
    isPrestigious: true,
    locationLat: 34.0194,
    locationLong: -118.4912,
    locationHeight: 30,
    nextCeremony: datetime('2026-01-31T19:00:00-08:00')
})
WITH 1 as dummy
MATCH (c:Ceremony:GeneratedByClaudeAI {name: 'Annie Awards'})
SET c.categories = ['Best Animated Feature', 'Best Animated TV/Broadcast Production', 'Best Character Animation', 'Best Direction']
SET c.attendance2019 = 900
SET c.attendance2020 = 950
SET c.attendance2021 = 0
SET c.attendance2022 = 800
SET c.attendance2023 = 950;

// Create relationships between nodes with various data types
MATCH 
  (d:Person:GeneratedByClaudeAI {name: 'Denis Villeneuve'}),
  (b:Movie:GeneratedByClaudeAI {title: 'Blade Runner 2049'})
CREATE (d)-[:DIRECTED {
    year: 2017,
    daysOnSet: 136,
    satisfaction: 4.9,
    awardNominations: 7,
    completionDate: date('2017-07-15'),
    premiereEvent: datetime('2017-10-03T19:30:00+01:00'),
    durationMonths: 4,
    isFirstCollaboration: false
}]->(b);

MATCH 
  (j:Person:GeneratedByClaudeAI {name: 'Jonathan Demme'}),
  (s:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'})
CREATE (j)-[:DIRECTED {
    year: 1991,
    daysOnSet: 105,
    satisfaction: 4.9,
    awardNominations: 10,
    completionDate: date('1990-11-15'),
    premiereEvent: datetime('1991-01-30T19:00:00-05:00'),
    durationMonths: 5,
    isFirstCollaboration: true
}]->(s);

// Actor to Movie relationships
MATCH
  (r:Person:GeneratedByClaudeAI {name: 'Ryan Gosling'}),
  (b:Movie:GeneratedByClaudeAI {title: 'Blade Runner 2049'})
CREATE (r)-[:ACTED_IN {
    roles: ['Officer K'],
    salary: 10000000,
    screenTimeMinutes: 143,
    startDate: date('2016-07-12'),
    endDate: date('2016-11-25'),
    scheduleConflicts: false,
    criticScore: 94,
    audienceScore: 90,
    awardNominations: 3
}]->(b);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Jodie Foster'}),
  (s:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'})
CREATE (j)-[:ACTED_IN {
    roles: ['Clarice Starling'],
    salary: 1200000,
    screenTimeMinutes: 102,
    startDate: date('1989-11-15'),
    endDate: date('1990-03-01'),
    scheduleConflicts: false,
    criticScore: 97,
    audienceScore: 95,
    awardNominations: 8,
    awardWins: 5
}]->(s);

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Anthony Hopkins'}),
  (s:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'})
CREATE (a)-[:ACTED_IN {
    roles: ['Dr. Hannibal Lecter'],
    salary: 1000000,
    screenTimeMinutes: 16,
    startDate: date('1989-12-10'),
    endDate: date('1990-01-15'),
    scheduleConflicts: false,
    criticScore: 99,
    audienceScore: 97,
    awardNominations: 8,
    awardWins: 6
}]->(s);

MATCH
  (h:Person:GeneratedByClaudeAI {name: 'Hailee Steinfeld'}),
  (s:Movie:GeneratedByClaudeAI {title: 'Spider-Man: Into the Spider-Verse'})
CREATE (h)-[:VOICED_IN {
    roles: ['Gwen Stacy / Spider-Gwen'],
    salary: 750000,
    recordingDays: 14,
    startDate: date('2017-04-15'),
    endDate: date('2018-06-22'),
    recordingSessions: 8,
    linesCount: 425,
    performanceRating: 4.8
}]->(s);

// Studio relationships
MATCH
  (a:Studio:GeneratedByClaudeAI {name: 'A24'}),
  (b:Movie:GeneratedByClaudeAI {title: 'Blade Runner 2049'})
CREATE (a)-[:CO_PRODUCED {
    investment: 45000000,
    return: 63000000,
    roi: 1.4,
    contractSigned: date('2015-06-22'),
    studioShare: 0.15,
    marketingContribution: 12000000,
    isProfitable: true,
    marketingStart: datetime('2017-03-15T00:00:00Z'),
    profitDate: date('2018-02-28')
}]->(b);

MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (b:Movie:GeneratedByClaudeAI {title: 'Blade Runner 2049'})
CREATE (w)-[:PRODUCED {
    investment: 140000000,
    return: 196300000,
    roi: 1.4,
    contractSigned: date('2015-02-10'),
    studioShare: 0.6,
    directorShare: 0.1,
    producerShare: 0.1,
    topCastShare: 0.05,
    marketingBudget: 150000000,
    isProfitable: false,
    marketingStart: datetime('2017-01-15T00:00:00Z')
}]->(b);

MATCH
  (o:Studio:GeneratedByClaudeAI {name: 'Orion Pictures'}),
  (s:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'})
CREATE (o)-[:PRODUCED {
    investment: 19000000,
    return: 272700000,
    roi: 14.35,
    contractSigned: date('1989-06-15'),
    studioShare: 0.65,
    directorShare: 0.08,
    producerShare: 0.07,
    topCastShare: 0.2,
    marketingBudget: 9000000,
    isProfitable: true,
    marketingStart: datetime('1990-11-15T00:00:00Z'),
    breakEvenDate: date('1991-03-22')
}]->(s);

MATCH
  (s:Studio:GeneratedByClaudeAI {name: 'Sony Pictures'}),
  (sv:Movie:GeneratedByClaudeAI {title: 'Spider-Man: Into the Spider-Verse'})
CREATE (s)-[:PRODUCED {
    investment: 90000000,
    return: 375500000,
    roi: 4.17,
    contractSigned: date('2015-09-30'),
    studioShare: 0.7,
    directorShare: 0.08,
    producerShare: 0.12,
    topCastShare: 0.1,
    marketingBudget: 110000000,
    isProfitable: true,
    marketingStart: datetime('2018-05-15T00:00:00Z'),
    breakEvenDate: date('2019-01-18')
}]->(sv);

// Studio to filming relationship
MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (p:Production:GeneratedByClaudeAI {name: 'Blade Runner 2049 Principal Photography'})
CREATE (w)-[:FINANCED {
    contractDate: date('2015-02-10'),
    amount: 140000000,
    isFullyPaid: true,
    transferTime1: datetime('2016-02-15T00:00:00Z'),
    transferTime2: datetime('2016-05-12T00:00:00Z'),
    transferTime3: datetime('2016-06-30T00:00:00Z'),
    paymentDate1: date('2016-02-15'),
    paymentAmount1: 40000000,
    paymentDate2: date('2016-05-12'),
    paymentAmount2: 50000000,
    paymentDate3: date('2016-06-30'),
    paymentAmount3: 50000000
}]->(p);

MATCH
  (o:Studio:GeneratedByClaudeAI {name: 'Orion Pictures'}),
  (p:Production:GeneratedByClaudeAI {name: 'The Silence of the Lambs Principal Photography'})
CREATE (o)-[:FINANCED {
    contractDate: date('1989-06-15'),
    amount: 19000000,
    isFullyPaid: true,
    transferTime1: datetime('1989-08-22T00:00:00Z'),
    transferTime2: datetime('1989-10-30T00:00:00Z'),
    paymentDate1: date('1989-08-22'),
    paymentAmount1: 9000000,
    paymentDate2: date('1989-10-30'),
    paymentAmount2: 10000000
}]->(p);

MATCH
  (s:Studio:GeneratedByClaudeAI {name: 'Sony Pictures'}),
  (p:Production:GeneratedByClaudeAI {name: 'Spider-Verse Animation Production'})
CREATE (s)-[:FINANCED {
    contractDate: date('2015-09-30'),
    amount: 90000000,
    isFullyPaid: true,
    transferTime1: datetime('2016-01-15T00:00:00Z'),
    transferTime2: datetime('2016-12-15T00:00:00Z'),
    transferTime3: datetime('2017-06-30T00:00:00Z'),
    transferTime4: datetime('2018-01-15T00:00:00Z'),
    paymentDate1: date('2016-01-15'),
    paymentAmount1: 20000000,
    paymentDate2: date('2016-12-15'),
    paymentAmount2: 25000000,
    paymentDate3: date('2017-06-30'),
    paymentAmount3: 30000000,
    paymentDate4: date('2018-01-15'),
    paymentAmount4: 15000000
}]->(p);

// Filming to movie relationship
MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Blade Runner 2049 Principal Photography'}),
  (b:Movie:GeneratedByClaudeAI {title: 'Blade Runner 2049'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 4,
    durationDays: 13,
    locationCount: 7,
    dailyAverageCost: 580000,
    scheduleAdherence: 0.94,
    weatherDelaysDays: 6,
    originalScheduledEnd: date('2016-11-15')
}]->(b);

MATCH
  (p:Production:GeneratedByClaudeAI {name: 'The Silence of the Lambs Principal Photography'}),
  (s:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 3,
    durationDays: 16,
    locationCount: 12,
    dailyAverageCost: 150000,
    scheduleAdherence: 0.96,
    weatherDelaysDays: 4,
    originalScheduledEnd: date('1990-02-20')
}]->(s);

MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Spider-Verse Animation Production'}),
  (s:Movie:GeneratedByClaudeAI {title: 'Spider-Man: Into the Spider-Verse'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 28,
    durationDays: 16,
    animationStudios: 3,
    dailyAverageCost: 110000,
    scheduleAdherence: 0.92,
    technologyDelaysDays: 45,
    originalScheduledEnd: date('2018-08-15'),
    animationFrames: 168452,
    renderingHours: 55800
}]->(s);

// Review relationships
MATCH
  (a:Person {name: 'Angela Scope'}), // Original person from the graph
  (r:Review:GeneratedByClaudeAI {title: 'A Worthy Successor to a Classic'})
CREATE (a)-[:WROTE {
    date: date('2017-10-10'),
    timeSpentMinutes: 55,
    wordCount: 645,
    isVerified: true,
    submissionTime: time('18:23:45+01:00')
}]->(r);

MATCH
  (j:Person {name: 'Jessica Thompson'}), // Original person from the graph
  (r:Review:GeneratedByClaudeAI {title: 'Masterful Psychological Horror'})
CREATE (j)-[:WROTE {
    date: date('1991-02-20'),
    timeSpentMinutes: 60,
    wordCount: 712,
    isVerified: true,
    submissionTime: time('14:15:30-05:00'),
    publicationName: 'Film Journal',
    isRetroReview: false
}]->(r);

MATCH
  (p:Person {name: 'Paul Blythe'}), // Original person from the graph
  (r:Review:GeneratedByClaudeAI {title: 'Animation Revolution'})
CREATE (p)-[:WROTE {
    date: date('2018-12-18'),
    timeSpentMinutes: 50,
    wordCount: 685,
    isVerified: true,
    submissionTime: time('21:34:18-08:00')
}]->(r);

MATCH
  (r:Review:GeneratedByClaudeAI {title: 'A Worthy Successor to a Classic'}),
  (b:Movie:GeneratedByClaudeAI {title: 'Blade Runner 2049'})
CREATE (r)-[:FOR_MOVIE {
    isPublished: true,
    views: 183452,
    shares: 7562,
    comments: 2875,
    featuredDurationDays: 28,
    publicationDateTime: datetime('2017-10-10T19:30:00+01:00')
}]->(b);

MATCH
  (r:Review:GeneratedByClaudeAI {title: 'Masterful Psychological Horror'}),
  (s:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'})
CREATE (r)-[:FOR_MOVIE {
    isPublished: true,
    views: 345782,
    shares: 2845,
    comments: 1923,
    featuredDurationDays: 45,
    publicationDateTime: datetime('1991-02-20T15:30:00-05:00'),
    reprintCount: 8,
    digitalArchiveDate: date('1998-05-12')
}]->(s);

MATCH
  (r:Review:GeneratedByClaudeAI {title: 'Animation Revolution'}),
  (s:Movie:GeneratedByClaudeAI {title: 'Spider-Man: Into the Spider-Verse'})
CREATE (r)-[:FOR_MOVIE {
    isPublished: true,
    views: 256893,
    shares: 15478,
    comments: 3562,
    featuredDurationDays: 30,
    publicationDateTime: datetime('2018-12-18T22:15:00-08:00')
}]->(s);

// Award relationships
MATCH
  (b:Movie:GeneratedByClaudeAI {title: 'Blade Runner 2049'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (b)-[:NOMINATED_FOR {
    category: 'Best Cinematography',
    year: 2018,
    ceremony: 90,
    isWinner: true,
    ceremonyDate: date('2018-03-04'),
    announcementTime: localtime('20:15:00'),
    votesFor: 4567,
    votesAgainst: 2123
}]->(a);

MATCH
  (b:Movie:GeneratedByClaudeAI {title: 'Blade Runner 2049'}),
  (g:Ceremony:GeneratedByClaudeAI {name: 'Golden Globe Awards'})
CREATE (b)-[:NOMINATED_FOR {
    category: 'Best Original Score',
    year: 2018,
    ceremony: 75,
    isWinner: false,
    ceremonyDate: date('2018-01-07'),
    announcementTime: localtime('21:30:00'),
    votesFor: 32,
    votesAgainst: 58
}]->(g);

MATCH
  (s:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (s)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 1992,
    ceremony: 64,
    isWinner: true,
    ceremonyDate: date('1992-03-30'),
    announcementTime: localtime('21:45:00'),
    votesFor: 4786,
    votesAgainst: 1234
}]->(a);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Jodie Foster'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (j)-[:NOMINATED_FOR {
    category: 'Best Actress',
    year: 1992,
    ceremony: 64,
    isWinner: true,
    ceremonyDate: date('1992-03-30'),
    announcementTime: localtime('20:25:00'),
    votesFor: 4562,
    votesAgainst: 1458,
    speechDuration: duration({minutes: 2, seconds: 47})
}]->(a);

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Anthony Hopkins'}),
  (c:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (a)-[:NOMINATED_FOR {
    category: 'Best Actor',
    year: 1992,
    ceremony: 64,
    isWinner: true,
    ceremonyDate: date('1992-03-30'),
    announcementTime: localtime('20:55:00'),
    votesFor: 4876,
    votesAgainst: 1144,
    speechDuration: null
}]->(c);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Jonathan Demme'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (j)-[:NOMINATED_FOR {
    category: 'Best Director',
    year: 1992,
    ceremony: 64,
    isWinner: true,
    ceremonyDate: date('1992-03-30'),
    announcementTime: localtime('21:15:00'),
    votesFor: 4352,
    votesAgainst: 1668,
    speechDuration: duration({minutes: 3, seconds: 12})
}]->(a);

MATCH
  (s:Movie:GeneratedByClaudeAI {title: 'Spider-Man: Into the Spider-Verse'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (s)-[:NOMINATED_FOR {
    category: 'Best Animated Feature Film',
    year: 2019,
    ceremony: 91,
    isWinner: true,
    ceremonyDate: date('2019-02-24'),
    announcementTime: localtime('19:35:00'),
    votesFor: 4879,
    votesAgainst: 1121
}]->(a);

MATCH
  (s:Movie:GeneratedByClaudeAI {title: 'Spider-Man: Into the Spider-Verse'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Annie Awards'})
CREATE (s)-[:NOMINATED_FOR {
    category: 'Best Animated Feature',
    year: 2019,
    ceremony: 46,
    isWinner: true,
    ceremonyDate: date('2019-02-02'),
    announcementTime: localtime('20:45:00'),
    categories: 7,
    wins: 7
}]->(a);

// Professional relationships between people
MATCH
  (r:Person:GeneratedByClaudeAI {name: 'Ryan Gosling'}),
  (d:Person:GeneratedByClaudeAI {name: 'Denis Villeneuve'})
CREATE (r)-[:WORKED_WITH {
    projects: 1,
    firstProject: 'Blade Runner 2049',
    firstYear: 2017,
    chemistry: 4.9,
    interviews: 28,
    relationship: 'Actor-Director',
    nextProjectPlanned: date('2026-06-15')
}]->(d);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Jodie Foster'}),
  (a:Person:GeneratedByClaudeAI {name: 'Anthony Hopkins'})
CREATE (j)-[:WORKED_WITH {
    projects: 1,
    firstProject: 'The Silence of the Lambs',
    firstYear: 1991,
    chemistry: 5.0,
    interviews: 45,
    jointSceneMinutes: 22,
    relationship: 'Co-stars',
    reunionAttempts: 3
}]->(a);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Jodie Foster'}),
  (jd:Person:GeneratedByClaudeAI {name: 'Jonathan Demme'})
CREATE (j)-[:WORKED_WITH {
    projects: 1,
    firstProject: 'The Silence of the Lambs',
    firstYear: 1991,
    chemistry: 4.9,
    interviews: 32,
    relationship: 'Actor-Director',
    awards: ['Academy Award', 'Golden Globe', 'BAFTA']
}]->(jd);

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Anthony Hopkins'}),
  (jd:Person:GeneratedByClaudeAI {name: 'Jonathan Demme'})
CREATE (a)-[:WORKED_WITH {
    projects: 1,
    firstProject: 'The Silence of the Lambs',
    firstYear: 1991,
    chemistry: 4.8,
    interviews: 28,
    relationship: 'Actor-Director',
    filmedDays: 14
}]->(jd);

MATCH
  (h:Person:GeneratedByClaudeAI {name: 'Hailee Steinfeld'}),
  (r:Person:GeneratedByClaudeAI {name: 'Ryan Gosling'})
CREATE (h)-[:KNOWS {
    since: date('2016-08-12'),
    relationship: 'Professional Acquaintances',
    lastMeeting: date('2023-05-18'),
    durationYears: 7,
    commonFriends: 5,
    commonProjects: 0
}]->(r);

// Connection with original graph
MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Anthony Hopkins'}),
  (j:Person {name: 'Jack Nicholson'}) // Original person from the graph
CREATE (a)-[:ADMIRES {
    since: date('1975-11-08'),
    projects: 0,
    relationship: 'Professional Admiration',
    lastContact: date('2019-06-22'),
    inspirationLevel: 4.9,
    influencedWorks: ['The Silence of the Lambs', 'The Father']
}]->(j);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Jodie Foster'}),
  (r:Person {name: 'Renee Zellweger'}) // Original person from the graph
CREATE (j)-[:KNOWS {
    since: date('1995-03-15'),
    relationship: 'Friends',
    lastMeeting: date('2022-11-28'),
    durationYears: 28,
    commonEvents: 15,
    commonFriends: 8
}]->(r);

// Create additional property types on existing relationships
MATCH (j:Person:GeneratedByClaudeAI {name: 'Jonathan Demme'})-[r:DIRECTED]->(s:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'})
SET r.technicalChallenges = ['Clarice-Lecter scenes', 'Buffalo Bill characterization', 'Suspense building']
SET r.techChallengeRatings = [5.0, 4.8, 4.9]
SET r.consultants = ['FBI Behavioral Science Unit', 'John Douglas']
SET r.consultationHours = [120, 85]
SET r.scriptChanges = 23
SET r.finalRuntime = duration({hours: 1, minutes: 58})
SET r.originalRuntime = duration({hours: 2, minutes: 25});

// Create custom prop node for The Silence of the Lambs
CREATE (MothCocoon:Prop:GeneratedByClaudeAI {
    name: 'Death\'s-head Hawkmoth Cocoon',
    movie: 'The Silence of the Lambs',
    material: 'Resin and mixed media',
    weight: 0.05,
    weightUnit: 'kg',
    createdDate: date('1989-10-15'),
    screenTime: duration({minutes: 0, seconds: 45}),
    isIconic: true,
    auctionValue: 8500,
    copiesMade: 15
})
WITH 1 as dummy
MATCH (s:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'}),
      (p:Prop:GeneratedByClaudeAI {name: 'Death\'s-head Hawkmoth Cocoon'})
CREATE (p)-[:USED_IN {
    scenes: ['Autopsy', 'Evidence'],
    sceneCount: 2,
    firstAppearance: time('00:35:22'),
    lastAppearance: time('00:36:07'),
    isCloseup: true,
    significance: 'Critical clue'
}]->(s);

// Create soundtrack node for Silence of the Lambs
CREATE (SilenceSoundtrack:Soundtrack:GeneratedByClaudeAI {
    title: 'The Silence of the Lambs: Original Motion Picture Soundtrack',
    composer: 'Howard Shore',
    released: date('1991-02-12'),
    duration: duration({minutes: 53, seconds: 20}),
    trackCount: 15,
    recordingStudio: 'CTS Studios, London',
    recordingStudioLat: 51.5074,
    recordingStudioLong: -0.1278,
    peakChartPosition: 120,
    salesUnits: 75000,
    streamingCount: 12000000
})
WITH 1 as dummy
MATCH (s:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'}),
      (st:Soundtrack:GeneratedByClaudeAI {title: 'The Silence of the Lambs: Original Motion Picture Soundtrack'})
CREATE (st)-[:COMPOSED_FOR {
    contractDate: date('1989-08-15'),
    completion: date('1990-12-10'),
    nominatedAwards: ['Saturn Award'],
    wonAwards: [],
    spotifyStreams: 8500000,
    youtubeViews: 6200000
}]->(s);

// Create location node for Silence of the Lambs
CREATE (PittsburghLocation:FilmingLocation:GeneratedByClaudeAI {
    name: 'Western Pennsylvania',
    country: 'USA',
    region: 'Pittsburgh area',
    latitude: 40.4406,
    longitude: -79.9959,
    elevation: 232,
    elevationUnit: 'm',
    climate: 'Temperate',
    permitCost: 45000,
    permitCurrency: 'USD',
    firstUsed: date('1989-11-15'),
    lastUsed: date('1990-02-10')
})
WITH 1 as dummy
MATCH (s:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'}),
      (l:FilmingLocation:GeneratedByClaudeAI {name: 'Western Pennsylvania'})
CREATE (s)-[:FILMED_AT {
    startDate: date('1989-11-15'),
    endDate: date('1990-02-10'),
    sceneCount: 32,
    totalDays: 87,
    weatherDelayDays: 8,
    crewSize: 85,
    logisticsCost: 180000,
    accommodationCost: 145000,
    characterPresent: ['Clarice Starling', 'Jack Crawford', 'Buffalo Bill']
}]->(l);

// Create animation studio node
CREATE (SonyAnimation:AnimationStudio:GeneratedByClaudeAI {
    name: 'Sony Pictures Animation',
    founded: date('2002-05-09'),
    headquartersLat: 34.0211,
    headquartersLong: -118.3787,
    employeeCount: 800,
    animationStyle: 'Mixed/Various',
    specialization: 'Feature Animation',
    yearlyProductions: 2.5,
    technologyBudget: 45000000,
    awardWins: 15
})
WITH 1 as dummy
MATCH (s:AnimationStudio:GeneratedByClaudeAI {name: 'Sony Pictures Animation'}),
      (sv:Movie:GeneratedByClaudeAI {title: 'Spider-Man: Into the Spider-Verse'})
CREATE (s)-[:ANIMATED {
    startDate: date('2016-06-15'),
    endDate: date('2018-09-15'),
    teamSize: 142,
    leadAnimators: 28,
    technicalInnovations: ['Comic book visual style', 'Mixed frame rates', 'Hand-drawn elements'],
    softwareUsed: ['Maya', 'Houdini', 'Proprietary tools'],
    renderingHours: 55800,
    totalFrames: 168452
}]->(sv);

// Create director relationships for Spider-Verse
CREATE (BobP:Person:GeneratedByClaudeAI {
    name: 'Bob Persichetti',
    born: 1973,
    birthdate: date('1973-01-17'),
    nationality: 'American',
    oscarWins: 1,
    isActive: true,
    firstFilm: datetime('2018-12-14T00:00:00Z'),
    animationBackground: true,
    specialization: 'Animation Direction',
    yearsInIndustry: 25
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Bob Persichetti'}),
      (s:Movie:GeneratedByClaudeAI {title: 'Spider-Man: Into the Spider-Verse'})
CREATE (p)-[:CO_DIRECTED {
    year: 2018,
    daysOnProject: 912,
    satisfaction: 4.9,
    awardNominations: 12,
    awardWins: 8,
    completionDate: date('2018-10-01'),
    premiereEvent: datetime('2018-12-01T19:00:00-08:00'),
    durationMonths: 30,
    responsibility: 'Animation Direction',
    isFirstDirectingRole: true
}]->(s);

// Create costume designer for Silence of the Lambs
CREATE (ColetteA:Person:GeneratedByClaudeAI {
    name: 'Colleen Atwood',
    born: 1948,
    birthdate: date('1948-09-25'),
    nationality: 'American',
    oscarWins: 4,
    oscarNominations: 12,
    isActive: true,
    firstFilm: datetime('1984-11-09T00:00:00Z'),
    designStyle: 'Period-accurate with subtle character elements',
    heightInMeters: 1.65,
    specialization: 'Costume Design'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Colleen Atwood'}),
      (s:Movie:GeneratedByClaudeAI {title: 'The Silence of the Lambs'})
CREATE (p)-[:DESIGNED_COSTUMES_FOR {
    year: 1991,
    costumesCreated: 248,
    budget: 380000,
    awardNominations: 3,
    awardWins: 1,
    startDate: date('1989-09-15'),
    completionDate: date('1989-11-10'),
    specialCostumes: ['Buffalo Bill', 'Hannibal Lecter restraints', 'FBI uniforms'],
    researchHours: 120
}]->(s);

// Create cinematographer for Blade Runner 2049
CREATE (RogerD:Person:GeneratedByClaudeAI {
    name: 'Roger Deakins',
    born: 1949,
    birthdate: date('1949-05-24'),
    nationality: 'British',
    oscarWins: 2,
    oscarNominations: 15,
    isActive: true,
    firstFilm: datetime('1984-01-20T00:00:00Z'),
    knighted: date('2021-02-12'),
    cameraPreference: 'ARRI Alexa',
    visualStyle: 'Naturalistic lighting with striking composition'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Roger Deakins'}),
      (b:Movie:GeneratedByClaudeAI {title: 'Blade Runner 2049'})
CREATE (p)-[:CINEMATOGRAPHY_FOR {
    year: 2017,
    cameras: ['ARRI Alexa XT', 'ARRI Alexa Mini'],
    lenses: ['Zeiss Master Primes', 'Cooke S4'],
    awardNominations: 15,
    awardWins: 12,
    startDate: date('2016-07-12'),
    completionDate: date('2016-11-25'),
    signature_shots: ['Las Vegas ruins', 'Snow fight', 'Ocean wall'],
    lighting_setups: 137
}]->(b);

// Create fan community node for Blade Runner
CREATE (BladeRunnerFandom:FanCommunity:GeneratedByClaudeAI {
    name: 'Blade Runner Fan Community',
    established: date('1982-06-25'),
    expansion2049: date('2017-10-06'),
    memberCount: 356000,
    onlinePlatforms: 5,
    annualConventions: 3,
    largestEventAttendance: 8500,
    contentCreators: 15800,
    fanfictionCount: 12500,
    fanArtCount: 35600,
    academicPapers: 248
})
WITH 1 as dummy
MATCH (f:FanCommunity:GeneratedByClaudeAI {name: 'Blade Runner Fan Community'}),
      (b:Movie:GeneratedByClaudeAI {title: 'Blade Runner 2049'})
CREATE (f)-[:ENGAGED_WITH {
    anticipationScore: 9.5,
    reviewsSubmitted: 45800,
    averageRating: 8.7,
    onlineDiscussions: 12500,
    theoriesGenerated: 3400,
    preReleaseEvents: 28,
    postReleaseEvents: 112,
    merchandiseSales: 3800000,
    reissuesCampaigns: 5
}]->(b);

// Create technical innovation node for Spider-Verse
CREATE (SpiderVerseInnovation:TechnicalInnovation:GeneratedByClaudeAI {
    name: 'Spider-Verse Animation Style',
    developedDate: date('2016-09-25'),
    patented: date('2019-03-15'),
    teamSize: 38,
    developmentCost: 15000000,
    mainApplication: 'Animated Feature Films',
    secondaryApplications: 3,
    technicalPapersPublished: 8,
    industryAwards: 12,
    adoptionRate: 0.65
})
WITH 1 as dummy
MATCH (t:TechnicalInnovation:GeneratedByClaudeAI {name: 'Spider-Verse Animation Style'}),
      (s:Movie:GeneratedByClaudeAI {title: 'Spider-Man: Into the Spider-Verse'})
CREATE (t)-[:USED_IN {
    implementationDate: date('2016-09-25'),
    fullIntegrationDate: date('2018-05-15'),
    developmentPhases: 4,
    testingIterations: 15,
    successMetric: 'Visual distinction and audience response',
    successScore: 9.8,
    industryInfluence: 'Major',
    subsequentAdopters: 12
}]->(s);

// Create music composer for Spider-Verse
CREATE (DanielP:Person:GeneratedByClaudeAI {
    name: 'Daniel Pemberton',
    born: 1977,
    birthdate: date('1977-11-03'),
    nationality: 'British',
    awardWins: 5,
    awardNominations: 15,
    isActive: true,
    firstFilm: datetime('2011-05-25T00:00:00Z'),
    musicStyle: 'Eclectic with electronic elements',
    instrumentsPlayed: 6,
    studioLocation: 'London'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Daniel Pemberton'}),
      (s:Movie:GeneratedByClaudeAI {title: 'Spider-Man: Into the Spider-Verse'})
CREATE (p)-[:COMPOSED_MUSIC_FOR {
    year: 2018,
    tracksComposed: 25,
    recordingDays: 42,
    instrumentsUsed: 28,
    electronicallyProduced: true,
    collaboratingArtists: 8,
    startDate: date('2017-05-15'),
    completionDate: date('2018-09-10'),
    signature_themes: ['Miles\' Theme', 'Spider-Heroes', 'Leap of Faith'],
    recording_studios: 3
}]->(s);

// Create a classic film
CREATE (CitizenKane:Movie:GeneratedByClaudeAI {
    title: 'Citizen Kane',
    released: 1941,
    tagline: 'It\'s Terrific!',
    budget: 839727,
    revenue: 1585634,
    runtime_minutes: 119,
    rating_avg: 8.3,
    releaseDate: date('1941-09-05'),
    digitalRestoration: datetime('1998-11-25T00:00:00Z'),
    isOscarWinner: true,
    preservationDate: date('1989-12-14'),
    isPreservationRegistry: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'})
SET m.ratings = [8.4, 8.3, 8.2, 8.3]
SET m.genres = ['drama', 'mystery']
SET m.certifications = ['PG', 'U']
SET m.filmingLocationLat = [34.0522, 40.7128]
SET m.filmingLocationLong = [-118.2437, -74.0060]
SET m.boxOfficeNA = 1585634
SET m.initialReviews = ['mixed', 'controversial', 'revolutionary']
SET m.preservationRegistry = 'National Film Registry'
SET m.technicalInnovations = ['Deep focus', 'Low-angle shots', 'Flashback structure'];

// Create an acclaimed foreign film
CREATE (Parasite:Movie:GeneratedByClaudeAI {
    title: 'Parasite',
    released: 2019,
    tagline: 'Act like you own the place',
    budget: 11400000,
    revenue: 263100000,
    runtime_minutes: 132,
    rating_avg: 8.5,
    releaseDate: date('2019-05-30'),
    digitalRelease: datetime('2020-01-14T00:00:00Z'),
    isOscarWinner: true,
    isInternational: true,
    originalLanguage: 'Korean'
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Parasite'})
SET m.ratings = [8.6, 8.5, 8.4, 8.5]
SET m.genres = ['thriller', 'drama', 'comedy', 'social commentary']
SET m.certifications = ['R', '15']
SET m.filmingLocationLat = [37.5665, 37.5519]
SET m.filmingLocationLong = [126.9780, 126.9918]
SET m.boxOfficeNA = 53369749
SET m.boxOfficeInternational = 209751049
SET m.subtitleLanguages = ['English', 'Spanish', 'French', 'Japanese', 'German']
SET m.festivalsWon = ['Cannes Film Festival', 'Academy Awards', 'BAFTA', 'Golden Globe'];

// Create an acclaimed documentary
CREATE (MarchOfThePenguins:Movie:GeneratedByClaudeAI {
    title: 'March of the Penguins',
    released: 2005,
    tagline: 'In the harshest place on Earth, love finds a way',
    budget: 8000000,
    revenue: 127400000,
    runtime_minutes: 80,
    rating_avg: 7.5,
    releaseDate: date('2005-01-26'),
    digitalRelease: datetime('2005-11-29T00:00:00Z'),
    isOscarWinner: true,
    isDocumentary: true,
    filmingConditions: 'Extreme Antarctic'
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'March of the Penguins'})
SET m.ratings = [7.6, 7.5, 7.4, 7.5]
SET m.genres = ['documentary', 'nature']
SET m.certifications = ['G', 'U']
SET m.filmingLocationLat = [-75.2500]
SET m.filmingLocationLong = [0.0000]
SET m.boxOfficeNA = 77437223
SET m.boxOfficeInternational = 49962777
SET m.narrators = ['Morgan Freeman', 'Charles Berling']
SET m.filmingDuration = duration({months: 13})
SET m.extremeTemperatures = [-40, -70]
SET m.temperatureUnit = 'Celsius';

// Create notable historical film personalities
CREATE (OrsonW:Person:GeneratedByClaudeAI {
    name: 'Orson Welles',
    born: 1915,
    died: 1985,
    birthdate: date('1915-05-06'),
    deathdate: date('1985-10-10'),
    nationality: 'American',
    oscarWins: 1,
    oscarNominations: 3,
    isActive: false,
    firstFilm: datetime('1941-09-05T00:00:00Z'),
    lastFilm: datetime('1985-10-10T00:00:00Z'),
    careerLength: duration({years: 44, months: 5}),
    heightInMeters: 1.87,
    significance: 'Pioneer in filmmaking techniques'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Orson Welles'})
SET p.languages = ['English', 'French', 'Spanish', 'Italian']
SET p.skillSets = ['Directing', 'Acting', 'Writing', 'Producing', 'Radio']
SET p.filmography_titles = ['Citizen Kane', 'The Magnificent Ambersons', 'Touch of Evil']
SET p.filmography_years = [1941, 1942, 1958]
SET p.filmography_roles = ['Charles Foster Kane', 'Narrator', 'Hank Quinlan'];

CREATE (BongJH:Person:GeneratedByClaudeAI {
    name: 'Bong Joon-ho',
    born: 1969,
    birthdate: date('1969-09-14'),
    nationality: 'South Korean',
    oscarWins: 4,
    oscarNominations: 4,
    isActive: true,
    firstFilm: datetime('2000-02-05T00:00:00Z'),
    careerLength: duration({years: 23}),
    heightInMeters: 1.74,
    filmingStyle: 'Genre-mixing with social commentary'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Bong Joon-ho'})
SET p.languages = ['Korean', 'English']
SET p.skillSets = ['Directing', 'Writing', 'Producing']
SET p.filmography_titles = ['Parasite', 'Snowpiercer', 'Okja', 'The Host']
SET p.filmography_years = [2019, 2013, 2017, 2006]
SET p.internationalRecognition = ['Cannes', 'Academy Awards', 'BAFTA'];

CREATE (LucJacquet:Person:GeneratedByClaudeAI {
    name: 'Luc Jacquet',
    born: 1967,
    birthdate: date('1967-12-05'),
    nationality: 'French',
    oscarWins: 1,
    oscarNominations: 1,
    isActive: true,
    firstFilm: datetime('2005-01-26T00:00:00Z'),
    background: 'Biologist',
    specialization: 'Nature Documentaries',
    heightInMeters: 1.78
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Luc Jacquet'})
SET p.languages = ['French', 'English']
SET p.academicDegrees = ['Biology', 'Ecology']
SET p.filmography_titles = ['March of the Penguins', 'The Fox and the Child', 'Ice and the Sky']
SET p.filmography_years = [2005, 2007, 2015]
SET p.fieldworkLocations = ['Antarctica', 'Arctic', 'Alps'];

CREATE (SongKS:Person:GeneratedByClaudeAI {
    name: 'Song Kang-ho',
    born: 1967,
    birthdate: date('1967-01-17'),
    nationality: 'South Korean',
    oscarNominations: 0,
    isActive: true,
    firstFilm: datetime('1996-10-15T00:00:00Z'),
    heightInMeters: 1.80,
    netWorth: 20000000,
    actingRangeScore: 9.5,
    collaborationsWithBong: 4
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Song Kang-ho'})
SET p.languages = ['Korean', 'English']
SET p.filmography_titles = ['Parasite', 'The Host', 'Snowpiercer', 'Memories of Murder']
SET p.filmography_years = [2019, 2006, 2013, 2003]
SET p.filmography_roles = ['Kim Ki-taek', 'Park Gang-du', 'Namgoong Minsu', 'Detective Park'];

// Create editor/cinematographer
CREATE (GreggT:Person:GeneratedByClaudeAI {
    name: 'Gregg Toland',
    born: 1904,
    died: 1948,
    birthdate: date('1904-05-29'),
    deathdate: date('1948-09-28'),
    nationality: 'American',
    oscarWins: 1,
    oscarNominations: 6,
    isActive: false,
    firstFilm: datetime('1930-01-01T00:00:00Z'),
    lastFilm: datetime('1948-01-15T00:00:00Z'),
    careerLength: duration({years: 18}),
    specialization: 'Cinematography',
    technicalInnovations: 5
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Gregg Toland'})
SET p.innovations = ['Deep focus', 'Low-angle shots', 'Chiaroscuro lighting']
SET p.filmography_titles = ['Citizen Kane', 'The Grapes of Wrath', 'The Best Years of Our Lives']
SET p.filmography_years = [1941, 1940, 1946]
SET p.technicalPreferences = ['Deep focus lenses', 'Low-key lighting', 'Wide-angle lenses'];

// Create more studios
CREATE (CJEntertainment:Studio:GeneratedByClaudeAI {
    name: 'CJ Entertainment',
    founded: date('1995-09-01'),
    headquartersLat: 37.5665,
    headquartersLong: 126.9780,
    yearlyRevenue2019: 850000000,
    yearlyRevenue2020: 720000000,
    yearlyRevenue2021: 890000000,
    digitalStreamingDate: datetime('2018-05-15T00:00:00Z'),
    isPublic: true,
    marketShare: 0.032,
    internationalPresence: 12
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'CJ Entertainment'})
SET s.subsidiaries = ['CJ CGV', 'CJ E&M']
SET s.distributionMarkets = ['South Korea', 'North America', 'Asia', 'Europe']
SET s.studioLotsLat = [37.5665, 34.0522]
SET s.studioLotsLong = [126.9780, -118.2437]
SET s.internationalOffices = ['Los Angeles', 'Tokyo', 'Beijing', 'London'];

CREATE (DisneyNature:Studio:GeneratedByClaudeAI {
    name: 'Disneynature',
    founded: date('2008-04-21'),
    headquartersLat: 34.1551,
    headquartersLong: -118.3213,
    yearlyRevenue2019: 120000000,
    yearlyRevenue2020: 85000000,
    yearlyRevenue2021: 110000000,
    digitalStreamingDate: datetime('2020-03-28T00:00:00Z'),
    isPublic: false,
    parentCompany: 'Walt Disney Studios',
    conservationContributions: 35000000
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Disneynature'})
SET s.documentaryFocus = ['Wildlife', 'Conservation', 'Environmental']
SET s.distributionMarkets = ['Global']
SET s.releasedTitles = ['Earth', 'Oceans', 'African Cats', 'Bears', 'Penguins']
SET s.releasedYears = [2009, 2010, 2011, 2014, 2019]
SET s.conservationPartners = ['Conservation International', 'WWF', 'Wildlife Conservation Network'];

CREATE (RKOPictures:Studio:GeneratedByClaudeAI {
    name: 'RKO Pictures',
    founded: date('1928-01-25'),
    dissolved: date('1959-12-31'),
    reestablished: date('1989-01-15'),
    headquartersLat: 34.0522,
    headquartersLong: -118.2437,
    peakYearlyRevenue: 120000000,
    peakYear: 1946,
    digitalArchiveCreation: datetime('2001-06-15T00:00:00Z'),
    isActive: false,
    historicalSignificance: 'Major Golden Age Studio'
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'RKO Pictures'})
SET s.notableFilms = ['Citizen Kane', 'King Kong', 'It\'s a Wonderful Life']
SET s.notableYears = [1941, 1933, 1946]
SET s.studioLotsHistorical = ['Hollywood', 'Culver City', 'New York']
SET s.keyFigures = ['Howard Hughes', 'Floyd Odlum', 'Peter Rathvon']
SET s.archivalFootageHours = 5200;

// Create filming events
CREATE (CitizenKaneProduction:Production:GeneratedByClaudeAI {
    name: 'Citizen Kane Production',
    startDate: date('1940-07-22'),
    endDate: date('1940-10-23'),
    durationMonths: 3,
    durationDays: 1,
    startTime: localtime('08:00:00'),
    isCompleted: true,
    budgetPersonnel: 350000,
    budgetEquipment: 150000,
    budgetLocations: 100000,
    budgetSets: 200000,
    budgetOther: 39727,
    weatherGood: 85,
    weatherAcceptable: 12,
    weatherPoor: 3
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Citizen Kane Production'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['06:00:00', '07:30:00', '08:00:00', '19:00:00']
SET p.scheduleDurations = [1.5, 0.5, 11, 1]
SET p.technicalInnovations = ['Deep focus cinematography', 'Low-angle shots', 'Ceiling shots']
SET p.innovationImpact = [9.5, 9.0, 8.8];

CREATE (ParasiteProduction:Production:GeneratedByClaudeAI {
    name: 'Parasite Production',
    startDate: date('2018-05-18'),
    endDate: date('2018-09-19'),
    durationMonths: 4,
    durationDays: 1,
    startTime: localtime('07:00:00'),
    isCompleted: true,
    budgetPersonnel: 4500000,
    budgetEquipment: 1500000,
    budgetLocations: 1000000,
    budgetSets: 3500000,
    budgetOther: 900000,
    weatherGood: 75,
    weatherAcceptable: 20,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Parasite Production'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['05:00:00', '06:30:00', '07:00:00', '19:00:00']
SET p.scheduleDurations = [1.5, 0.5, 12, 1]
SET p.customSets = ['Park Family House', 'Kim Family Semi-basement', 'Underground Bunker']
SET p.setConstructionDays = [45, 30, 25];

CREATE (PenguinsFilming:Production:GeneratedByClaudeAI {
    name: 'March of the Penguins Filming',
    startDate: date('2003-01-15'),
    endDate: date('2004-02-20'),
    durationMonths: 13,
    durationDays: 5,
    isCompleted: true,
    budgetPersonnel: 2000000,
    budgetEquipment: 3000000,
    budgetTransport: 2000000,
    budgetSurvival: 800000,
    budgetOther: 200000,
    weatherGood: 15,
    weatherAcceptable: 30,
    weatherPoor: 55,
    extremeConditionDays: 280
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'March of the Penguins Filming'})
SET p.environmentalChallenges = ['Extreme cold', 'Isolation', 'Limited light', 'Storms']
SET p.challengeSeverity = [9.5, 8.5, 7.0, 9.0]
SET p.specialEquipment = ['Cold-resistant cameras', 'Thermal protection', 'Custom lighting']
SET p.equipmentSuccessRate = [0.85, 0.92, 0.78]
SET p.crewRotations = 6;

// Add reviews
CREATE (CitizenKaneReview:Review:GeneratedByClaudeAI {
    title: 'The Greatest Film Ever Made',
    stars: 5.0,
    date: date('1941-09-12'),
    historicalReassessmentDate: date('1962-01-15'),
    isVerified: true,
    aspectDirection: 5.0,
    aspectActing: 5.0,
    aspectVisuals: 5.0,
    aspectWriting: 5.0,
    aspectInnovation: 5.0,
    reviewText: 'Citizen Kane represents the pinnacle of filmmaking craft and storytelling innovation. Orson Welles\' debut feature revolutionized cinema with its non-linear narrative structure, deep focus photography, and complex character study.',
    historicalRelevance: 'Transformative'
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'The Greatest Film Ever Made'})
SET r.modernReassessmentDates = [date('1962-01-15'), date('1972-01-15'), date('2002-01-15')]
SET r.sightAndSoundRankings = [1, 1, 2]
SET r.rankingYears = [1962, 1972, 2002]
SET r.keywords = ['masterpiece', 'innovative', 'influential', 'groundbreaking']
SET r.academicCitations = 1458;

CREATE (ParasiteReview:Review:GeneratedByClaudeAI {
    title: 'A Perfect Social Satire',
    stars: 5.0,
    date: date('2019-05-30'),
    time: time('14:23:45+09:00'),
    isVerified: true,
    aspectDirection: 5.0,
    aspectActing: 5.0,
    aspectVisuals: 4.9,
    aspectWriting: 5.0,
    aspectSocialCommentary: 5.0,
    reviewText: 'Bong Joon-ho\'s Parasite is a masterful blend of dark comedy, social commentary, and suspense. The film dissects class inequality with surgical precision while never losing its entertainment value or emotional impact.',
    upvotes: 12583
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'A Perfect Social Satire'})
SET r.commentTimestamps = [datetime('2019-05-30T16:22:43+09:00'), datetime('2019-05-31T08:15:12+09:00'), datetime('2019-06-01T12:32:01+09:00')]
SET r.keywords = ['class-struggle', 'social-satire', 'genre-bending', 'masterpiece']
SET r.readerLocationsLat = [37.5665, 34.0522, 40.7128]
SET r.readerLocationsLong = [126.9780, -118.2437, -74.0060]
SET r.translationLanguages = ['English', 'French', 'Japanese', 'Spanish', 'German'];

CREATE (PenguinsReview:Review:GeneratedByClaudeAI {
    title: 'Nature\'s Drama Captured Beautifully',
    stars: 4.5,
    date: date('2005-06-24'),
    time: time('16:45:30-04:00'),
    isVerified: true,
    aspectDirection: 4.7,
    aspectCinematography: 4.9,
    aspectNarration: 4.8,
    aspectEducationalValue: 4.6,
    aspectEmotionalImpact: 4.7,
    reviewText: 'March of the Penguins transforms the harsh reality of Emperor penguin survival into a compelling narrative of love, struggle, and perseverance. The breathtaking Antarctic cinematography and Morgan Freeman\'s narration elevate this documentary into something truly special.',
    upvotes: 7823
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'Nature\'s Drama Captured Beautifully'})
SET r.commentTimestamps = [datetime('2005-06-24T18:22:15-04:00'), datetime('2005-06-25T09:45:33-04:00'), datetime('2005-06-26T14:18:42-04:00')]
SET r.keywords = ['nature', 'documentary', 'antarctica', 'survival', 'family-friendly']
SET r.readerLocationsLat = [40.7128, 48.8566, 34.0522]
SET r.readerLocationsLong = [-74.0060, 2.3522, -118.2437]
SET r.familyRecommendationScore = 9.2;

// Create Venice Film Festival
CREATE (VeniceFilmFestival:Ceremony:GeneratedByClaudeAI {
    name: 'Venice Film Festival',
    nickname: 'La Biennale di Venezia',
    established: date('1932-08-03'),
    ceremonyTime: localtime('19:00:00'),
    typicalDurationDays: 11,
    isPrestigious: true,
    locationLat: 45.4408,
    locationLong: 12.3155,
    locationHeight: 1,
    nextCeremony: datetime('2025-08-27T19:00:00+02:00'),
    historicalSignificance: 'Oldest Film Festival'
})
WITH 1 as dummy
MATCH (c:Ceremony:GeneratedByClaudeAI {name: 'Venice Film Festival'})
SET c.categories = ['Golden Lion', 'Silver Lion', 'Volpi Cup for Best Actor', 'Volpi Cup for Best Actress']
SET c.attendance2019 = 45000
SET c.attendance2020 = 12000
SET c.attendance2021 = 28000
SET c.attendance2022 = 35000
SET c.historicalWinners = ['Rome, Open City', 'Rashomon', 'Brokeback Mountain', 'Joker', 'Nomadland']
SET c.historicalYears = [1946, 1951, 2005, 2019, 2020];

// Add National Film Preservation Board
CREATE (FilmPreservationBoard:Organization:GeneratedByClaudeAI {
    name: 'National Film Preservation Board',
    established: date('1988-09-27'),
    headquartersLat: 38.8895,
    headquartersLong: -77.0353,
    annualBudget: 13500000,
    preservedFilmsCount: 850,
    digitalizedFilmsCount: 425,
    memberOrganizations: 22,
    nextPreservationAnnouncement: datetime('2025-12-14T10:00:00-05:00'),
    isGovernmentFunded: true
})
WITH 1 as dummy
MATCH (o:Organization:GeneratedByClaudeAI {name: 'National Film Preservation Board'})
SET o.preservationCriteria = ['Cultural significance', 'Historical importance', 'Aesthetic quality', 'Technical innovation']
SET o.criteriaWeights = [0.35, 0.25, 0.2, 0.2]
SET o.earliestPreservedFilm = 'The Great Train Robbery'
SET o.earliestPreservationYear = 1990
SET o.earliestFilmYear = 1903
SET o.digitalPreservationBudget = 5200000;

// Create relationships between nodes with various data types
MATCH 
  (o:Person:GeneratedByClaudeAI {name: 'Orson Welles'}),
  (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'})
CREATE (o)-[:DIRECTED {
    year: 1941,
    daysOnSet: 101,
    satisfaction: 4.8,
    studioPressure: 'High',
    completionDate: date('1940-10-23'),
    premiereEvent: datetime('1941-05-01T19:30:00-05:00'),
    durationMonths: 3,
    isFirstFeatureFilm: true,
    age: 25
}]->(c);

MATCH 
  (b:Person:GeneratedByClaudeAI {name: 'Bong Joon-ho'}),
  (p:Movie:GeneratedByClaudeAI {title: 'Parasite'})
CREATE (b)-[:DIRECTED {
    year: 2019,
    daysOnSet: 74,
    satisfaction: 4.9,
    awardWins: 213,
    completionDate: date('2018-11-25'),
    premiereEvent: datetime('2019-05-21T19:00:00+02:00'),
    durationMonths: 4,
    isFirstInternationalBreakout: false,
    personalThemes: ['Class inequality', 'Family dynamics', 'Dark humor']
}]->(p);

MATCH 
  (l:Person:GeneratedByClaudeAI {name: 'Luc Jacquet'}),
  (m:Movie:GeneratedByClaudeAI {title: 'March of the Penguins'})
CREATE (l)-[:DIRECTED {
    year: 2005,
    daysInAntarctica: 314,
    fieldworkPhases: 3,
    satisfaction: 4.7,
    awardWins: 24,
    completionDate: date('2004-11-15'),
    premiereEvent: datetime('2005-01-26T20:00:00+01:00'),
    durationMonths: 13,
    isFirstMajorDocumentary: true,
    scientificConsultants: 8
}]->(m);

// Actor to Movie relationships
MATCH
  (o:Person:GeneratedByClaudeAI {name: 'Orson Welles'}),
  (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'})
CREATE (o)-[:ACTED_IN {
    roles: ['Charles Foster Kane'],
    salary: 100000,
    screenTimeMinutes: 95,
    startDate: date('1940-07-22'),
    endDate: date('1940-10-23'),
    scheduleConflicts: false,
    dualRoleComplexity: 'Very High',
    makeupHoursDaily: 3.5,
    ageTransformationYears: 44
}]->(c);

MATCH
  (s:Person:GeneratedByClaudeAI {name: 'Song Kang-ho'}),
  (p:Movie:GeneratedByClaudeAI {title: 'Parasite'})
CREATE (s)-[:ACTED_IN {
    roles: ['Kim Ki-taek'],
    salary: 750000,
    screenTimeMinutes: 85,
    startDate: date('2018-05-18'),
    endDate: date('2018-09-19'),
    scheduleConflicts: false,
    criticScore: 98,
    audienceScore: 95,
    awardNominations: 36,
    awardWins: 22,
    languagesSpoken: ['Korean']
}]->(p);

// Cinematographer relationship
MATCH
  (g:Person:GeneratedByClaudeAI {name: 'Gregg Toland'}),
  (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'})
CREATE (g)-[:CINEMATOGRAPHY_FOR {
    year: 1941,
    cameras: ['Mitchell BNC', 'Mitchell NC'],
    lenses: ['Bausch & Lomb Super Baltar', 'Cooke S1'],
    innovationsTested: ['Ultra-deep focus', 'Low-angle shots', 'Ceiling shots'],
    innovationsSuccessRate: [0.95, 0.98, 0.92],
    startDate: date('1940-07-22'),
    completionDate: date('1940-10-23'),
    signatureTechniques: ['Deep focus', 'Dramatic lighting', 'Low-angle shots'],
    technicalChallengesOvercome: 12
}]->(c);

// Narrator relationship
CREATE (MorganF:Person:GeneratedByClaudeAI {
    name: 'Morgan Freeman',
    born: 1937,
    birthdate: date('1937-06-01'),
    nationality: 'American',
    oscarWins: 1,
    oscarNominations: 5,
    isActive: true,
    voiceRecognition: 9.8,
    voiceType: 'Authoritative baritone',
    narratorRanking: 1
})
WITH 1 as dummy
MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Morgan Freeman'}),
  (p:Movie:GeneratedByClaudeAI {title: 'March of the Penguins'})
CREATE (m)-[:NARRATED {
    year: 2005,
    language: 'English',
    recordingDays: 5,
    studioLocation: 'Los Angeles',
    recordingSessionHours: 25,
    scriptPages: 65,
    audienceImpactRating: 9.5,
    recordingCompletionDate: date('2004-12-05'),
    rerecordingRequired: false
}]->(p);

// Writer relationship
MATCH
  (o:Person:GeneratedByClaudeAI {name: 'Orson Welles'}),
  (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'})
CREATE (o)-[:WROTE {
    year: 1940,
    coWriter: 'Herman J. Mankiewicz',
    draftCount: 7,
    finalPageCount: 156,
    writingStartDate: date('1939-07-01'),
    writingCompletionDate: date('1940-05-15'),
    inspirationSources: ['William Randolph Hearst', 'Joseph Pulitzer', 'Samuel Insull'],
    controversyLevel: 'Very High',
    scriptNominations: 2,
    scriptWins: 1
}]->(c);

MATCH
  (b:Person:GeneratedByClaudeAI {name: 'Bong Joon-ho'}),
  (p:Movie:GeneratedByClaudeAI {title: 'Parasite'})
CREATE (b)-[:WROTE {
    year: 2018,
    coWriter: 'Han Jin-won',
    draftCount: 5,
    finalPageCount: 131,
    writingStartDate: date('2017-01-15'),
    writingCompletionDate: date('2018-02-20'),
    inspirationSources: ['Class inequality', 'Social architecture', 'Personal experiences'],
    thematicElements: ['Class struggle', 'Infiltration', 'Deception', 'Symbiosis'],
    scriptNominations: 23,
    scriptWins: 18
}]->(p);

// Studio relationships
MATCH
  (r:Studio:GeneratedByClaudeAI {name: 'RKO Pictures'}),
  (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'})
CREATE (r)-[:PRODUCED {
    investment: 839727,
    return: 1585634,
    roi: 1.89,
    contractSigned: date('1939-07-22'),
    studioRisk: 'Very High',
    executiveSupport: 'Mixed',
    marketingBudget: 150000,
    isProfitable: true,
    marketingStartDate: datetime('1941-01-15T00:00:00-05:00'),
    controversyHandling: 'Aggressive defense',
    heartNegativePressureLevel: 9.7
}]->(c);

MATCH
  (c:Studio:GeneratedByClaudeAI {name: 'CJ Entertainment'}),
  (p:Movie:GeneratedByClaudeAI {title: 'Parasite'})
CREATE (c)-[:PRODUCED {
    investment: 11400000,
    return: 263100000,
    roi: 23.08,
    contractSigned: date('2017-09-15'),
    studioShare: 0.6,
    directorShare: 0.2,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 25000000,
    isProfitable: true,
    marketingStart: datetime('2019-02-15T00:00:00+09:00'),
    internationalMarketingBoost: datetime('2019-05-25T00:00:00+02:00'),
    breakEvenDate: date('2019-08-01')
}]->(p);

MATCH
  (d:Studio:GeneratedByClaudeAI {name: 'Disneynature'}),
  (p:Movie:GeneratedByClaudeAI {title: 'March of the Penguins'})
CREATE (d)-[:DISTRIBUTED {
    territories: ['North America'],
    acquisitionDate: date('2005-01-30'),
    acquisitionCost: 1000000,
    marketingBudget: 15000000,
    marketingStart: datetime('2005-04-15T00:00:00-04:00'),
    isProfitable: true,
    returnOnInvestment: 38.4,
    educationalProgramCreated: true,
    conservationDonation: 1000000,
    familyMarketingFocus: 0.85
}]->(p);

// Studio to filming relationship
MATCH
  (r:Studio:GeneratedByClaudeAI {name: 'RKO Pictures'}),
  (p:Production:GeneratedByClaudeAI {name: 'Citizen Kane Production'})
CREATE (r)-[:FINANCED {
    contractDate: date('1939-07-22'),
    amount: 839727,
    isFullyPaid: true,
    transferTime1: datetime('1939-08-15T00:00:00-05:00'),
    transferTime2: datetime('1939-11-30T00:00:00-05:00'),
    transferTime3: datetime('1940-06-15T00:00:00-05:00'),
    paymentDate1: date('1939-08-15'),
    paymentAmount1: 250000,
    paymentDate2: date('1939-11-30'),
    paymentAmount2: 250000,
    paymentDate3: date('1940-06-15'),
    paymentAmount3: 339727,
    executiveOversight: 'Minimal initially, Heavy later'
}]->(p);

MATCH
  (c:Studio:GeneratedByClaudeAI {name: 'CJ Entertainment'}),
  (p:Production:GeneratedByClaudeAI {name: 'Parasite Production'})
CREATE (c)-[:FINANCED {
    contractDate: date('2017-09-15'),
    amount: 11400000,
    isFullyPaid: true,
    transferTime1: datetime('2018-02-01T00:00:00+09:00'),
    transferTime2: datetime('2018-05-01T00:00:00+09:00'),
    transferTime3: datetime('2018-08-01T00:00:00+09:00'),
    paymentDate1: date('2018-02-01'),
    paymentAmount1: 3400000,
    paymentDate2: date('2018-05-01'),
    paymentAmount2: 4500000,
    paymentDate3: date('2018-08-01'),
    paymentAmount3: 3500000
}]->(p);

// Filming to movie relationship
MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Citizen Kane Production'}),
  (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 3,
    durationDays: 1,
    setCount: 16,
    soundstageCount: 8,
    locationCount: 3,
    dailyAverageCost: 8312,
    scheduleAdherence: 0.88,
    originalScheduledEnd: date('1940-10-15'),
    technicalChallengesOvercome: 14,
    innovationSuccessRate: 0.92
}]->(c);

MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Parasite Production'}),
  (m:Movie:GeneratedByClaudeAI {title: 'Parasite'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 4,
    durationDays: 1,
    setCount: 12,
    customSetsBudget: 3500000,
    locationCount: 8,
    dailyAverageCost: 125000,
    scheduleAdherence: 0.95,
    originalScheduledEnd: date('2018-09-15'),
    perfectShotTakes: 247,
    totalTakes: 1845
}]->(m);

MATCH
  (p:Production:GeneratedByClaudeAI {name: 'March of the Penguins Filming'}),
  (m:Movie:GeneratedByClaudeAI {title: 'March of the Penguins'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 13,
    durationDays: 5,
    totalFootage: 869,
    footageUnit: 'Hours',
    extremeConditionDays: 280,
    dailyAverageCost: 20000,
    equipmentMalfunctions: 42,
    scheduleExtensions: 3,
    originalScheduledEnd: date('2003-11-30'),
    scientificValueRating: 9.2
}]->(m);

// Award relationships
MATCH
  (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (c)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 1942,
    ceremony: 14,
    isWinner: false,
    ceremonyDate: date('1942-02-26'),
    announcementTime: localtime('21:45:00'),
    votesFor: 325,
    votesAgainst: 352,
    historicalReassessment: 'Should have won',
    controversyLevel: 'Very High'
}]->(a);

MATCH
  (o:Person:GeneratedByClaudeAI {name: 'Orson Welles'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (o)-[:NOMINATED_FOR {
    category: 'Best Original Screenplay',
    year: 1942,
    ceremony: 14,
    isWinner: true,
    ceremonyDate: date('1942-02-26'),
    announcementTime: localtime('20:15:00'),
    coRecipient: 'Herman J. Mankiewicz',
    attendance: false,
    reasonForAbsence: 'Political tensions',
    historicalSignificance: 'Only Oscar win for Welles'
}]->(a);

MATCH
  (p:Movie:GeneratedByClaudeAI {title: 'Parasite'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (p)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 2020,
    ceremony: 92,
    isWinner: true,
    ceremonyDate: date('2020-02-09'),
    announcementTime: localtime('21:55:00'),
    votesFor: 5823,
    votesAgainst: 3215,
    historicalSignificance: 'First non-English language Best Picture',
    audienceReaction: 'Standing ovation',
    ovationLength: duration({minutes: 3, seconds: 12})
}]->(a);

MATCH
  (b:Person:GeneratedByClaudeAI {name: 'Bong Joon-ho'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (b)-[:NOMINATED_FOR {
    category: 'Best Director',
    year: 2020,
    ceremony: 92,
    isWinner: true,
    ceremonyDate: date('2020-02-09'),
    announcementTime: localtime('21:35:00'),
    votesFor: 6123,
    votesAgainst: 2915,
    speechDuration: duration({minutes: 2, seconds: 43}),
    translatorUsed: true,
    memorableQuote: 'I will drink until next morning'
}]->(a);

MATCH
  (m:Movie:GeneratedByClaudeAI {title: 'March of the Penguins'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (m)-[:NOMINATED_FOR {
    category: 'Best Documentary Feature',
    year: 2006,
    ceremony: 78,
    isWinner: true,
    ceremonyDate: date('2006-03-05'),
    announcementTime: localtime('20:25:00'),
    votesFor: 3521,
    votesAgainst: 1485,
    significanceRating: 'Major for nature documentaries',
    audienceShareDuringAnnouncement: 0.32
}]->(a);

MATCH
  (p:Movie:GeneratedByClaudeAI {title: 'Parasite'}),
  (v:Ceremony:GeneratedByClaudeAI {name: 'Venice Film Festival'})
CREATE (p)-[:NOMINATED_FOR {
    category: 'Golden Lion',
    year: 2019,
    ceremony: 76,
    isWinner: false,
    ceremonyDate: date('2019-09-07'),
    announcementTime: localtime('20:30:00'),
    screeningDate: date('2019-09-03'),
    screeningTime: localtime('19:00:00'),
    screeningVenue: 'Sala Grande',
    audienceReaction: 'Standing ovation',
    reactionDuration: duration({minutes: 8, seconds: 45})
}]->(v);

// Preservation relationship
MATCH
  (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'}),
  (f:Organization:GeneratedByClaudeAI {name: 'National Film Preservation Board'})
CREATE (c)-[:PRESERVED_BY {
    year: 1989,
    preservationRound: 1,
    selectionCriteria: ['Cultural significance', 'Technical innovation', 'Artistic merit'],
    criteriaScore: [10, 10, 10],
    preservationDate: date('1989-12-14'),
    restoration: true,
    restorationDate: date('1998-11-25'),
    restorationCost: 850000,
    digitalFormat: '4K',
    preservationMedium: ['Film negative', 'Digital master']
}]->(f);

// Create additional node types and relationships

// Create educational institution using film for teaching
CREATE (FilmStudiesInstitute:Institution:GeneratedByClaudeAI {
    name: 'National Film Studies Institute',
    founded: date('1967-09-15'),
    headquartersLat: 34.0922,
    headquartersLong: -118.3731,
    studentCount: 1250,
    facultyCount: 85,
    courseCount: 145,
    filmArchiveSize: 25000,
    digitalArchiveSize: 15000,
    digitalArchiveUnit: 'TB',
    annualBudget: 45000000
})
WITH 1 as dummy
MATCH (i:Institution:GeneratedByClaudeAI {name: 'National Film Studies Institute'}),
      (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'})
CREATE (i)-[:TEACHES_WITH {
    yearAdded: 1968,
    coursesUsedIn: 28,
    primaryFocus: ['Cinematography technique', 'Narrative structure', 'Film history'],
    studentPapersCount: 12450,
    mostCommonAnalysisTopics: ['Deep focus', 'Rosebud symbolism', 'Narrative framework'],
    teachingHoursAnnually: 620,
    requiredForDegrees: ['BA Film Studies', 'MFA Directing', 'MFA Cinematography'],
    teachingValue: 9.8
}]->(c);

// Add camera technology for Citizen Kane
CREATE (MitchellBNCCamera:Equipment:GeneratedByClaudeAI {
    name: 'Mitchell BNC Camera',
    manufactured: date('1934-05-10'),
    manufacturerLat: 34.0922,
    manufacturerLong: -118.3731,
    weight: 52,
    weightUnit: 'kg',
    cost: 15000,
    purchaseYear: 1939,
    revolutionaryFeatures: ['Silent operation', 'Rack-over viewing', 'High-precision movement'],
    featureImpact: [9.2, 8.9, 9.5],
    technicalSpecifications: 'Silent operation with rack-over viewing system',
    historicalSignificance: 'Industry standard for Hollywood productions'
})
WITH 1 as dummy
MATCH (e:Equipment:GeneratedByClaudeAI {name: 'Mitchell BNC Camera'}),
      (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'})
CREATE (e)-[:USED_IN {
    operator: 'Gregg Toland',
    setupTime: duration({minutes: 45}),
    unitCount: 2,
    technicalInnovations: ['Low-angle mounting', 'Floor embedding'],
    innovationSuccess: [10, 9.5],
    maintenanceEvents: 8,
    operationalDays: 98,
    signatureShots: ['Low angle with ceiling', 'Deep focus wide shots', 'Tracking sequences'],
    techniqueInfluence: 9.8
}]->(c);

// Create special costume for Parasite
CREATE (ParasiteCostumes:Costume:GeneratedByClaudeAI {
    name: 'Parasite Family Wardrobes',
    designed: date('2018-03-15'),
    designer: 'Choi Se-yeon',
    costumePieces: 245,
    materialTypes: 15,
    colorPalette: ['Gray', 'Black', 'Muted green', 'Rich blue'],
    paletteMeaning: ['Poverty', 'Deception', 'Hope', 'Wealth'],
    constructionHours: 1850,
    costumeBudget: 120000,
    symbolismRating: 9.5
})
WITH 1 as dummy
MATCH (c:Costume:GeneratedByClaudeAI {name: 'Parasite Family Wardrobes'}),
      (p:Movie:GeneratedByClaudeAI {title: 'Parasite'})
CREATE (c)-[:FEATURED_IN {
    characterCount: 9,
    costumesPerCharacter: [12, 14, 16, 18, 8, 6, 5, 4, 3],
    characterClassIndication: ['Lower', 'Lower', 'Lower', 'Lower', 'Upper', 'Upper', 'Upper', 'Upper', 'Hidden'],
    symbolicElements: ['Stain-resistant fabric', 'Aspirational brands', 'Weathered textures', 'Color progression'],
    elementPurpose: ['Status marker', 'Desire indicator', 'History visual', 'Narrative arc'],
    designAwards: 3
}]->(p);

// Create extreme weather challenge for Penguins
CREATE (AntarcticConditions:EnvironmentalFactor:GeneratedByClaudeAI {
    name: 'Antarctic Winter Conditions',
    location: 'Dumont d\'Urville Station area',
    latitude: -66.6628,
    longitude: 140.0014,
    averageTemperature: -60,
    temperatureUnit: 'Celsius',
    windSpeedAverage: 80,
    windSpeedUnit: 'km/h',
    windSpeedMax: 200,
    daylight: 'Limited to none',
    precipitationAnnual: 250,
    precipitationUnit: 'mm',
    extremityIndex: 9.8
})
WITH 1 as dummy
MATCH (e:EnvironmentalFactor:GeneratedByClaudeAI {name: 'Antarctic Winter Conditions'}),
      (p:Movie:GeneratedByClaudeAI {title: 'March of the Penguins'})
CREATE (e)-[:IMPACTED {
    daysExperienced: 280,
    equipmentFailureRate: 0.35,
    humanEnduranceLimit: duration({hours: 4}),
    rotationalSchedule: 'Two weeks on, one week shelter',
    equipmentAdaptations: ['Thermal insulation', 'Battery protection', 'Anti-fog systems'],
    adaptationSuccessRates: [0.82, 0.76, 0.65],
    footageLostToCold: '32 hours',
    crewmedicalIncidents: 8,
    documentaryValueAdded: 9.7
}]->(p);

// Create cultural impact relationship
CREATE (FilmHistory:AcademicField:GeneratedByClaudeAI {
    name: 'Film History Studies',
    established: date('1915-03-10'),
    institutionsCount: 2850,
    scholarCount: 15400,
    peerReviewedJournals: 124,
    annualPublications: 3250,
    mostCitedTheories: ['Auteur theory', 'Montage theory', 'Apparatus theory'],
    theoriesDevelopmentYears: [1954, 1925, 1970],
    digitalArchives: 278
})
WITH 1 as dummy
MATCH (f:AcademicField:GeneratedByClaudeAI {name: 'Film History Studies'}),
      (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'})
CREATE (f)-[:INFLUENCED_BY {
    yearFirstStudied: 1942,
    academicPapersCount: 2850,
    textbookReferences: 98,
    percentageCoursesTeaching: 95,
    criticalTheoriesGenerated: ['Deep focus semiotics', 'Narrative fragmentation', 'Cinematic authorship'],
    theoryInfluence: [9.4, 9.6, 9.8],
    canonicalPosition: 1,
    canonicalSurveys: 12,
    surveyYears: [1952, 1962, 1972, 1982, 1992, 2002, 2012, 2022]
}]->(c);

// Create cultural movement relationship for Parasite
CREATE (NewKoreanCinema:CulturalMovement:GeneratedByClaudeAI {
    name: 'New Korean Cinema',
    established: date('1998-05-15'),
    influentialDirectors: 12,
    internationalFestivals: 35,
    majorAwards: 58,
    criticalReception: 'Revolutionary',
    geographicalSpread: 'Global',
    periodStart: date('1998-05-15'),
    periodPeak: date('2019-05-21'),
    academicStudies: 145
})
WITH 1 as dummy
MATCH (c:CulturalMovement:GeneratedByClaudeAI {name: 'New Korean Cinema'}),
      (p:Movie:GeneratedByClaudeAI {title: 'Parasite'})
CREATE (c)-[:CULMINATED_WITH {
    significanceRating: 9.9,
    globalImpact: 'Transformative',
    boxOfficeMultiplierEffect: 3.2,
    koreanFilmExportsIncrease: 0.45,
    subsequentDistributionDeals: 28,
    academicAnalyses: 85,
    filmSchoolAdoption: 'Immediate and widespread',
    newFilmmakersInspired: 'Thousands globally',
    culturalBarrierReduction: 'Significant',
    subtitleAcceptanceIncrease: 0.65
}]->(p);

// Create special effects company
CREATE (WetaDigital:TechCompany:GeneratedByClaudeAI {
    name: 'Weta Digital',
    founded: date('1993-05-22'),
    headquartersLat: -41.3053,
    headquartersLong: 174.8239,
    employeeCount: 1550,
    annualRevenue: 245000000,
    technologyPatents: 58,
    oscarsWon: 6,
    technicalAwards: 127,
    proprietarySoftware: 12,
    computingPower: 72000,
    computingUnit: 'CPU cores'
})
WITH 1 as dummy
MATCH (t:TechCompany:GeneratedByClaudeAI {name: 'Weta Digital'}),
      (p:Movie:GeneratedByClaudeAI {title: 'March of the Penguins'})
CREATE (t)-[:PROVIDED_SERVICES_FOR {
    year: 2004,
    serviceType: ['Digital restoration', 'Color correction', 'Digital stabilization'],
    teamSize: 12,
    workDuration: duration({months: 3}),
    contractValue: 850000,
    proprietaryTechniquesUsed: 3,
    footageProcessed: 85,
    footageUnit: 'Hours',
    transformationQuality: 9.5,
    temperatureExtremesVisualized: true,
    visualizationAccuracy: 'Scientific-grade'
}]->(p);

// Create theme park attraction
CREATE (CitizenKaneExhibit:Attraction:GeneratedByClaudeAI {
    name: 'The Art of Citizen Kane: Interactive Exhibit',
    opened: date('2008-05-15'),
    locationLat: 34.1381,
    locationLong: -118.3534,
    visitorCapacity: 500,
    visitorDuration: duration({minutes: 45}),
    annualVisitors: 250000,
    exhibitSize: 15000,
    sizeUnit: 'Square feet',
    developmentCost: 12000000,
    interactiveElements: 28,
    historicalArtifacts: 125
})
WITH 1 as dummy
MATCH (a:Attraction:GeneratedByClaudeAI {name: 'The Art of Citizen Kane: Interactive Exhibit'}),
      (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'})
CREATE (a)-[:BASED_ON {
    filmElementsFeatured: ['Cinematography', 'Set design', 'Narrative structure', 'Sound design'],
    educationalFocus: 0.8,
    entertainmentFocus: 0.2,
    audienceRating: 9.2,
    filmHistoryContextualization: 'Comprehensive',
    originalPropsCurated: 15,
    reproductionProps: 85,
    filmingTechniqueDemonstrations: 12,
    rosebudSymbolismExhibits: 5,
    culturalImpactMetrics: ['Industry influence', 'Artistic recognition', 'Technical innovation']
}]->(c);

// Create merchandising relationship
CREATE (PenguinPlush:Merchandise:GeneratedByClaudeAI {
    name: 'Emperor Penguin Family Plush Collection',
    released: date('2005-06-15'),
    manufacturer: 'National Geographic Products',
    manufacturerLocationLat: 38.9053,
    manufacturerLocationLong: -77.0332,
    retailPrice: 29.99,
    priceCurrency: 'USD',
    productionRun: 500000,
    conservationContribution: 3.00,
    contributionPercentage: 0.10,
    educationalMaterials: true,
    ageRange: '3+'
})
WITH 1 as dummy
MATCH (m:Merchandise:GeneratedByClaudeAI {name: 'Emperor Penguin Family Plush Collection'}),
      (p:Movie:GeneratedByClaudeAI {title: 'March of the Penguins'})
CREATE (m)-[:DERIVED_FROM {
    licensingDeal: date('2005-03-12'),
    unitsSold: 435000,
    geographicalDistribution: ['North America', 'Europe', 'Asia', 'Australia'],
    salesDistribution: [0.65, 0.20, 0.10, 0.05],
    retailersCarrying: 7850,
    conservationFundsRaised: 1305000,
    educationalImpact: 'Significant - classroom adoption',
    brandRecognition: 0.85,
    merchandisingLongevity: 'Still in production - limited quantities',
    sequelMerchandisingEffect: 'Reissued for Penguin 2'
}]->(p);

// Create educational program
CREATE (ParasiteStudyProgram:EducationalProgram:GeneratedByClaudeAI {
    name: 'Parasite: Film & Society Curriculum',
    developed: date('2020-04-15'),
    institutionsAdopting: 1230,
    targetEducationLevels: ['University', 'High School Advanced'],
    materialFormats: ['Digital', 'Print', 'Video supplements'],
    languagesAvailable: 12,
    courseDuration: duration({weeks: 6}),
    totalLessonHours: 45,
    scholarlyEndorsements: 35,
    educatorRating: 9.4
})
WITH 1 as dummy
MATCH (e:EducationalProgram:GeneratedByClaudeAI {name: 'Parasite: Film & Society Curriculum'}),
      (p:Movie:GeneratedByClaudeAI {title: 'Parasite'})
CREATE (e)-[:ANALYZES {
    focusAreas: ['Class structure', 'Visual symbolism', 'Narrative techniques', 'Cultural context', 'Globalization'],
    focusDistribution: [0.25, 0.20, 0.20, 0.15, 0.20],
    analyticalApproaches: ['Sociological', 'Cinematic', 'Economic', 'Cultural'],
    studentFeedbackScore: 9.2,
    criticalThinkingDevelopment: 'Very High',
    culturalComprehensionExpansion: 'Significant',
    crossCulturalDialoguePromotion: 'Extensive',
    filmmakingTechniquesExamined: 45,
    globalAdoption: 'Growing rapidly',
    academicPaperGeneration: 185
}]->(p);

// Create 4K restoration project
CREATE (CitizenKaneRestoration:DigitalProject:GeneratedByClaudeAI {
    name: 'Citizen Kane 4K Restoration',
    started: date('2010-02-15'),
    completed: date('2011-09-22'),
    teamSize: 22,
    originalNegativeUsed: true,
    resolutionOutput: '4096x3112',
    colorDepth: '16-bit',
    storageSizeRaw: 175,
    storageSizeUnit: 'TB',
    finalMasterSize: 12,
    finalMasterUnit: 'TB',
    budget: 1250000
})
WITH 1 as dummy
MATCH (d:DigitalProject:GeneratedByClaudeAI {name: 'Citizen Kane 4K Restoration'}),
      (c:Movie:GeneratedByClaudeAI {title: 'Citizen Kane'})
CREATE (d)-[:PRESERVED {
    frameCorrectionCount: 486500,
    frameTotalCount: 172584,
    originalDamagePercentage: 0.12,
    restorationFidelity: 0.985,
    audioChannelsPreserved: 2,
    audioSamplingRate: 96,
    audioSamplingUnit: 'kHz',
    primaryRestorationChallenges: ['Nitrate decomposition', 'Scratches', 'Stabilization', 'Contrast preservation'],
    challengeComplexity: [9.2, 8.5, 7.8, 9.5],
    technologiesUsed: ['AI frame interpolation', 'Manual restoration', 'Wetgate scanning', 'HDR grading'],
    historicalConsultants: 5,
    academicValidation: 'Peer-reviewed & certified authentic',
    preservationStandard: 'Library of Congress Archival'
}]->(c);

// Create more contemporary movies
CREATE (Dune:Movie:GeneratedByClaudeAI {
    title: 'Dune',
    released: 2021,
    tagline: 'Beyond fear, destiny awaits',
    budget: 165000000,
    revenue: 401800000,
    runtime_minutes: 155,
    rating_avg: 8.1,
    releaseDate: date('2021-10-22'),
    digitalRelease: datetime('2021-12-03T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Dune'})
SET m.ratings = [8.2, 8.0, 8.1, 8.1]
SET m.genres = ['sci-fi', 'adventure', 'drama']
SET m.certifications = ['PG-13', '12A']
SET m.filmingLocationLat = [31.1667, 52.4262, 40.7128]
SET m.filmingLocationLong = [-4.2333, 13.8536, -74.0060]
SET m.boxOfficeNA = 108327830
SET m.boxOfficeEurope = 142500000
SET m.boxOfficeAsia = 82400000
SET m.boxOfficeOther = 68572170;

CREATE (EverythingEverywhere:Movie:GeneratedByClaudeAI {
    title: 'Everything Everywhere All at Once',
    released: 2022,
    tagline: 'The universe is so much bigger than you realize',
    budget: 25000000,
    revenue: 140200000,
    runtime_minutes: 139,
    rating_avg: 8.0,
    releaseDate: date('2022-03-25'),
    digitalRelease: datetime('2022-06-07T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Everything Everywhere All at Once'})
SET m.ratings = [8.1, 7.9, 8.0, 8.0]
SET m.genres = ['comedy', 'action', 'sci-fi', 'drama']
SET m.certifications = ['R', '15']
SET m.filmingLocationLat = [34.0522, 33.7490, 40.7128]
SET m.filmingLocationLong = [-118.2437, -84.3880, -74.0060]
SET m.boxOfficeNA = 77188084
SET m.boxOfficeEurope = 27600000
SET m.boxOfficeAsia = 25400000
SET m.boxOfficeOther = 10011916;

CREATE (Oppenheimer:Movie:GeneratedByClaudeAI {
    title: 'Oppenheimer',
    released: 2023,
    tagline: 'The world forever changes',
    budget: 100000000,
    revenue: 976156348,
    runtime_minutes: 180,
    rating_avg: 8.4,
    releaseDate: date('2023-07-21'),
    digitalRelease: datetime('2023-11-21T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Oppenheimer'})
SET m.ratings = [8.5, 8.3, 8.4, 8.4]
SET m.genres = ['biography', 'drama', 'history']
SET m.certifications = ['R', '15']
SET m.filmingLocationLat = [34.0522, 40.7128, 41.8781]
SET m.filmingLocationLong = [-118.2437, -74.0060, -87.6298]
SET m.boxOfficeNA = 326900000
SET m.boxOfficeEurope = 298700000
SET m.boxOfficeAsia = 223500000
SET m.boxOfficeOther = 127056348;

// Create more people (directors, actors)
CREATE (TimotheeC:Person:GeneratedByClaudeAI {
    name: 'Timothée Chalamet',
    born: 1995,
    birthdate: date('1995-12-27'),
    nationality: 'American-French',
    oscarNominations: 1,
    isActive: true,
    firstFilm: datetime('2014-05-17T00:00:00Z'),
    heightInMeters: 1.78,
    netWorth: 30000000,
    methodActingScore: 8.5
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Timothée Chalamet'})
SET p.languages = ['English', 'French']
SET p.filmography_titles = ['Call Me by Your Name', 'Dune', 'Little Women']
SET p.filmography_years = [2017, 2021, 2019]
SET p.filmography_roles = ['Elio Perlman', 'Paul Atreides', 'Theodore Laurence'];

CREATE (MichelleY:Person:GeneratedByClaudeAI {
    name: 'Michelle Yeoh',
    born: 1962,
    birthdate: date('1962-08-06'),
    nationality: 'Malaysian',
    oscarWins: 1,
    oscarNominations: 1,
    isActive: true,
    firstFilm: datetime('1984-11-16T00:00:00Z'),
    heightInMeters: 1.63,
    netWorth: 40000000,
    martialArtsTraining: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Michelle Yeoh'})
SET p.languages = ['English', 'Malay', 'Cantonese', 'Mandarin']
SET p.filmography_titles = ['Everything Everywhere All at Once', 'Crouching Tiger, Hidden Dragon', 'Crazy Rich Asians']
SET p.filmography_years = [2022, 2000, 2018]
SET p.filmography_roles = ['Evelyn Wang', 'Yu Shu Lien', 'Eleanor Young'];

CREATE (CillianM:Person:GeneratedByClaudeAI {
    name: 'Cillian Murphy',
    born: 1976,
    birthdate: date('1976-05-25'),
    nationality: 'Irish',
    oscarWins: 1,
    oscarNominations: 1,
    isActive: true,
    firstFilm: datetime('1998-09-25T00:00:00Z'),
    heightInMeters: 1.75,
    netWorth: 20000000,
    methodActingScore: 9.2
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Cillian Murphy'})
SET p.languages = ['English', 'Irish']
SET p.filmography_titles = ['Oppenheimer', 'Inception', 'The Dark Knight']
SET p.filmography_years = [2023, 2010, 2008]
SET p.filmography_roles = ['J. Robert Oppenheimer', 'Robert Fischer', 'Dr. Jonathan Crane'];

CREATE (DanKwan:Person:GeneratedByClaudeAI {
    name: 'Daniel Kwan',
    born: 1988,
    birthdate: date('1988-02-10'),
    nationality: 'American',
    oscarWins: 3,
    oscarNominations: 3,
    isActive: true,
    firstFilm: datetime('2016-06-24T00:00:00Z'),
    heightInMeters: 1.75,
    netWorth: 5000000,
    visualStyle: 'Eclectic and vibrant'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Daniel Kwan'})
SET p.languages = ['English', 'Mandarin']
SET p.filmography_titles = ['Everything Everywhere All at Once', 'Swiss Army Man']
SET p.filmography_years = [2022, 2016]
SET p.collaborations = ['Daniel Scheinert'];

CREATE (A24Studios:Studio:GeneratedByClaudeAI {
    name: 'A24 Studios',
    founded: date('2012-08-20'),
    headquartersLat: 40.7405,
    headquartersLong: -74.0022,
    yearlyRevenue2020: 325000000,
    yearlyRevenue2021: 380000000,
    yearlyRevenue2022: 450000000,
    digitalStreamingDate: datetime('2019-07-10T00:00:00Z'),
    isPublic: false,
    marketShare: 0.05
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'A24 Studios'})
SET s.subsidiaries = ['A24 Films', 'A24 Television']
SET s.distributionMarkets = ['North America', 'Europe', 'Asia', 'Australia']
SET s.studioLotsLat = [40.7405]
SET s.studioLotsLong = [-74.0022];

CREATE (UniversalPictures:Studio:GeneratedByClaudeAI {
    name: 'Universal Pictures',
    founded: date('1912-04-30'),
    headquartersLat: 34.1381,
    headquartersLong: -118.3534,
    yearlyRevenue2020: 3200000000,
    yearlyRevenue2021: 4100000000,
    yearlyRevenue2022: 4800000000,
    digitalStreamingDate: datetime('2018-01-15T00:00:00Z'),
    isPublic: true,
    marketShare: 0.12
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Universal Pictures'})
SET s.subsidiaries = ['Focus Features', 'DreamWorks Animation', 'Working Title Films']
SET s.distributionMarkets = ['Global']
SET s.studioLotsLat = [34.1381, 41.9028, 51.5074]
SET s.studioLotsLong = [-118.3534, 12.4964, -0.1278];

// Create production events
CREATE (DuneProduction:Production:GeneratedByClaudeAI {
    name: 'Dune Principal Photography',
    startDate: date('2019-03-18'),
    endDate: date('2019-07-26'),
    durationMonths: 4,
    durationDays: 8,
    startTime: localtime('06:30:00'),
    isCompleted: true,
    budgetPersonnel: 50000000,
    budgetEquipment: 20000000,
    budgetLocations: 25000000,
    budgetVFX: 55000000,
    budgetOther: 15000000,
    weatherGood: 75,
    weatherAcceptable: 20,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Dune Principal Photography'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['04:00:00', '06:00:00', '06:30:00', '18:30:00']
SET p.scheduleDurations = [2, 0.5, 12, 1.5];

CREATE (EEAAOProduction:Production:GeneratedByClaudeAI {
    name: 'Everything Everywhere All at Once Production',
    startDate: date('2020-01-15'),
    endDate: date('2020-03-25'),
    durationMonths: 2,
    durationDays: 10,
    startTime: localtime('07:00:00'),
    isCompleted: true,
    budgetPersonnel: 8000000,
    budgetEquipment: 3000000,
    budgetLocations: 2000000,
    budgetVFX: 9000000,
    budgetOther: 3000000,
    weatherGood: 85,
    weatherAcceptable: 10,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Everything Everywhere All at Once Production'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['05:00:00', '06:30:00', '07:00:00', '19:00:00']
SET p.scheduleDurations = [1.5, 0.5, 12, 1];

CREATE (OppenheimerProduction:Production:GeneratedByClaudeAI {
    name: 'Oppenheimer Principal Photography',
    startDate: date('2022-02-22'),
    endDate: date('2022-05-18'),
    durationMonths: 3,
    durationDays: 24,
    startTime: localtime('06:00:00'),
    isCompleted: true,
    budgetPersonnel: 35000000,
    budgetEquipment: 15000000,
    budgetLocations: 20000000,
    budgetVFX: 20000000,
    budgetOther: 10000000,
    weatherGood: 80,
    weatherAcceptable: 15,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Oppenheimer Principal Photography'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['03:30:00', '05:30:00', '06:00:00', '18:30:00']
SET p.scheduleDurations = [2, 0.5, 12.5, 1];

// Add reviews
CREATE (DuneReview:Review:GeneratedByClaudeAI {
    title: 'A Masterful Sci-Fi Epic',
    stars: 4.8,
    date: date('2021-10-25'),
    time: time('15:30:42+01:00'),
    isVerified: true,
    aspectDirection: 4.9,
    aspectActing: 4.7,
    aspectVisuals: 5.0,
    aspectMusic: 5.0,
    aspectPlot: 4.7,
    reviewText: 'Denis Villeneuve\'s Dune is a breathtaking achievement that brings Frank Herbert\'s complex sci-fi novel to life with stunning visuals, a powerful score, and excellent performances. The film balances world-building with character development masterfully.',
    upvotes: 9582
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'A Masterful Sci-Fi Epic'})
SET r.commentTimestamps = [datetime('2021-10-25T16:45:22+01:00'), datetime('2021-10-26T09:15:34+01:00'), datetime('2021-10-27T18:22:51+01:00')]
SET r.keywords = ['sci-fi', 'adaptation', 'visual-spectacle', 'world-building']
SET r.readerLocationsLat = [40.7128, 51.5074, 48.8566]
SET r.readerLocationsLong = [-74.0060, -0.1278, 2.3522];

CREATE (EEAAOReview:Review:GeneratedByClaudeAI {
    title: 'A Mind-Bending Multiverse Masterpiece',
    stars: 4.9,
    date: date('2022-04-10'),
    time: time('19:22:15-04:00'),
    isVerified: true,
    aspectDirection: 5.0,
    aspectActing: 5.0,
    aspectVisuals: 4.8,
    aspectMusic: 4.7,
    aspectPlot: 4.9,
    reviewText: 'Everything Everywhere All at Once is a genre-defying triumph that blends action, comedy, sci-fi, and heartfelt family drama. Michelle Yeoh delivers a career-defining performance in this multiverse exploration that somehow manages to be both wildly creative and emotionally grounded.',
    upvotes: 12854
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'A Mind-Bending Multiverse Masterpiece'})
SET r.commentTimestamps = [datetime('2022-04-10T20:35:42-04:00'), datetime('2022-04-11T08:22:19-04:00'), datetime('2022-04-12T14:15:37-04:00')]
SET r.keywords = ['multiverse', 'existential', 'action-comedy', 'immigrant-experience']
SET r.readerLocationsLat = [34.0522, 40.7128, 37.7749]
SET r.readerLocationsLong = [-118.2437, -74.0060, -122.4194];

CREATE (OppenheimerReview:Review:GeneratedByClaudeAI {
    title: 'Historical Filmmaking at its Finest',
    stars: 5.0,
    date: date('2023-07-25'),
    time: time('14:45:30-04:00'),
    isVerified: true,
    aspectDirection: 5.0,
    aspectActing: 5.0,
    aspectVisuals: 4.9,
    aspectMusic: 4.8,
    aspectPlot: 4.9,
    reviewText: 'Christopher Nolan\'s Oppenheimer is a towering achievement in biographical filmmaking. Cillian Murphy delivers a haunting, complex performance as the father of the atomic bomb, while the film\'s narrative structure brilliantly juxtaposes his scientific triumphs with their moral consequences.',
    upvotes: 14382
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'Historical Filmmaking at its Finest'})
SET r.commentTimestamps = [datetime('2023-07-25T16:22:18-04:00'), datetime('2023-07-26T09:43:55-04:00'), datetime('2023-07-27T20:15:42-04:00')]
SET r.keywords = ['biopic', 'atomic-age', 'historical-drama', 'moral-conflict']
SET r.readerLocationsLat = [40.7128, 34.0522, 51.5074]
SET r.readerLocationsLong = [-74.0060, -118.2437, -0.1278];

// Create relationships between nodes
MATCH 
  (d:Person:GeneratedByClaudeAI {name: 'Denis Villeneuve'}),
  (du:Movie:GeneratedByClaudeAI {title: 'Dune'})
CREATE (d)-[:DIRECTED {
    year: 2021,
    daysOnSet: 130,
    satisfaction: 4.9,
    awardNominations: 10,
    completionDate: date('2020-07-15'),
    premiereEvent: datetime('2021-09-03T19:30:00+02:00'),
    durationMonths: 4,
    isFirstCollaboration: false
}]->(du);

MATCH 
  (dk:Person:GeneratedByClaudeAI {name: 'Daniel Kwan'}),
  (e:Movie:GeneratedByClaudeAI {title: 'Everything Everywhere All at Once'})
CREATE (dk)-[:DIRECTED {
    year: 2022,
    daysOnSet: 70,
    coDirector: 'Daniel Scheinert',
    satisfaction: 4.9,
    awardNominations: 11,
    awardWins: 7,
    completionDate: date('2020-07-30'),
    premiereEvent: datetime('2022-03-11T18:30:00-06:00'),
    durationMonths: 2,
    isFirstCollaboration: false
}]->(e);

MATCH 
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (o:Movie:GeneratedByClaudeAI {title: 'Oppenheimer'})
CREATE (c)-[:DIRECTED {
    year: 2023,
    daysOnSet: 114,
    satisfaction: 4.9,
    awardNominations: 13,
    awardWins: 7,
    completionDate: date('2023-03-15'),
    premiereEvent: datetime('2023-07-13T19:00:00+01:00'),
    durationMonths: 3,
    isFirstCollaboration: false
}]->(o);

// Actor to Movie relationships
MATCH
  (t:Person:GeneratedByClaudeAI {name: 'Timothée Chalamet'}),
  (d:Movie:GeneratedByClaudeAI {title: 'Dune'})
CREATE (t)-[:ACTED_IN {
    roles: ['Paul Atreides'],
    salary: 2000000,
    screenTimeMinutes: 125,
    startDate: date('2019-03-18'),
    endDate: date('2019-07-26'),
    scheduleConflicts: false,
    criticScore: 95,
    audienceScore: 92,
    awardNominations: 5
}]->(d);

MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Michelle Yeoh'}),
  (e:Movie:GeneratedByClaudeAI {title: 'Everything Everywhere All at Once'})
CREATE (m)-[:ACTED_IN {
    roles: ['Evelyn Wang'],
    salary: 1000000,
    screenTimeMinutes: 120,
    startDate: date('2020-01-15'),
    endDate: date('2020-03-25'),
    scheduleConflicts: false,
    criticScore: 97,
    audienceScore: 95,
    awardNominations: 8,
    awardWins: 6
}]->(e);

MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Cillian Murphy'}),
  (o:Movie:GeneratedByClaudeAI {title: 'Oppenheimer'})
CREATE (c)-[:ACTED_IN {
    roles: ['J. Robert Oppenheimer'],
    salary: 5000000,
    screenTimeMinutes: 160,
    startDate: date('2022-02-22'),
    endDate: date('2022-05-18'),
    scheduleConflicts: false,
    criticScore: 98,
    audienceScore: 95,
    awardNominations: 7,
    awardWins: 5
}]->(o);

// Studio relationships
MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (d:Movie:GeneratedByClaudeAI {title: 'Dune'})
CREATE (w)-[:PRODUCED {
    investment: 165000000,
    return: 401800000,
    roi: 2.43,
    contractSigned: date('2018-07-15'),
    studioShare: 0.65,
    directorShare: 0.15,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 140000000,
    isProfitable: true,
    marketingStart: datetime('2021-02-15T00:00:00Z')
}]->(d);

MATCH
  (a:Studio:GeneratedByClaudeAI {name: 'A24 Studios'}),
  (e:Movie:GeneratedByClaudeAI {title: 'Everything Everywhere All at Once'})
CREATE (a)-[:PRODUCED {
    investment: 25000000,
    return: 140200000,
    roi: 5.61,
    contractSigned: date('2019-03-22'),
    studioShare: 0.6,
    directorShare: 0.2,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 15000000,
    isProfitable: true,
    marketingStart: datetime('2022-01-15T00:00:00Z')
}]->(e);

MATCH
  (u:Studio:GeneratedByClaudeAI {name: 'Universal Pictures'}),
  (o:Movie:GeneratedByClaudeAI {title: 'Oppenheimer'})
CREATE (u)-[:PRODUCED {
    investment: 100000000,
    return: 976156348,
    roi: 9.76,
    contractSigned: date('2021-05-10'),
    studioShare: 0.6,
    directorShare: 0.2,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 150000000,
    isProfitable: true,
    marketingStart: datetime('2023-01-15T00:00:00Z')
}]->(o);

// Studio to filming relationship
MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (p:Production:GeneratedByClaudeAI {name: 'Dune Principal Photography'})
CREATE (w)-[:FINANCED {
    contractDate: date('2018-07-15'),
    amount: 165000000,
    isFullyPaid: true,
    transferTime1: datetime('2018-12-15T00:00:00Z'),
    transferTime2: datetime('2019-02-28T00:00:00Z'),
    transferTime3: datetime('2019-05-15T00:00:00Z'),
    paymentDate1: date('2018-12-15'),
    paymentAmount1: 50000000,
    paymentDate2: date('2019-02-28'),
    paymentAmount2: 65000000,
    paymentDate3: date('2019-05-15'),
    paymentAmount3: 50000000
}]->(p);

MATCH
  (a:Studio:GeneratedByClaudeAI {name: 'A24 Studios'}),
  (p:Production:GeneratedByClaudeAI {name: 'Everything Everywhere All at Once Production'})
CREATE (a)-[:FINANCED {
    contractDate: date('2019-03-22'),
    amount: 25000000,
    isFullyPaid: true,
    transferTime1: datetime('2019-09-15T00:00:00Z'),
    transferTime2: datetime('2019-12-15T00:00:00Z'),
    paymentDate1: date('2019-09-15'),
    paymentAmount1: 15000000,
    paymentDate2: date('2019-12-15'),
    paymentAmount2: 10000000
}]->(p);

MATCH
  (u:Studio:GeneratedByClaudeAI {name: 'Universal Pictures'}),
  (p:Production:GeneratedByClaudeAI {name: 'Oppenheimer Principal Photography'})
CREATE (u)-[:FINANCED {
    contractDate: date('2021-05-10'),
    amount: 100000000,
    isFullyPaid: true,
    transferTime1: datetime('2021-09-15T00:00:00Z'),
    transferTime2: datetime('2021-12-20T00:00:00Z'),
    transferTime3: datetime('2022-02-10T00:00:00Z'),
    paymentDate1: date('2021-09-15'),
    paymentAmount1: 30000000,
    paymentDate2: date('2021-12-20'),
    paymentAmount2: 40000000,
    paymentDate3: date('2022-02-10'),
    paymentAmount3: 30000000
}]->(p);

// Filming to movie relationship
MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Dune Principal Photography'}),
  (d:Movie:GeneratedByClaudeAI {title: 'Dune'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 4,
    durationDays: 8,
    locationCount: 8,
    dailyAverageCost: 560000,
    scheduleAdherence: 0.95,
    weatherDelaysDays: 5,
    originalScheduledEnd: date('2019-07-20')
}]->(d);

MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Everything Everywhere All at Once Production'}),
  (e:Movie:GeneratedByClaudeAI {title: 'Everything Everywhere All at Once'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 2,
    durationDays: 10,
    locationCount: 12,
    dailyAverageCost: 150000,
    scheduleAdherence: 0.97,
    weatherDelaysDays: 2,
    originalScheduledEnd: date('2020-03-20')
}]->(e);

MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Oppenheimer Principal Photography'}),
  (o:Movie:GeneratedByClaudeAI {title: 'Oppenheimer'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 3,
    durationDays: 24,
    locationCount: 9,
    dailyAverageCost: 350000,
    scheduleAdherence: 0.98,
    weatherDelaysDays: 3,
    originalScheduledEnd: date('2022-05-15')
}]->(o);

// Review relationships
MATCH
  (j:Person {name: 'Jessica Thompson'}), // Original person from the graph
  (r:Review:GeneratedByClaudeAI {title: 'A Masterful Sci-Fi Epic'})
CREATE (j)-[:WROTE {
    date: date('2021-10-25'),
    timeSpentMinutes: 65,
    wordCount: 728,
    isVerified: true,
    submissionTime: time('15:30:42+01:00')
}]->(r);

MATCH
  (a:Person {name: 'Angela Scope'}), // Original person from the graph
  (r:Review:GeneratedByClaudeAI {title: 'A Mind-Bending Multiverse Masterpiece'})
CREATE (a)-[:WROTE {
    date: date('2022-04-10'),
    timeSpentMinutes: 70,
    wordCount: 785,
    isVerified: true,
    submissionTime: time('19:22:15-04:00')
}]->(r);

MATCH
  (p:Person {name: 'Paul Blythe'}), // Original person from the graph
  (r:Review:GeneratedByClaudeAI {title: 'Historical Filmmaking at its Finest'})
CREATE (p)-[:WROTE {
    date: date('2023-07-25'),
    timeSpentMinutes: 75,
    wordCount: 812,
    isVerified: true,
    submissionTime: time('14:45:30-04:00')
}]->(r);

MATCH
  (r:Review:GeneratedByClaudeAI {title: 'A Masterful Sci-Fi Epic'}),
  (d:Movie:GeneratedByClaudeAI {title: 'Dune'})
CREATE (r)-[:FOR_MOVIE {
    isPublished: true,
    views: 184532,
    shares: 8642,
    comments: 3156,
    featuredDurationDays: 21,
    publicationDateTime: datetime('2021-10-25T16:30:00+01:00')
}]->(d);

MATCH
  (r:Review:GeneratedByClaudeAI {title: 'A Mind-Bending Multiverse Masterpiece'}),
  (e:Movie:GeneratedByClaudeAI {title: 'Everything Everywhere All at Once'})
CREATE (r)-[:FOR_MOVIE {
    isPublished: true,
    views: 215689,
    shares: 12548,
    comments: 4852,
    featuredDurationDays: 28,
    publicationDateTime: datetime('2022-04-10T20:15:00-04:00')
}]->(e);

MATCH
  (r:Review:GeneratedByClaudeAI {title: 'Historical Filmmaking at its Finest'}),
  (o:Movie:GeneratedByClaudeAI {title: 'Oppenheimer'})
CREATE (r)-[:FOR_MOVIE {
    isPublished: true,
    views: 245832,
    shares: 15462,
    comments: 5238,
    featuredDurationDays: 30,
    publicationDateTime: datetime('2023-07-25T16:00:00-04:00')
}]->(o);

// Award relationships
MATCH
  (d:Movie:GeneratedByClaudeAI {title: 'Dune'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (d)-[:NOMINATED_FOR {
    category: 'Best Cinematography',
    year: 2022,
    ceremony: 94,
    isWinner: true,
    ceremonyDate: date('2022-03-27'),
    announcementTime: localtime('20:15:00'),
    votesFor: 5821,
    votesAgainst: 2154
}]->(a);

MATCH
  (e:Movie:GeneratedByClaudeAI {title: 'Everything Everywhere All at Once'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (e)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 2023,
    ceremony: 95,
    isWinner: true,
    ceremonyDate: date('2023-03-12'),
    announcementTime: localtime('21:45:00'),
    votesFor: 6534,
    votesAgainst: 2154
}]->(a);

MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Michelle Yeoh'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (m)-[:NOMINATED_FOR {
    category: 'Best Actress',
    year: 2023,
    ceremony: 95,
    isWinner: true,
    ceremonyDate: date('2023-03-12'),
    announcementTime: localtime('21:15:00'),
    votesFor: 6254,
    votesAgainst: 2435,
    speechDuration: duration({minutes: 3, seconds: 12})
}]->(a);

MATCH
  (o:Movie:GeneratedByClaudeAI {title: 'Oppenheimer'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (o)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 2024,
    ceremony: 96,
    isWinner: true,
    ceremonyDate: date('2024-03-10'),
    announcementTime: localtime('21:45:00'),
    votesFor: 6832,
    votesAgainst: 1985
}]->(a);

MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Cillian Murphy'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (c)-[:NOMINATED_FOR {
    category: 'Best Actor',
    year: 2024,
    ceremony: 96,
    isWinner: true,
    ceremonyDate: date('2024-03-10'),
    announcementTime: localtime('21:15:00'),
    votesFor: 6754,
    votesAgainst: 2105,
    speechDuration: duration({minutes: 2, seconds: 45})
}]->(a);

// Professional relationships between people
MATCH
  (t:Person:GeneratedByClaudeAI {name: 'Timothée Chalamet'}),
  (d:Person:GeneratedByClaudeAI {name: 'Denis Villeneuve'})
CREATE (t)-[:WORKED_WITH {
    projects: 1,
    firstProject: 'Dune',
    firstYear: 2021,
    chemistry: 4.8,
    interviews: 25,
    relationship: 'Actor-Director',
    nextProjectPlanned: date('2024-11-15')
}]->(d);

MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Michelle Yeoh'}),
  (dk:Person:GeneratedByClaudeAI {name: 'Daniel Kwan'})
CREATE (m)-[:WORKED_WITH {
    projects: 1,
    firstProject: 'Everything Everywhere All at Once',
    firstYear: 2022,
    chemistry: 4.9,
    interviews: 32,
    relationship: 'Actor-Director',
    awards: ['Academy Award', 'Golden Globe', 'SAG Award']
}]->(dk);

MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Cillian Murphy'}),
  (cn:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'})
CREATE (c)-[:WORKED_WITH {
    projects: 6,
    firstProject: 'Batman Begins',
    firstYear: 2005,
    chemistry: 4.9,
    interviews: 45,
    relationship: 'Actor-Director',
    awards: ['Academy Award']
}]->(cn);

// Create soundtracks
CREATE (DuneSoundtrack:Soundtrack:GeneratedByClaudeAI {
    title: 'Dune (Original Motion Picture Soundtrack)',
    composer: 'Hans Zimmer',
    released: date('2021-09-17'),
    duration: duration({minutes: 97, seconds: 38}),
    trackCount: 22,
    recordingStudio: 'Remote (COVID-19)',
    recordingStudioLat: 51.5074,
    recordingStudioLong: -0.1278,
    peakChartPosition: 24,
    salesUnits: 120000,
    streamingCount: 180000000
})
WITH 1 as dummy
MATCH (d:Movie:GeneratedByClaudeAI {title: 'Dune'}),
      (s:Soundtrack:GeneratedByClaudeAI {title: 'Dune (Original Motion Picture Soundtrack)'})
CREATE (s)-[:COMPOSED_FOR {
    contractDate: date('2019-12-15'),
    completion: date('2021-06-20'),
    nominatedAwards: ['Academy Award', 'BAFTA', 'Golden Globe'],
    wonAwards: ['Academy Award', 'Golden Globe'],
    spotifyStreams: 250000000,
    youtubeViews: 65000000
}]->(d);

CREATE (OppenheimerSoundtrack:Soundtrack:GeneratedByClaudeAI {
    title: 'Oppenheimer (Original Motion Picture Soundtrack)',
    composer: 'Ludwig Göransson',
    released: date('2023-07-21'),
    duration: duration({minutes: 72, seconds: 15}),
    trackCount: 19,
    recordingStudio: 'AIR Studios, London',
    recordingStudioLat: 51.5454,
    recordingStudioLong: -0.1755,
    peakChartPosition: 18,
    salesUnits: 85000,
    streamingCount: 145000000
})
WITH 1 as dummy
MATCH (o:Movie:GeneratedByClaudeAI {title: 'Oppenheimer'}),
      (s:Soundtrack:GeneratedByClaudeAI {title: 'Oppenheimer (Original Motion Picture Soundtrack)'})
CREATE (s)-[:COMPOSED_FOR {
    contractDate: date('2022-01-15'),
    completion: date('2023-05-20'),
    nominatedAwards: ['Academy Award', 'BAFTA', 'Golden Globe'],
    wonAwards: ['Academy Award'],
    spotifyStreams: 175000000,
    youtubeViews: 42000000
}]->(o);

// Create filming location
CREATE (MoroccoLocation:FilmingLocation:GeneratedByClaudeAI {
    name: 'Wadi Rum Desert',
    country: 'Jordan',
    region: 'Southern Jordan',
    latitude: 29.5833,
    longitude: 35.4167,
    elevation: 1600,
    elevationUnit: 'm',
    climate: 'Desert',
    permitCost: 2500000,
    permitCurrency: 'USD',
    firstUsed: date('2019-05-15'),
    lastUsed: date('2019-06-28')
})
WITH 1 as dummy
MATCH (d:Movie:GeneratedByClaudeAI {title: 'Dune'}),
      (l:FilmingLocation:GeneratedByClaudeAI {name: 'Wadi Rum Desert'})
CREATE (d)-[:FILMED_AT {
    startDate: date('2019-05-15'),
    endDate: date('2019-06-28'),
    sceneCount: 32,
    totalDays: 45,
    weatherDelayDays: 6,
    crewSize: 350,
    logisticsCost: 3500000,
    accommodationCost: 1800000,
    characterPresent: ['Paul Atreides', 'Lady Jessica', 'Fremen']
}]->(l);

// Create prop for Oppenheimer
CREATE (TrinityDevice:Prop:GeneratedByClaudeAI {
    name: 'Trinity Test Device Replica',
    movie: 'Oppenheimer',
    material: 'Mixed materials, electronics',
    weight: 350,
    weightUnit: 'kg',
    createdDate: date('2022-01-10'),
    screenTime: duration({minutes: 8, seconds: 45}),
    isIconic: true,
    constructionCost: 250000,
    copiesMade: 3
})
WITH 1 as dummy
MATCH (o:Movie:GeneratedByClaudeAI {title: 'Oppenheimer'}),
      (p:Prop:GeneratedByClaudeAI {name: 'Trinity Test Device Replica'})
CREATE (p)-[:USED_IN {
    scenes: ['Trinity Test', 'Laboratory'],
    sceneCount: 5,
    firstAppearance: time('01:45:22'),
    lastAppearance: time('02:15:08'),
    isCloseup: true,
    significance: 'Central plot device',
    historicalAccuracy: 'Very high'
}]->(o);

// Create fan community
CREATE (DuneFandom:FanCommunity:GeneratedByClaudeAI {
    name: 'Dune Fan Community',
    established: date('1965-08-15'),
    reactivation: date('2021-10-22'),
    memberCount: 3250000,
    onlinePlatforms: 8,
    annualConventions: 5,
    largestEventAttendance: 15000,
    contentCreators: 28500,
    fanfictionCount: 45000,
    fanArtCount: 120000,
    academicPapers: 450
})
WITH 1 as dummy
MATCH (f:FanCommunity:GeneratedByClaudeAI {name: 'Dune Fan Community'}),
      (d:Movie:GeneratedByClaudeAI {title: 'Dune'})
CREATE (f)-[:ENGAGED_WITH {
    anticipationScore: 9.7,
    reviewsSubmitted: 185000,
    averageRating: 8.6,
    onlineDiscussions: 85000,
    theoriesGenerated: 15000,
    preReleaseEvents: 45,
    postReleaseEvents: 230,
    merchandiseSales: 75000000,
    sequelAnticipation: 9.8
}]->(d);

// Connect more actors
MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Amy Adams'}),
  (c:Person:GeneratedByClaudeAI {name: 'Cillian Murphy'})
CREATE (a)-[:KNOWS {
    since: date('2013-08-15'),
    relationship: 'Professional Colleagues',
    lastMeeting: date('2023-09-22'),
    durationYears: 10,
    commonFriends: 12,
    commonEvents: 8
}]->(c);

MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Michelle Yeoh'}),
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'})
CREATE (m)-[:ADMIRES {
    since: date('2010-07-16'),
    projects: 0,
    relationship: 'Professional Admiration',
    lastContact: date('2023-02-28'),
    inspirationLevel: 4.8,
    influencedWorks: ['Everything Everywhere All at Once']
}]->(c);

// Create costume design relationship
CREATE (JacquelineWest:Person:GeneratedByClaudeAI {
    name: 'Jacqueline West',
    born: 1950,
    birthdate: date('1950-10-15'),
    nationality: 'American',
    oscarNominations: 4,
    isActive: true,
    firstFilm: datetime('1998-11-20T00:00:00Z'),
    specialization: 'Costume Design',
    careerLength: duration({years: 25}),
    designStyle: 'Historical authenticity with symbolic elements'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Jacqueline West'}),
      (d:Movie:GeneratedByClaudeAI {title: 'Dune'})
CREATE (p)-[:DESIGNED_COSTUMES_FOR {
    year: 2021,
    costumesCreated: 1200,
    budget: 2500000,
    awardNominations: 5,
    awardWins: 2,
    startDate: date('2018-10-15'),
    completionDate: date('2019-02-28'),
    specialCostumes: ['Stillsuits', 'House Atreides uniforms', 'Bene Gesserit robes'],
    researchHours: 850,
    conceptualDesigns: 280
}]->(d);

// Create cinematographer relationship
CREATE (HoyteVanHoytema:Person:GeneratedByClaudeAI {
    name: 'Hoyte van Hoytema',
    born: 1971,
    birthdate: date('1971-10-04'),
    nationality: 'Dutch-Swedish',
    oscarNominations: 3,
    oscarWins: 1,
    isActive: true,
    firstFilm: datetime('2002-09-15T00:00:00Z'),
    visualStyle: 'Natural lighting with IMAX optimization',
    cameraPreference: 'IMAX 65mm',
    collaborations: 4
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Hoyte van Hoytema'}),
      (o:Movie:GeneratedByClaudeAI {title: 'Oppenheimer'})
CREATE (p)-[:CINEMATOGRAPHY_FOR {
    year: 2023,
    cameras: ['IMAX 65mm', 'Panavision 65mm'],
    lenses: ['IMAX', 'Panavision System 65'],
    awardNominations: 12,
    awardWins: 8,
    startDate: date('2022-02-22'),
    completionDate: date('2022-05-18'),
    signature_shots: ['Trinity explosion', 'Quantum discussions', 'Hearing sequences'],
    lighting_setups: 165,
    filmedOnLocation: true
}]->(o);

// Create classic film nodes
CREATE (TheSoundOfMusic:Movie:GeneratedByClaudeAI {
    title: 'The Sound of Music',
    released: 1965,
    tagline: 'The happiest sound in all the world!',
    budget: 8200000,
    revenue: 286214286,
    runtime_minutes: 172,
    rating_avg: 8.0,
    releaseDate: date('1965-03-02'),
    digitalRestoration: datetime('2000-11-14T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'The Sound of Music'})
SET m.ratings = [8.1, 7.9, 8.0, 8.0]
SET m.genres = ['musical', 'drama', 'romance', 'family']
SET m.certifications = ['G', 'U']
SET m.filmingLocationLat = [47.8095, 47.7984, 48.2084]
SET m.filmingLocationLong = [13.0550, 13.0442, 16.3731]
SET m.boxOfficeNA = 163214286
SET m.boxOfficeInternational = 123000000
SET m.musicalNumbers = 15
SET m.digitalRemastering = 2;

CREATE (Psycho:Movie:GeneratedByClaudeAI {
    title: 'Psycho',
    released: 1960,
    tagline: 'A new—and altogether different—screen excitement!!!',
    budget: 806947,
    revenue: 50000000,
    runtime_minutes: 109,
    rating_avg: 8.5,
    releaseDate: date('1960-06-16'),
    digitalRestoration: datetime('1997-10-05T00:00:00Z'),
    isOscarWinner: false,
    isPreservationRegistry: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Psycho'})
SET m.ratings = [8.5, 8.5, 8.4, 8.6]
SET m.genres = ['horror', 'thriller', 'mystery']
SET m.certifications = ['R', '15']
SET m.filmingLocationLat = [34.1381, 37.7937]
SET m.filmingLocationLong = [-118.3534, -122.4048]
SET m.boxOfficeNA = 32000000
SET m.boxOfficeInternational = 18000000
SET m.preservationRegistry = 'National Film Registry'
SET m.iconicScenes = ['Shower scene', 'House on the hill', 'Parlor scene'];

// Create contemporary blockbuster film nodes
CREATE (Avatar:Movie:GeneratedByClaudeAI {
    title: 'Avatar',
    released: 2009,
    tagline: 'Enter the world of Pandora',
    budget: 237000000,
    revenue: 2923706026,
    runtime_minutes: 162,
    rating_avg: 7.9,
    releaseDate: date('2009-12-18'),
    digitalRelease: datetime('2010-04-22T00:00:00Z'),
    isOscarWinner: true,
    is3D: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Avatar'})
SET m.ratings = [7.9, 7.8, 8.0, 7.9]
SET m.genres = ['sci-fi', 'action', 'adventure', 'fantasy']
SET m.certifications = ['PG-13', '12A']
SET m.filmingLocationLat = [38.9072, 45.0678, -36.8509]
SET m.filmingLocationLong = [-77.0369, 7.6695, 174.7645]
SET m.boxOfficeNA = 785221649
SET m.boxOfficeInternational = 2138484377
SET m.motionCapturePercentage = 70
SET m.renderingHours = 150000000;

CREATE (BlackPanther:Movie:GeneratedByClaudeAI {
    title: 'Black Panther',
    released: 2018,
    tagline: 'Long live the king',
    budget: 200000000,
    revenue: 1347280838,
    runtime_minutes: 134,
    rating_avg: 7.3,
    releaseDate: date('2018-02-16'),
    digitalRelease: datetime('2018-05-08T00:00:00Z'),
    isOscarWinner: true,
    culturalImpact: 'Groundbreaking'
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Black Panther'})
SET m.ratings = [7.4, 7.3, 7.2, 7.3]
SET m.genres = ['action', 'adventure', 'sci-fi']
SET m.certifications = ['PG-13', '12A']
SET m.filmingLocationLat = [33.7490, 36.0726, -29.8579]
SET m.filmingLocationLong = [-84.3880, -79.7920, 31.0292]
SET m.boxOfficeNA = 700059566
SET m.boxOfficeInternational = 647171272
SET m.culturalMilestones = ['First predominantly Black superhero film', 'First superhero film nominated for Best Picture']
SET m.merchandisingSales = 350000000;

// Create animated film node
CREATE (SpiderVerse2:Movie:GeneratedByClaudeAI {
    title: 'Spider-Man: Across the Spider-Verse',
    released: 2023,
    tagline: 'It\'s how you wear the mask that matters',
    budget: 100000000,
    revenue: 690516493,
    runtime_minutes: 140,
    rating_avg: 8.7,
    releaseDate: date('2023-06-02'),
    digitalRelease: datetime('2023-08-08T00:00:00Z'),
    isOscarWinner: true,
    isAnimated: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Spider-Man: Across the Spider-Verse'})
SET m.ratings = [8.8, 8.7, 8.6, 8.7]
SET m.genres = ['animation', 'action', 'adventure', 'sci-fi']
SET m.certifications = ['PG', 'U']
SET m.animationStudioLat = [34.1593, 34.0901, 37.7749]
SET m.animationStudioLong = [-118.3263, -118.3676, -122.4194]
SET m.boxOfficeNA = 381311036
SET m.boxOfficeInternational = 309205457
SET m.animationStyles = ['Comic Book', '2D', '3D', 'Watercolor', 'Anime', 'Digital Painting']
SET m.renderedFrames = 280000;

// Create notable early 2000s indie film
CREATE (LostInTranslation:Movie:GeneratedByClaudeAI {
    title: 'Lost in Translation',
    released: 2003,
    tagline: 'Everyone wants to be found',
    budget: 4000000,
    revenue: 119723856,
    runtime_minutes: 102,
    rating_avg: 7.7,
    releaseDate: date('2003-09-12'),
    digitalRelease: datetime('2004-02-03T00:00:00Z'),
    isOscarWinner: true,
    isIndie: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Lost in Translation'})
SET m.ratings = [7.8, 7.7, 7.6, 7.7]
SET m.genres = ['drama', 'comedy', 'romance']
SET m.certifications = ['R', '15']
SET m.filmingLocationLat = [35.6762, 35.6895, 35.7147]
SET m.filmingLocationLong = [139.6503, 139.6917, 139.7967]
SET m.boxOfficeNA = 44585453
SET m.boxOfficeInternational = 75138403
SET m.festivalWins = 77
SET m.filmingDays = 27;

// Create actors, directors, and other film professionals
CREATE (JulieAndrews:Person:GeneratedByClaudeAI {
    name: 'Julie Andrews',
    born: 1935,
    birthdate: date('1935-10-01'),
    nationality: 'British',
    oscarWins: 1,
    oscarNominations: 3,
    isActive: true,
    firstFilm: datetime('1964-08-27T00:00:00Z'),
    heightInMeters: 1.73,
    netWorth: 45000000,
    voiceRange: '4 octaves'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Julie Andrews'})
SET p.languages = ['English', 'French', 'Italian']
SET p.filmography_titles = ['The Sound of Music', 'Mary Poppins', 'The Princess Diaries']
SET p.filmography_years = [1965, 1964, 2001]
SET p.filmography_roles = ['Maria von Trapp', 'Mary Poppins', 'Queen Clarisse Renaldi']
SET p.musicalSkills = ['Singing', 'Dancing', 'Piano'];

CREATE (AlfredHitchcock:Person:GeneratedByClaudeAI {
    name: 'Alfred Hitchcock',
    born: 1899,
    died: 1980,
    birthdate: date('1899-08-13'),
    deathdate: date('1980-04-29'),
    nationality: 'British-American',
    oscarWins: 0,
    oscarNominations: 5,
    isActive: false,
    firstFilm: datetime('1925-08-03T00:00:00Z'),
    lastFilm: datetime('1976-08-14T00:00:00Z'),
    careerLength: duration({years: 51}),
    heightInMeters: 1.70,
    significantContribution: 'Suspense techniques'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Alfred Hitchcock'})
SET p.languages = ['English', 'French']
SET p.skillSets = ['Directing', 'Writing', 'Producing']
SET p.filmography_titles = ['Psycho', 'Vertigo', 'Rear Window', 'North by Northwest']
SET p.filmography_years = [1960, 1958, 1954, 1959]
SET p.cameramanship = 'Innovative';

CREATE (AnthonyPerkins:Person:GeneratedByClaudeAI {
    name: 'Anthony Perkins',
    born: 1932,
    died: 1992,
    birthdate: date('1932-04-04'),
    deathdate: date('1992-09-12'),
    nationality: 'American',
    oscarNominations: 1,
    isActive: false,
    firstFilm: datetime('1953-03-23T00:00:00Z'),
    lastFilm: datetime('1992-06-18T00:00:00Z'),
    careerLength: duration({years: 39}),
    heightInMeters: 1.85,
    typecastEffect: 'Significant'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Anthony Perkins'})
SET p.languages = ['English', 'French']
SET p.filmography_titles = ['Psycho', 'Friendly Persuasion', 'Fear Strikes Out']
SET p.filmography_years = [1960, 1956, 1957]
SET p.filmography_roles = ['Norman Bates', 'Josh Birdwell', 'Jim Piersall'];

CREATE (JamesCameron:Person:GeneratedByClaudeAI {
    name: 'James Cameron',
    born: 1954,
    birthdate: date('1954-08-16'),
    nationality: 'Canadian-American',
    oscarWins: 3,
    oscarNominations: 11,
    isActive: true,
    firstFilm: datetime('1982-03-03T00:00:00Z'),
    heightInMeters: 1.87,
    netWorth: 700000000,
    directorRanking: 'Pioneering',
    deepSeaExperience: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'James Cameron'})
SET p.languages = ['English', 'Spanish']
SET p.skillSets = ['Directing', 'Writing', 'Editing', 'Producing', 'Deep Sea Exploration']
SET p.filmography_titles = ['Avatar', 'Titanic', 'Terminator 2', 'Aliens']
SET p.filmography_years = [2009, 1997, 1991, 1986]
SET p.technicalInnovations = ['3D filming techniques', 'Motion capture advancements', 'Deep sea camera systems'];

CREATE (SamWorthington:Person:GeneratedByClaudeAI {
    name: 'Sam Worthington',
    born: 1976,
    birthdate: date('1976-08-02'),
    nationality: 'Australian',
    oscarNominations: 0,
    isActive: true,
    firstFilm: datetime('2000-10-19T00:00:00Z'),
    heightInMeters: 1.78,
    netWorth: 30000000,
    motionCaptureExperience: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Sam Worthington'})
SET p.languages = ['English']
SET p.filmography_titles = ['Avatar', 'Terminator Salvation', 'Clash of the Titans']
SET p.filmography_years = [2009, 2009, 2010]
SET p.filmography_roles = ['Jake Sully', 'Marcus Wright', 'Perseus'];

CREATE (ChadwickBoseman:Person:GeneratedByClaudeAI {
    name: 'Chadwick Boseman',
    born: 1976,
    died: 2020,
    birthdate: date('1976-11-29'),
    deathdate: date('2020-08-28'),
    nationality: 'American',
    oscarNominations: 1,
    isActive: false,
    firstFilm: datetime('2008-03-06T00:00:00Z'),
    lastFilm: datetime('2020-12-18T00:00:00Z'),
    careerLength: duration({years: 12}),
    heightInMeters: 1.83,
    culturalImpact: 'Transformative'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Chadwick Boseman'})
SET p.languages = ['English']
SET p.filmography_titles = ['Black Panther', '42', 'Get on Up', 'Marshall']
SET p.filmography_years = [2018, 2013, 2014, 2017]
SET p.filmography_roles = ['T\'Challa/Black Panther', 'Jackie Robinson', 'James Brown', 'Thurgood Marshall'];

CREATE (RyanCoogler:Person:GeneratedByClaudeAI {
    name: 'Ryan Coogler',
    born: 1986,
    birthdate: date('1986-05-23'),
    nationality: 'American',
    oscarNominations: 0,
    isActive: true,
    firstFilm: datetime('2013-01-19T00:00:00Z'),
    heightInMeters: 1.73,
    netWorth: 25000000,
    directorStyle: 'Character-driven'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Ryan Coogler'})
SET p.languages = ['English']
SET p.filmography_titles = ['Black Panther', 'Creed', 'Fruitvale Station']
SET p.filmography_years = [2018, 2015, 2013]
SET p.genreSpecialty = ['Drama', 'Action'];

CREATE (ScarlettJohansson:Person:GeneratedByClaudeAI {
    name: 'Scarlett Johansson',
    born: 1984,
    birthdate: date('1984-11-22'),
    nationality: 'American',
    oscarNominations: 2,
    isActive: true,
    firstFilm: datetime('1994-12-21T00:00:00Z'),
    heightInMeters: 1.60,
    netWorth: 165000000,
    voiceActingExperience: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Scarlett Johansson'})
SET p.languages = ['English', 'Danish']
SET p.filmography_titles = ['Lost in Translation', 'Marriage Story', 'Black Widow', 'Her']
SET p.filmography_years = [2003, 2019, 2021, 2013]
SET p.filmography_roles = ['Charlotte', 'Nicole Barber', 'Natasha Romanoff', 'Samantha (voice)'];

CREATE (SofiaCoppola:Person:GeneratedByClaudeAI {
    name: 'Sofia Coppola',
    born: 1971,
    birthdate: date('1971-05-14'),
    nationality: 'American',
    oscarWins: 1,
    oscarNominations: 4,
    isActive: true,
    firstFilm: datetime('1999-04-25T00:00:00Z'),
    heightInMeters: 1.63,
    netWorth: 40000000,
    directorStyle: 'Atmospheric'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Sofia Coppola'})
SET p.languages = ['English', 'Italian', 'French']
SET p.filmography_titles = ['Lost in Translation', 'The Virgin Suicides', 'Marie Antoinette']
SET p.filmography_years = [2003, 1999, 2006]
SET p.visualAesthetics = 'Dreamlike';

CREATE (ShameikMoore:Person:GeneratedByClaudeAI {
    name: 'Shameik Moore',
    born: 1995,
    birthdate: date('1995-05-04'),
    nationality: 'American',
    oscarNominations: 0,
    isActive: true,
    firstFilm: datetime('2012-08-26T00:00:00Z'),
    voiceType: 'Tenor',
    heightInMeters: 1.73,
    netWorth: 5000000,
    musicalBackground: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Shameik Moore'})
SET p.languages = ['English']
SET p.filmography_titles = ['Spider-Man: Into the Spider-Verse', 'Spider-Man: Across the Spider-Verse', 'Dope']
SET p.filmography_years = [2018, 2023, 2015]
SET p.filmography_roles = ['Miles Morales (voice)', 'Miles Morales (voice)', 'Malcolm']
SET p.musicalSkills = ['Singing', 'Rapping', 'Dancing'];

// Create more studios
CREATE (TwentiethCenturyFox:Studio:GeneratedByClaudeAI {
    name: '20th Century Fox',
    founded: date('1935-05-31'),
    acquired: date('2019-03-20'),
    headquartersLat: 34.0746,
    headquartersLong: -118.3798,
    yearlyRevenue2018: 7800000000,
    yearlyRevenue2019: 6500000000,
    digitalArchiveCreation: datetime('2010-06-15T00:00:00Z'),
    isActive: false,
    marketShare: 0.12,
    acquisitionAmount: 71300000000
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: '20th Century Fox'})
SET s.subsidiaries = ['Fox Searchlight Pictures', 'Blue Sky Studios', 'Fox 2000 Pictures']
SET s.distributionMarkets = ['Global']
SET s.studioLotsLat = [34.0746, 40.7580]
SET s.studioLotsLong = [-118.3798, -73.9855]
SET s.acquiredBy = 'The Walt Disney Company';

CREATE (ParamountPictures:Studio:GeneratedByClaudeAI {
    name: 'Paramount Pictures',
    founded: date('1912-05-08'),
    headquartersLat: 34.0841,
    headquartersLong: -118.3213,
    yearlyRevenue2020: 4500000000,
    yearlyRevenue2021: 6800000000,
    yearlyRevenue2022: 7200000000,
    digitalStreamingDate: datetime('2021-03-04T00:00:00Z'),
    isPublic: true,
    marketShare: 0.08,
    studioAge: 111
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Paramount Pictures'})
SET s.subsidiaries = ['Paramount Animation', 'Paramount Players', 'Paramount Television Studios']
SET s.distributionMarkets = ['Global']
SET s.studioLotsLat = [34.0841, 40.7590, 51.5112]
SET s.studioLotsLong = [-118.3213, -73.9845, -0.1198]
SET s.mountainLogo = true;

CREATE (FocusFeatures:Studio:GeneratedByClaudeAI {
    name: 'Focus Features',
    founded: date('2002-05-26'),
    headquartersLat: 34.1381,
    headquartersLong: -118.3534,
    yearlyRevenue2020: 320000000,
    yearlyRevenue2021: 450000000,
    yearlyRevenue2022: 380000000,
    digitalStreamingDate: datetime('2018-06-22T00:00:00Z'),
    isPublic: false,
    marketShare: 0.02,
    indieFilmFocus: true
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Focus Features'})
SET s.subsidiaries = ['Focus World']
SET s.distributionMarkets = ['North America', 'Europe', 'Asia', 'Australia']
SET s.studioLotsLat = [34.1381]
SET s.studioLotsLong = [-118.3534]
SET s.parentCompany = 'Universal Pictures'
SET s.awardWinningFilms = 78;

// Create production events
CREATE (SoundOfMusicProduction:Production:GeneratedByClaudeAI {
    name: 'The Sound of Music Production',
    startDate: date('1964-03-26'),
    endDate: date('1964-09-01'),
    durationMonths: 5,
    durationDays: 6,
    startTime: localtime('07:00:00'),
    isCompleted: true,
    budgetPersonnel: 3200000,
    budgetEquipment: 1500000,
    budgetLocations: 2000000,
    budgetMusic: 1000000,
    budgetOther: 500000,
    weatherGood: 65,
    weatherAcceptable: 30,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'The Sound of Music Production'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Musical Recording', 'Wrap']
SET p.scheduleTimes = ['05:00:00', '06:30:00', '07:00:00', '19:00:00', '20:00:00']
SET p.scheduleDurations = [1.5, 0.5, 12, 3, 1]
SET p.locationCountries = ['Austria', 'United States'];

CREATE (PsychoProduction:Production:GeneratedByClaudeAI {
    name: 'Psycho Production',
    startDate: date('1959-11-11'),
    endDate: date('1960-02-01'),
    durationMonths: 2,
    durationDays: 21,
    startTime: localtime('08:00:00'),
    isCompleted: true,
    budgetPersonnel: 400000,
    budgetEquipment: 150000,
    budgetLocations: 50000,
    budgetSets: 180000,
    budgetOther: 26947,
    weatherGood: 90,
    weatherAcceptable: 8,
    weatherPoor: 2
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Psycho Production'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['06:00:00', '07:30:00', '08:00:00', '18:00:00']
SET p.scheduleDurations = [1.5, 0.5, 10, 1]
SET p.studioRestrictions = ['Limited budget', 'Black and white film', 'Small crew'];

CREATE (AvatarProduction:Production:GeneratedByClaudeAI {
    name: 'Avatar Production',
    startDate: date('2007-04-16'),
    endDate: date('2007-12-15'),
    durationMonths: 8,
    durationDays: 0,
    startTime: localtime('06:00:00'),
    isCompleted: true,
    budgetPersonnel: 80000000,
    budgetEquipment: 45000000,
    budgetMotionCapture: 65000000,
    budgetVFX: 90000000,
    budgetOther: 22000000,
    technicalChallenges: 85,
    technicalSuccesses: 92
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Avatar Production'})
SET p.scheduleActivities = ['Performance Capture', 'Virtual Camera', 'Live Action', 'Post-Production']
SET p.scheduleTimes = ['06:00:00', '10:00:00', '14:00:00', '18:00:00']
SET p.scheduleDurations = [4, 4, 4, 8]
SET p.motionCaptureStages = 6;

CREATE (BlackPantherProduction:Production:GeneratedByClaudeAI {
    name: 'Black Panther Production',
    startDate: date('2017-01-15'),
    endDate: date('2017-04-19'),
    durationMonths: 3,
    durationDays: 4,
    startTime: localtime('06:30:00'),
    isCompleted: true,
    budgetPersonnel: 65000000,
    budgetEquipment: 25000000,
    budgetLocations: 35000000,
    budgetVFX: 60000000,
    budgetOther: 15000000,
    weatherGood: 80,
    weatherAcceptable: 15,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Black Panther Production'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['04:00:00', '06:00:00', '06:30:00', '18:30:00']
SET p.scheduleDurations = [2, 0.5, 12, 1.5]
SET p.filmingCountries = ['United States', 'South Korea', 'Argentina'];

CREATE (LostInTranslationProduction:Production:GeneratedByClaudeAI {
    name: 'Lost in Translation Production',
    startDate: date('2002-09-29'),
    endDate: date('2002-10-25'),
    durationMonths: 0,
    durationDays: 27,
    startTime: localtime('06:00:00'),
    isCompleted: true,
    budgetPersonnel: 1500000,
    budgetEquipment: 800000,
    budgetLocations: 1200000,
    budgetOther: 500000,
    weatherGood: 85,
    weatherAcceptable: 12,
    weatherPoor: 3
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Lost in Translation Production'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['04:00:00', '05:30:00', '06:00:00', '18:00:00']
SET p.scheduleDurations = [1.5, 0.5, 12, 1]
SET p.guerrillaFilming = true;

// Add more reviews
CREATE (SoundOfMusicReview:Review:GeneratedByClaudeAI {
    title: 'A Timeless Musical Masterpiece',
    stars: 4.7,
    date: date('1965-03-10'),
    time: time('14:30:00-05:00'),
    isVerified: true,
    aspectDirection: 4.8,
    aspectActing: 4.6,
    aspectMusic: 5.0,
    aspectCinematography: 4.9,
    aspectPlot: 4.5,
    reviewText: 'The Sound of Music is a glorious celebration of music, stunning Alpine scenery, and heartwarming family values. Julie Andrews delivers a career-defining performance as Maria, and the musical numbers have rightfully become cultural touchstones.',
    historicalRelevance: 'Definitive family musical'
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'A Timeless Musical Masterpiece'})
SET r.culturalImpactAssessments = [date('1975-03-10'), date('1995-03-10'), date('2015-03-10')]
SET r.historicalSignificanceRatings = [4.5, 4.7, 4.8]
SET r.assessmentYears = [1975, 1995, 2015]
SET r.keywords = ['musical', 'family', 'Austrian', 'historical']
SET r.academicCitations = 458;

CREATE (PsychoReview:Review:GeneratedByClaudeAI {
    title: 'Revolutionary Horror That Changed Cinema',
    stars: 5.0,
    date: date('1960-06-22'),
    time: time('15:15:00-05:00'),
    isVerified: true,
    aspectDirection: 5.0,
    aspectActing: 4.9,
    aspectCinematography: 5.0,
    aspectMusic: 4.9,
    aspectTension: 5.0,
    reviewText: 'Alfred Hitchcock\'s Psycho shattered conventions with its shocking shower scene and narrative twists. The film\'s psychological depth, Bernard Herrmann\'s screeching score, and Anthony Perkins\' unforgettable performance as Norman Bates created a template for modern horror.',
    culturalImpact: 'Genre-defining'
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'Revolutionary Horror That Changed Cinema'})
SET r.historicalReassessments = [date('1970-06-22'), date('1990-06-22'), date('2010-06-22')]
SET r.influenceRatings = [9.2, 9.6, 9.8]
SET r.assessmentYears = [1970, 1990, 2010]
SET r.keywords = ['horror', 'psychological', 'innovative', 'shocking']
SET r.filmSchoolReferences = 8942;

CREATE (AvatarReview:Review:GeneratedByClaudeAI {
    title: 'Groundbreaking Visual Achievement',
    stars: 4.5,
    date: date('2009-12-21'),
    time: time('17:42:15-05:00'),
    isVerified: true,
    aspectDirection: 4.6,
    aspectVisuals: 5.0,
    aspectCinematography: 4.9,
    aspectWorldBuilding: 4.8,
    aspectPlot: 3.9,
    reviewText: 'James Cameron\'s Avatar revolutionized filmmaking technology with its unprecedented 3D visuals and motion capture performances. While the environmental message and colonial critique follow familiar paths, the immersive world of Pandora represents cinema\'s most fully realized alien ecosystem.',
    upvotes: 18654
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'Groundbreaking Visual Achievement'})
SET r.commentTimestamps = [datetime('2009-12-21T19:12:33-05:00'), datetime('2009-12-22T08:45:22-05:00'), datetime('2009-12-23T14:36:51-05:00')]
SET r.keywords = ['3D', 'groundbreaking', 'sci-fi', 'visual-effects']
SET r.readerLocationsLat = [40.7128, 51.5074, 34.0522]
SET r.readerLocationsLong = [-74.0060, -0.1278, -118.2437];

CREATE (BlackPantherReview:Review:GeneratedByClaudeAI {
    title: 'Cultural Milestone and Superhero Excellence',
    stars: 4.8,
    date: date('2018-02-18'),
    time: time('15:30:45-05:00'),
    isVerified: true,
    aspectDirection: 4.8,
    aspectActing: 4.7,
    aspectVisuals: 4.9,
    aspectCulturalImpact: 5.0,
    aspectPlot: 4.6,
    reviewText: 'Black Panther transcends the superhero genre with its celebration of African culture, complex characters, and thoughtful exploration of identity and responsibility. Chadwick Boseman\'s regal performance as T\'Challa anchors a film that skillfully balances blockbuster thrills with social commentary.',
    upvotes: 25483
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'Cultural Milestone and Superhero Excellence'})
SET r.commentTimestamps = [datetime('2018-02-18T17:22:43-05:00'), datetime('2018-02-19T09:15:12-05:00'), datetime('2018-02-20T14:32:01-05:00')]
SET r.keywords = ['superhero', 'afrofuturism', 'cultural-impact', 'representation']
SET r.readerLocationsLat = [33.7490, 40.7128, 37.7749]
SET r.readerLocationsLong = [-84.3880, -74.0060, -122.4194];

CREATE (LostInTranslationReview:Review:GeneratedByClaudeAI {
    title: 'A Poetic Meditation on Connection',
    stars: 4.9,
    date: date('2003-09-15'),
    time: time('22:15:30-04:00'),
    isVerified: true,
    aspectDirection: 4.9,
    aspectActing: 5.0,
    aspectAtmosphere: 5.0,
    aspectCinematography: 4.8,
    aspectSubtlety: 4.9,
    reviewText: 'Sofia Coppola\'s Lost in Translation is a delicate, evocative portrait of two lost souls finding brief connection in Tokyo. Bill Murray and Scarlett Johansson deliver nuanced performances that communicate volumes with glances and silences. The film captures the disorientation of cultural displacement and the bittersweet nature of fleeting relationships.',
    upvotes: 12485
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'A Poetic Meditation on Connection'})
SET r.commentTimestamps = [datetime('2003-09-15T23:42:18-04:00'), datetime('2003-09-16T08:15:27-04:00'), datetime('2003-09-17T15:32:41-04:00')]
SET r.keywords = ['tokyo', 'alienation', 'connection', 'melancholy', 'indie']
SET r.readerLocationsLat = [40.7128, 34.0522, 35.6762]
SET r.readerLocationsLong = [-74.0060, -118.2437, 139.6503];

// Create Golden Globe Award ceremony
CREATE (GoldenGlobes:Ceremony:GeneratedByClaudeAI {
    name: 'Golden Globe Awards',
    nickname: 'Golden Globes',
    established: date('1944-01-20'),
    ceremonyTime: localtime('20:00:00'),
    typicalDurationHrs: 3.0,
    isPrestigious: true,
    locationLat: 34.0736,
    locationLong: -118.4004,
    locationHeight: 82,
    nextCeremony: datetime('2026-01-11T20:00:00-08:00')
})
WITH 1 as dummy
MATCH (c:Ceremony:GeneratedByClaudeAI {name: 'Golden Globe Awards'})
SET c.categories = ['Best Motion Picture - Drama', 'Best Motion Picture - Musical or Comedy', 'Best Director', 'Best Actor - Drama', 'Best Actress - Drama']
SET c.viewership2020 = 18300000
SET c.viewership2021 = 6900000
SET c.viewership2022 = 6300000
SET c.viewership2023 = 9250000;

// Create relationships between nodes
MATCH 
  (r:Person {name: 'Robert Wise'}), // Assuming Robert Wise exists from original data
  (s:Movie:GeneratedByClaudeAI {title: 'The Sound of Music'})
CREATE (r)-[:DIRECTED {
    year: 1965,
    daysOnSet: 145,
    satisfaction: 4.9,
    awardNominations: 10,
    completionDate: date('1964-11-15'),
    premiereEvent: datetime('1965-03-02T19:30:00-05:00'),
    durationMonths: 5,
    isFirstMusical: false,
    onLocationPercentage: 60
}]->(s);

MATCH 
  (a:Person:GeneratedByClaudeAI {name: 'Alfred Hitchcock'}),
  (p:Movie:GeneratedByClaudeAI {title: 'Psycho'})
CREATE (a)-[:DIRECTED {
    year: 1960,
    daysOnSet: 45,
    satisfaction: 4.8,
    studioInterference: 'Low',
    completionDate: date('1960-02-01'),
    premiereEvent: datetime('1960-06-16T20:00:00-05:00'),
    durationMonths: 2,
    isLowBudget: true,
    blackAndWhiteDecision: 'Artistic and practical'
}]->(p);

MATCH 
  (j:Person:GeneratedByClaudeAI {name: 'James Cameron'}),
  (a:Movie:GeneratedByClaudeAI {title: 'Avatar'})
CREATE (j)-[:DIRECTED {
    year: 2009,
    daysOnSet: 198,
    satisfaction: 4.9,
    awardNominations: 9,
    completionDate: date('2009-11-01'),
    premiereEvent: datetime('2009-12-10T19:00:00-05:00'),
    durationMonths: 8,
    isTechnicalInnovation: true,
    developmentYears: 15
}]->(a);

MATCH 
  (r:Person:GeneratedByClaudeAI {name: 'Ryan Coogler'}),
  (b:Movie:GeneratedByClaudeAI {title: 'Black Panther'})
CREATE (r)-[:DIRECTED {
    year: 2018,
    daysOnSet: 132,
    satisfaction: 4.9,
    awardNominations: 7,
    completionDate: date('2017-11-10'),
    premiereEvent: datetime('2018-01-29T20:00:00-05:00'),
    durationMonths: 3,
    marvelInvolvement: 'Supportive',
    culturalConsultants: 12
}]->(b);

MATCH 
  (s:Person:GeneratedByClaudeAI {name: 'Sofia Coppola'}),
  (l:Movie:GeneratedByClaudeAI {title: 'Lost in Translation'})
CREATE (s)-[:DIRECTED {
    year: 2003,
    daysOnSet: 27,
    satisfaction: 4.9,
    awardNominations: 4,
    awardWins: 1,
    completionDate: date('2002-12-15'),
    premiereEvent: datetime('2003-08-29T19:30:00+02:00'),
    durationMonths: 1,
    isPersonalStory: true,
    improvisation: 'Significant'
}]->(l);

// Actor to Movie relationships
MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Julie Andrews'}),
  (s:Movie:GeneratedByClaudeAI {title: 'The Sound of Music'})
CREATE (j)-[:ACTED_IN {
    roles: ['Maria von Trapp'],
    salary: 150000,
    screenTimeMinutes: 145,
    startDate: date('1964-03-26'),
    endDate: date('1964-09-01'),
    scheduleConflicts: false,
    criticScore: 95,
    audienceScore: 98,
    awardNominations: 5,
    awardWins: 1,
    songsPerformed: 10
}]->(s);

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Anthony Perkins'}),
  (p:Movie:GeneratedByClaudeAI {title: 'Psycho'})
CREATE (a)-[:ACTED_IN {
    roles: ['Norman Bates'],
    salary: 40000,
    screenTimeMinutes: 60,
    startDate: date('1959-11-11'),
    endDate: date('1960-02-01'),
    scheduleConflicts: false,
    criticScore: 96,
    audienceScore: 93,
    awardNominations: 1,
    careerDefiningRole: true
}]->(p);

MATCH
  (s:Person:GeneratedByClaudeAI {name: 'Sam Worthington'}),
  (a:Movie:GeneratedByClaudeAI {title: 'Avatar'})
CREATE (s)-[:ACTED_IN {
    roles: ['Jake Sully'],
    salary: 5000000,
    screenTimeMinutes: 138,
    startDate: date('2007-04-16'),
    endDate: date('2007-12-15'),
    scheduleConflicts: false,
    criticScore: 90,
    audienceScore: 92,
    motionCaptureHours: 1250,
    physicalTrainingMonths: 6
}]->(a);

MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Chadwick Boseman'}),
  (b:Movie:GeneratedByClaudeAI {title: 'Black Panther'})
CREATE (c)-[:ACTED_IN {
    roles: ['T\'Challa/Black Panther'],
    salary: 2000000,
    screenTimeMinutes: 105,
    startDate: date('2017-01-15'),
    endDate: date('2017-04-19'),
    scheduleConflicts: false,
    criticScore: 97,
    audienceScore: 96,
    awardNominations: 2,
    stuntTrainingHours: 375,
    dialectCoaching: true
}]->(b);

MATCH
  (s:Person:GeneratedByClaudeAI {name: 'Scarlett Johansson'}),
  (l:Movie:GeneratedByClaudeAI {title: 'Lost in Translation'})
CREATE (s)-[:ACTED_IN {
    roles: ['Charlotte'],
    salary: 750000,
    screenTimeMinutes: 85,
    startDate: date('2002-09-29'),
    endDate: date('2002-10-25'),
    scheduleConflicts: false,
    criticScore: 95,
    audienceScore: 90,
    awardNominations: 5,
    awardWins: 1,
    ageAtFilming: 17
}]->(l);

// Studio relationships
MATCH
  (t:Studio:GeneratedByClaudeAI {name: 'TwentiethCenturyFox'}),
  (s:Movie:GeneratedByClaudeAI {title: 'The Sound of Music'})
CREATE (t)-[:PRODUCED {
    investment: 8200000,
    return: 286214286,
    roi: 34.9,
    contractSigned: date('1963-08-15'),
    studioShare: 0.7,
    directorShare: 0.1,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 2000000,
    isProfitable: true,
    marketingStart: datetime('1964-12-15T00:00:00Z'),
    recordBreakingSuccess: true
}]->(s);

MATCH
  (p:Studio:GeneratedByClaudeAI {name: 'Paramount Pictures'}),
  (ps:Movie:GeneratedByClaudeAI {title: 'Psycho'})
CREATE (p)-[:PRODUCED {
    investment: 806947,
    return: 50000000,
    roi: 61.96,
    contractSigned: date('1959-08-23'),
    studioShare: 0.6,
    directorShare: 0.3,
    producerShare: 0.05,
    topCastShare: 0.05,
    marketingBudget: 500000,
    isProfitable: true,
    marketingStart: datetime('1960-04-15T00:00:00Z'),
    hitchcockDeal: 'Backend percentage'
}]->(ps);

MATCH
  (t:Studio:GeneratedByClaudeAI {name: 'TwentiethCenturyFox'}),
  (a:Movie:GeneratedByClaudeAI {title: 'Avatar'})
CREATE (t)-[:PRODUCED {
    investment: 237000000,
    return: 2923706026,
    roi: 12.34,
    contractSigned: date('2005-10-15'),
    studioShare: 0.5,
    directorShare: 0.3,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 150000000,
    isProfitable: true,
    marketingStart: datetime('2009-05-15T00:00:00Z'),
    highestGrossingMilestone: date('2010-01-25')
}]->(a);

MATCH
  (d:Studio {name: 'The Walt Disney Company'}), // Assuming Disney exists in original data
  (b:Movie:GeneratedByClaudeAI {title: 'Black Panther'})
CREATE (d)-[:PRODUCED {
    investment: 200000000,
    return: 1347280838,
    roi: 6.74,
    contractSigned: date('2016-04-10'),
    studioShare: 0.7,
    directorShare: 0.1,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 150000000,
    isProfitable: true,
    marketingStart: datetime('2017-07-22T00:00:00Z'),
    marvelCinematicUniverseEntry: 18
}]->(b);

MATCH
  (f:Studio:GeneratedByClaudeAI {name: 'Focus Features'}),
  (l:Movie:GeneratedByClaudeAI {title: 'Lost in Translation'})
CREATE (f)-[:PRODUCED {
    investment: 4000000,
    return: 119723856,
    roi: 29.93,
    contractSigned: date('2002-06-15'),
    studioShare: 0.5,
    directorShare: 0.25,
    producerShare: 0.15,
    topCastShare: 0.1,
    marketingBudget: 10000000,
    isProfitable: true,
    marketingStart: datetime('2003-07-15T00:00:00Z'),
    indieBreakoutStatus: true
}]->(l);

// Studio to filming relationship
MATCH
  (t:Studio:GeneratedByClaudeAI {name: 'TwentiethCenturyFox'}),
  (p:Production:GeneratedByClaudeAI {name: 'The Sound of Music Production'})
CREATE (t)-[:FINANCED {
    contractDate: date('1963-08-15'),
    amount: 8200000,
    isFullyPaid: true,
    transferTime1: datetime('1963-10-15T00:00:00Z'),
    transferTime2: datetime('1964-01-15T00:00:00Z'),
    transferTime3: datetime('1964-04-15T00:00:00Z'),
    paymentDate1: date('1963-10-15'),
    paymentAmount1: 2500000,
    paymentDate2: date('1964-01-15'),
    paymentAmount2: 3000000,
    paymentDate3: date('1964-04-15'),
    paymentAmount3: 2700000,
    locationPermitHandling: 'Studio managed'
}]->(p);

MATCH
  (p:Studio:GeneratedByClaudeAI {name: 'Paramount Pictures'}),
  (pr:Production:GeneratedByClaudeAI {name: 'Psycho Production'})
CREATE (p)-[:FINANCED {
    contractDate: date('1959-08-23'),
    amount: 806947,
    isFullyPaid: true,
    transferTime1: datetime('1959-10-01T00:00:00Z'),
    transferTime2: datetime('1959-12-15T00:00:00Z'),
    paymentDate1: date('1959-10-01'),
    paymentAmount1: 400000,
    paymentDate2: date('1959-12-15'),
    paymentAmount2: 406947,
    hitchcockOwnPercentage: 60,
    unusualDeal: true
}]->(pr);

MATCH
  (t:Studio:GeneratedByClaudeAI {name: 'TwentiethCenturyFox'}),
  (p:Production:GeneratedByClaudeAI {name: 'Avatar Production'})
CREATE (t)-[:FINANCED {
    contractDate: date('2005-10-15'),
    amount: 237000000,
    isFullyPaid: true,
    transferTime1: datetime('2006-01-15T00:00:00Z'),
    transferTime2: datetime('2006-07-15T00:00:00Z'),
    transferTime3: datetime('2007-01-15T00:00:00Z'),
    transferTime4: datetime('2007-07-15T00:00:00Z'),
    paymentDate1: date('2006-01-15'),
    paymentAmount1: 50000000,
    paymentDate2: date('2006-07-15'),
    paymentAmount2: 60000000,
    paymentDate3: date('2007-01-15'),
    paymentAmount3: 70000000,
    paymentDate4: date('2007-07-15'),
    paymentAmount4: 57000000,
    technologyDevelopmentFunding: true
}]->(p);

// Filming to movie relationship
MATCH
  (p:Production:GeneratedByClaudeAI {name: 'The Sound of Music Production'}),
  (s:Movie:GeneratedByClaudeAI {title: 'The Sound of Music'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 5,
    durationDays: 6,
    locationCount: 15,
    soundstageCount: 8,
    dailyAverageCost: 56000,
    scheduleAdherence: 0.92,
    weatherDelaysDays: 10,
    originalScheduledEnd: date('1964-08-20'),
    locationFilmingPercentage: 60,
    musicalNumbersFilmed: 15
}]->(s);

MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Psycho Production'}),
  (ps:Movie:GeneratedByClaudeAI {title: 'Psycho'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 2,
    durationDays: 21,
    setCount: 12,
    studioFilmingPercentage: 90,
    dailyAverageCost: 12000,
    scheduleAdherence: 0.95,
    originalScheduledEnd: date('1960-01-25'),
    blackAndWhiteFormat: true,
    crewSize: 85,
    secrecyLevel: 'Extreme'
}]->(ps);

// Award relationships
MATCH
  (s:Movie:GeneratedByClaudeAI {title: 'The Sound of Music'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (s)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 1966,
    ceremony: 38,
    isWinner: true,
    ceremonyDate: date('1966-04-18'),
    announcementTime: localtime('21:45:00'),
    votesFor: 2451,
    votesAgainst: 1254,
    producerAccepting: 'Robert Wise',
    culturalImpact: 'Mainstream musical legitimacy'
}]->(a);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Julie Andrews'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (j)-[:NOMINATED_FOR {
    category: 'Best Actress',
    year: 1966,
    ceremony: 38,
    isWinner: false,
    ceremonyDate: date('1966-04-18'),
    announcementTime: localtime('20:30:00'),
    votesFor: 1854,
    votesAgainst: 1978,
    previousWin: true,
    previousWinYear: 1965
}]->(a);

MATCH
  (a:Movie:GeneratedByClaudeAI {title: 'Avatar'}),
  (a2:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (a)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 2010,
    ceremony: 82,
    isWinner: false,
    ceremonyDate: date('2010-03-07'),
    announcementTime: localtime('21:45:00'),
    votesFor: 2350,
    votesAgainst: 2650,
    techAwards: 3,
    competitionWinner: 'The Hurt Locker'
}]->(a2);

MATCH
  (b:Movie:GeneratedByClaudeAI {title: 'Black Panther'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (b)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 2019,
    ceremony: 91,
    isWinner: false,
    ceremonyDate: date('2019-02-24'),
    announcementTime: localtime('21:45:00'),
    votesFor: 1850,
    votesAgainst: 2050,
    historicalSignificance: 'First superhero film nominated',
    culturalMilestone: true
}]->(a);

MATCH
  (s:Person:GeneratedByClaudeAI {name: 'Sofia Coppola'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (s)-[:NOMINATED_FOR {
    category: 'Best Original Screenplay',
    year: 2004,
    ceremony: 76,
    isWinner: true,
    ceremonyDate: date('2004-02-29'),
    announcementTime: localtime('20:15:00'),
    votesFor: 2456,
    votesAgainst: 1850,
    speechDuration: duration({minutes: 1, seconds: 45}),
    secondGenerationWinner: true
}]->(a);

// Professional relationships between people
MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Julie Andrews'}),
  (r:Person {name: 'Rob Reiner'}) // Original person from graph
CREATE (j)-[:KNOWS {
    since: date('1972-05-15'),
    relationship: 'Professional Colleagues',
    lastMeeting: date('2019-12-10'),
    durationYears: 47,
    commonProjects: 0,
    industryEvents: 23
}]->(r);

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Alfred Hitchcock'}),
  (t:Person {name: 'Tom Hanks'}) // Original person from graph
CREATE (a)-[:INFLUENCED {
    startYear: 1960,
    directInfluence: false,
    mentionedInInterviews: 15,
    cinematicTechniques: ['Camera movement', 'Suspense building', 'Audience manipulation'],
    influenceStrength: [8.5, 9.2, 8.8],
    culturalConnection: 'Directorial craft'
}]->(t);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'James Cameron'}),
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'})
CREATE (j)-[:KNOWS {
    since: date('2000-07-22'),
    relationship: 'Professional Peers',
    lastMeeting: date('2023-11-15'),
    durationYears: 23,
    mutualRespectLevel: 'Very High',
    technicalExchanges: 8
}]->(c);

MATCH
  (s:Person:GeneratedByClaudeAI {name: 'Sofia Coppola'}),
  (s2:Person:GeneratedByClaudeAI {name: 'Scarlett Johansson'})
CREATE (s)-[:WORKED_WITH {
    projects: 1,
    firstProject: 'Lost in Translation',
    firstYear: 2003,
    chemistry: 4.9,
    interviews: 42,
    relationship: 'Director-Actor',
    awardsCelebrated: 5,
    reunionDiscussions: 3
}]->(s2);

// Create soundtracks
CREATE (SoundOfMusicSoundtrack:Soundtrack:GeneratedByClaudeAI {
    title: 'The Sound of Music (Original Motion Picture Soundtrack)',
    composer: 'Richard Rodgers',
    lyricist: 'Oscar Hammerstein II',
    released: date('1965-03-02'),
    duration: duration({minutes: 87, seconds: 12}),
    trackCount: 20,
    recordingStudio: 'Todd-AO Scoring Stage',
    recordingStudioLat: 34.1381,
    recordingStudioLong: -118.3534,
    peakChartPosition: 1,
    weeksAtNumberOne: 70,
    salesUnits: 20000000,
    streamingCount: 120000000
})
WITH 1 as dummy
MATCH (s:Movie:GeneratedByClaudeAI {title: 'The Sound of Music'}),
      (st:Soundtrack:GeneratedByClaudeAI {title: 'The Sound of Music (Original Motion Picture Soundtrack)'})
CREATE (st)-[:COMPOSED_FOR {
    contractDate: date('1964-01-15'),
    completion: date('1964-11-22'),
    nominatedAwards: ['Academy Award', 'Grammy Award'],
    wonAwards: ['Academy Award', 'Grammy Award'],
    goldRecords: 1,
    platinumRecords: 2,
    iconicSongs: ['Do-Re-Mi', 'My Favorite Things', 'Edelweiss', 'Climb Ev\'ry Mountain']
}]->(s);

CREATE (PsychoSoundtrack:Soundtrack:GeneratedByClaudeAI {
    title: 'Psycho (Original Motion Picture Soundtrack)',
    composer: 'Bernard Herrmann',
    released: date('1960-09-16'),
    duration: duration({minutes: 45, seconds: 38}),
    trackCount: 14,
    recordingStudio: 'Paramount Scoring Stage',
    recordingStudioLat: 34.0841,
    recordingStudioLong: -118.3213,
    peakChartPosition: 32,
    salesUnits: 250000,
    streamingCount: 85000000,
    stringsOnly: true
})
WITH 1 as dummy
MATCH (p:Movie:GeneratedByClaudeAI {title: 'Psycho'}),
      (st:Soundtrack:GeneratedByClaudeAI {title: 'Psycho (Original Motion Picture Soundtrack)'})
CREATE (st)-[:COMPOSED_FOR {
    contractDate: date('1959-12-01'),
    completion: date('1960-01-15'),
    nominatedAwards: ['Grammy Award'],
    wonAwards: [],
    iconicTracks: ['The Murder', 'Prelude', 'The Cellar'],
    culturalInfluence: 'Revolutionized horror scoring',
    stringInstrumentCount: 18,
    recordingDays: 7
}]->(p);

// Create filming locations
CREATE (SalzburgLocation:FilmingLocation:GeneratedByClaudeAI {
    name: 'Salzburg',
    country: 'Austria',
    region: 'Salzburg State',
    latitude: 47.8095,
    longitude: 13.0550,
    elevation: 424,
    elevationUnit: 'm',
    climate: 'Temperate',
    permitCost: 150000,
    permitCurrency: 'USD',
    firstUsed: date('1964-04-15'),
    lastUsed: date('1964-06-28'),
    tourismIncrease: 250
})
WITH 1 as dummy
MATCH (s:Movie:GeneratedByClaudeAI {title: 'The Sound of Music'}),
      (l:FilmingLocation:GeneratedByClaudeAI {name: 'Salzburg'})
CREATE (s)-[:FILMED_AT {
    startDate: date('1964-04-15'),
    endDate: date('1964-06-28'),
    sceneCount: 45,
    totalDays: 75,
    weatherDelayDays: 10,
    crewSize: 150,
    logisticsCost: 850000,
    accommodationCost: 450000,
    characterPresent: ['Maria', 'Von Trapp Family', 'Captain von Trapp'],
    touristSiteToday: true
}]->(l);

CREATE (UniversalLot:FilmingLocation:GeneratedByClaudeAI {
    name: 'Universal Studios Backlot',
    country: 'USA',
    region: 'California',
    latitude: 34.1381,
    longitude: -118.3534,
    elevation: 210,
    elevationUnit: 'm',
    climate: 'Mediterranean',
    studioOwned: true,
    firstUsed: date('1915-03-15'),
    lastUsed: date('2024-01-15'),
    filmCount: 8452
})
WITH 1 as dummy
MATCH (p:Movie:GeneratedByClaudeAI {title: 'Psycho'}),
      (l:FilmingLocation:GeneratedByClaudeAI {name: 'Universal Studios Backlot'})
CREATE (p)-[:FILMED_AT {
    startDate: date('1959-11-11'),
    endDate: date('1960-02-01'),
    sceneCount: 85,
    totalDays: 40,
    weatherDelayDays: 2,
    crewSize: 85,
    setsBulit: 12,
    iconicSet: 'Bates Motel',
    setPreservationStatus: 'Tourist attraction',
    touristVisitsAnnually: 5000000
}]->(l);

// Create costume designers
CREATE (DorotyJeakins:Person:GeneratedByClaudeAI {
    name: 'Dorothy Jeakins',
    born: 1914,
    died: 1995,
    birthdate: date('1914-01-11'),
    deathdate: date('1995-11-27'),
    nationality: 'American',
    oscarWins: 3,
    oscarNominations: 12,
    isActive: false,
    firstFilm: datetime('1946-08-15T00:00:00Z'),
    lastFilm: datetime('1987-06-25T00:00:00Z'),
    careerLength: duration({years: 41}),
    specialization: 'Period Costume Design'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Dorothy Jeakins'}),
      (s:Movie:GeneratedByClaudeAI {title: 'The Sound of Music'})
CREATE (p)-[:DESIGNED_COSTUMES_FOR {
    year: 1965,
    costumesCreated: 850,
    budget: 400000,
    awardNominations: 1,
    awardWins: 0,
    startDate: date('1963-12-15'),
    completionDate: date('1964-03-10'),
    specialCostumes: ['Maria\'s wedding dress', 'Children\'s play clothes', 'Baroness evening gowns'],
    researchHours: 350,
    historicalAccuracy: 'High with artistic license',
    fabricsUsed: 85
}]->(s);

CREATE (HelenColvig:Person:GeneratedByClaudeAI {
    name: 'Helen Colvig',
    born: 1918,
    died: 1991,
    birthdate: date('1918-05-22'),
    deathdate: date('1991-08-15'),
    nationality: 'American',
    oscarNominations: 1,
    isActive: false,
    firstFilm: datetime('1952-06-15T00:00:00Z'),
    lastFilm: datetime('1980-11-22T00:00:00Z'),
    careerLength: duration({years: 28}),
    specialization: 'Contemporary Costume Design'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Helen Colvig'}),
      (ps:Movie:GeneratedByClaudeAI {title: 'Psycho'})
CREATE (p)-[:DESIGNED_COSTUMES_FOR {
    year: 1960,
    costumesCreated: 120,
    budget: 35000,
    awardNominations: 0,
    awardWins: 0,
    startDate: date('1959-10-01'),
    completionDate: date('1959-11-05'),
    specialCostumes: ['Norman\'s sweaters', 'Marion\'s suits', 'Mother\'s dress'],
    researchHours: 125,
    psychologicalSignificance: 'High',
    blackAndWhiteConsiderations: true
}]->(ps);

// Create cinematographer relationships
CREATE (TedMcCord:Person:GeneratedByClaudeAI {
    name: 'Ted McCord',
    born: 1900,
    died: 1976,
    birthdate: date('1900-08-02'),
    deathdate: date('1976-01-19'),
    nationality: 'American',
    oscarNominations: 3,
    isActive: false,
    firstFilm: datetime('1930-05-15T00:00:00Z'),
    lastFilm: datetime('1968-11-22T00:00:00Z'),
    careerLength: duration({years: 38}),
    visualStyle: 'Vivid color compositions'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Ted McCord'}),
      (s:Movie:GeneratedByClaudeAI {title: 'The Sound of Music'})
CREATE (p)-[:CINEMATOGRAPHY_FOR {
    year: 1965,
    cameras: ['Mitchell BNC', 'Todd-AO Cameras'],
    lenses: ['Todd-AO Lenses', 'Panavision Anamorphic'],
    awardNominations: 1,
    awardWins: 0,
    startDate: date('1964-03-26'),
    completionDate: date('1964-09-01'),
    signature_shots: ['Mountain opening', 'Gazebo scenes', 'Wedding procession'],
    lighting_setups: 215,
    colorProcess: 'DeLuxe Color',
    aspectRatio: '2.20:1'
}]->(s);

CREATE (JohnLRussell:Person:GeneratedByClaudeAI {
    name: 'John L. Russell',
    born: 1905,
    died: 1967,
    birthdate: date('1905-01-03'),
    deathdate: date('1967-02-01'),
    nationality: 'American',
    oscarNominations: 0,
    isActive: false,
    firstFilm: datetime('1940-05-15T00:00:00Z'),
    lastFilm: datetime('1966-11-22T00:00:00Z'),
    careerLength: duration({years: 26}),
    visualStyle: 'High contrast black and white'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'John L. Russell'}),
      (ps:Movie:GeneratedByClaudeAI {title: 'Psycho'})
CREATE (p)-[:CINEMATOGRAPHY_FOR {
    year: 1960,
    cameras: ['Mitchell NC', 'Arriflex 35'],
    lenses: ['Cooke Speed Panchro', 'Bausch & Lomb Baltar'],
    awardNominations: 0,
    awardWins: 0,
    startDate: date('1959-11-11'),
    completionDate: date('1960-02-01'),
    signature_shots: ['Shower scene', 'House on hill', 'Car sinking in swamp'],
    lighting_setups: 145,
    blackAndWhiteFilmStock: 'Eastman Double-X Negative',
    televisionExperience: true
}]->(ps);

// Create more connections between original and new graph
MATCH
  (o:Person:GeneratedByClaudeAI {name: 'Orson Welles'}),
  (a:Person:GeneratedByClaudeAI {name: 'Alfred Hitchcock'})
CREATE (o)-[:ADMIRED {
    since: date('1940-06-15'),
    publicStatements: 8,
    mutualRespect: true,
    commonTechniques: ['Deep focus', 'Innovative camera angles', 'Psychological suspense'],
    techniqueOverlap: [9.2, 8.5, 9.7],
    cinematicInfluence: 'Bidirectional'
}]->(a);

MATCH
  (s:Person:GeneratedByClaudeAI {name: 'Sofia Coppola'}),
  (b:Person:GeneratedByClaudeAI {name: 'Bong Joon-ho'})
CREATE (s)-[:KNOWS {
    since: date('2012-05-22'),
    relationship: 'Festival circuit colleagues',
    lastMeeting: date('2023-05-17'),
    durationYears: 11,
    festivalEncounters: 8,
    mutualAdmiration: true
}]->(b);

// Create fan community for classic film
CREATE (SoundOfMusicFandom:FanCommunity:GeneratedByClaudeAI {
    name: 'The Sound of Music Fan Community',
    established: date('1965-06-15'),
    revival: date('2005-03-02'),
    memberCount: 850000,
    onlinePlatforms: 12,
    annualTours: 850,
    largestEventAttendance: 25000,
    singAlongEvents: 450,
    tourismRevenue: 35000000,
    tourismRevenueCurrency: 'USD',
    academicStudies: 85
})
WITH 1 as dummy
MATCH (f:FanCommunity:GeneratedByClaudeAI {name: 'The Sound of Music Fan Community'}),
      (s:Movie:GeneratedByClaudeAI {title: 'The Sound of Music'})
CREATE (f)-[:CELEBRATES {
    yearsActive: 59,
    tourLocations: ['Salzburg', 'Vienna', 'Vermont'],
    annualFestivals: 5,
    merchandiseSales: 12000000,
    generationalAppeal: 'Multi-generational',
    songbooksPublished: 45,
    academicConferences: 12,
    recreationsPerformed: 'Global',
    culturalPreservation: 'Significant',
    archivalCollections: 15
}]->(s);

// Create educational program for classic film studies
CREATE (HitchcockStudyProgram:EducationalProgram:GeneratedByClaudeAI {
    name: 'Hitchcock Film Analysis Curriculum',
    developed: date('1980-05-15'),
    institutionsAdopting: 2450,
    targetEducationLevels: ['University', 'Film School', 'High School Advanced'],
    materialFormats: ['Digital', 'Print', 'Video supplements', 'Interactive'],
    languagesAvailable: 28,
    courseDuration: duration({weeks: 12}),
    totalLessonHours: 85,
    scholarlyEndorsements: 125,
    educatorRating: 9.6
})
WITH 1 as dummy
MATCH (e:EducationalProgram:GeneratedByClaudeAI {name: 'Hitchcock Film Analysis Curriculum'}),
      (p:Movie:GeneratedByClaudeAI {title: 'Psycho'})
CREATE (e)-[:ANALYZES {
    focusAreas: ['Suspense techniques', 'Visual symbolism', 'Psychological themes', 'Cultural context', 'Narrative structure'],
    focusDistribution: [0.25, 0.20, 0.25, 0.15, 0.15],
    analyticalApproaches: ['Auteur theory', 'Psychoanalytic', 'Feminist', 'Cultural'],
    studentFeedbackScore: 9.3,
    criticalThinkingDevelopment: 'Very High',
    filmTechniqueRecognition: 'Expert',
    shotByShot: true,
    filmStudiesImpact: 'Foundational',
    globalAdoption: 'Standard curriculum',
    academicPaperGeneration: 850
}]->(p);

// Create theme park attraction
CREATE (SoundOfMusicTour:Attraction:GeneratedByClaudeAI {
    name: 'The Original Sound of Music Tour',
    opened: date('1967-05-15'),
    locationLat: 47.8095,
    locationLong: 13.0550,
    visitorCapacity: 250,
    visitorDuration: duration({hours: 4, minutes: 0}),
    annualVisitors: 350000,
    routeLength: 25,
    lengthUnit: 'kilometers',
    developmentCost: 25000,
    interactiveElements: 8,
    historicalSites: 15
})
WITH 1 as dummy
MATCH (a:Attraction:GeneratedByClaudeAI {name: 'The Original Sound of Music Tour'}),
      (s:Movie:GeneratedByClaudeAI {title: 'The Sound of Music'})
CREATE (a)-[:BASED_ON {
    filmElementsFeatured: ['Gazebo', 'Nonnberg Abbey', 'Mirabell Gardens', 'Von Trapp villa exterior'],
    educationalFocus: 0.6,
    entertainmentFocus: 0.4,
    audienceRating: 9.5,
    historicalContextualization: 'Both film and true story',
    originalSitesCurated: 12,
    songPerformanceLocations: 8,
    filmingLocationAccuracy: 'Very high',
    culturalImpactMetrics: ['Tourism boost', 'City identity', 'Film pilgrimage'],
    economicContribution: 37500000
}]->(s);

// Create merchandising relationship
CREATE (AvatarMerchandise:Merchandise:GeneratedByClaudeAI {
    name: 'Avatar Collector\'s Edition Box Set',
    released: date('2010-11-16'),
    manufacturer: '20th Century Fox Home Entertainment',
    manufacturerLocationLat: 34.0746,
    manufacturerLocationLong: -118.3798,
    retailPrice: 99.99,
    priceCurrency: 'USD',
    productionRun: 250000,
    specialFeatures: 15,
    limitedEdition: true,
    packagingInnovation: 'Interactive AR features',
    collectorValue: 'Appreciating'
})
WITH 1 as dummy
MATCH (m:Merchandise:GeneratedByClaudeAI {name: 'Avatar Collector\'s Edition Box Set'}),
      (a:Movie:GeneratedByClaudeAI {title: 'Avatar'})
CREATE (m)-[:DERIVED_FROM {
    licensingDeal: date('2010-02-15'),
    unitsSold: 185000,
    geographicalDistribution: ['North America', 'Europe', 'Asia', 'Australia'],
    salesDistribution: [0.60, 0.25, 0.10, 0.05],
    retailersCarrying: 12500,
    digitalCodeInclusion: true,
    specialContentHours: 8.5,
    brandRecognition: 0.92,
    merchandisingLongevity: 'Still in demand, secondary market',
    collectibleResaleValue: 350
}]->(a);

// Create Contemporary and Classic Film Nodes
CREATE (Titanic:Movie:GeneratedByClaudeAI {
    title: 'Titanic',
    released: 1997,
    tagline: 'Collide with destiny',
    budget: 200000000,
    revenue: 2195170479,
    runtime_minutes: 195,
    rating_avg: 7.9,
    releaseDate: date('1997-12-19'),
    digitalRestoration: datetime('2012-04-04T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Titanic'})
SET m.ratings = [8.0, 7.8, 7.9, 7.9]
SET m.genres = ['romance', 'drama', 'disaster', 'historical']
SET m.certifications = ['PG-13', '12']
SET m.filmingLocationLat = [46.8432, 51.5072, 37.7749]
SET m.filmingLocationLong = [-71.2895, -0.1276, -122.4194]
SET m.boxOfficeNA = 659363944
SET m.boxOfficeInternational = 1535806535
SET m.specialEffectsAwards = 4
SET m.rereleaseDates = [date('2012-04-04'), date('2017-12-01'), date('2023-02-10')];

CREATE (TheGodfather:Movie:GeneratedByClaudeAI {
    title: 'The Godfather',
    released: 1972,
    tagline: 'An offer you can\'t refuse',
    budget: 6000000,
    revenue: 245066411,
    runtime_minutes: 175,
    rating_avg: 9.2,
    releaseDate: date('1972-03-24'),
    digitalRestoration: datetime('2008-09-23T00:00:00Z'),
    isOscarWinner: true,
    isPreservationRegistry: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
SET m.ratings = [9.2, 9.1, 9.3, 9.2]
SET m.genres = ['crime', 'drama']
SET m.certifications = ['R', '18']
SET m.filmingLocationLat = [40.7128, 37.7749, 38.1157]
SET m.filmingLocationLong = [-74.0060, -122.4194, 13.3665]
SET m.boxOfficeNA = 134966411
SET m.boxOfficeInternational = 110100000
SET m.preservationRegistry = 'National Film Registry'
SET m.culturalImpact = 'Transformative';

CREATE (TheDarkKnight:Movie:GeneratedByClaudeAI {
    title: 'The Dark Knight',
    released: 2008,
    tagline: 'Why so serious?',
    budget: 185000000,
    revenue: 1003045358,
    runtime_minutes: 152,
    rating_avg: 9.0,
    releaseDate: date('2008-07-18'),
    digitalRelease: datetime('2008-12-09T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'The Dark Knight'})
SET m.ratings = [9.0, 9.0, 8.9, 9.1]
SET m.genres = ['action', 'crime', 'drama', 'thriller']
SET m.certifications = ['PG-13', '12A']
SET m.filmingLocationLat = [41.8781, 22.3193, 51.5072]
SET m.filmingLocationLong = [-87.6298, 114.1694, -0.1276]
SET m.boxOfficeNA = 533345358
SET m.boxOfficeInternational = 469700000
SET m.iMAXSequences = 6
SET m.posthumousAwards = 1;

CREATE (Pulp_Fiction:Movie:GeneratedByClaudeAI {
    title: 'Pulp Fiction',
    released: 1994,
    tagline: 'You won\'t know the facts until you\'ve seen the fiction',
    budget: 8000000,
    revenue: 213928762,
    runtime_minutes: 154,
    rating_avg: 8.9,
    releaseDate: date('1994-10-14'),
    digitalRestoration: datetime('2011-10-04T00:00:00Z'),
    isOscarWinner: true,
    isPreservationRegistry: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Pulp Fiction'})
SET m.ratings = [8.9, 8.8, 9.0, 8.9]
SET m.genres = ['crime', 'drama']
SET m.certifications = ['R', '18']
SET m.filmingLocationLat = [34.0522, 34.0211, 34.1184]
SET m.filmingLocationLong = [-118.2437, -118.3965, -118.3004]
SET m.boxOfficeNA = 107928762
SET m.boxOfficeInternational = 106000000
SET m.preservationRegistry = 'National Film Registry'
SET m.nonLinearStructure = true;

CREATE (Everything_Everywhere:Movie:GeneratedByClaudeAI {
    title: 'Everything Everywhere All at Once',
    released: 2022,
    tagline: 'The universe is so much bigger than you realize',
    budget: 25000000,
    revenue: 140200000,
    runtime_minutes: 139,
    rating_avg: 8.0,
    releaseDate: date('2022-03-25'),
    digitalRelease: datetime('2022-06-07T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Everything Everywhere All at Once'})
SET m.ratings = [8.1, 7.9, 8.0, 8.0]
SET m.genres = ['comedy', 'action', 'sci-fi', 'drama']
SET m.certifications = ['R', '15']
SET m.filmingLocationLat = [34.0522, 33.7490, 40.7128]
SET m.filmingLocationLong = [-118.2437, -84.3880, -74.0060]
SET m.boxOfficeNA = 77188084
SET m.boxOfficeEurope = 27600000
SET m.boxOfficeAsia = 25400000
SET m.boxOfficeOther = 10011916;

// Create Foreign and Art House Film
CREATE (CrouchingTiger:Movie:GeneratedByClaudeAI {
    title: 'Crouching Tiger, Hidden Dragon',
    released: 2000,
    tagline: 'A timeless story of strength, secrets and two warriors who would never surrender',
    budget: 17000000,
    revenue: 213525736,
    runtime_minutes: 120,
    rating_avg: 7.9,
    releaseDate: date('2000-12-08'),
    digitalRelease: datetime('2001-05-22T00:00:00Z'),
    isOscarWinner: true,
    isInternational: true,
    originalLanguage: 'Mandarin'
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Crouching Tiger, Hidden Dragon'})
SET m.ratings = [7.9, 7.8, 8.0, 7.9]
SET m.genres = ['action', 'adventure', 'drama', 'romance']
SET m.certifications = ['PG-13', '12']
SET m.filmingLocationLat = [39.9042, 25.0330, 29.7604]
SET m.filmingLocationLong = [116.4074, 121.5654, 95.3698]
SET m.boxOfficeNA = 128078872
SET m.boxOfficeInternational = 85446864
SET m.subtitleLanguages = ['English', 'French', 'Spanish', 'German', 'Japanese']
SET m.martialArtsStyles = ['Wudang', 'Baguazhang', 'Tai Chi'];

// Create Directors and Actors
CREATE (KateWinslet:Person:GeneratedByClaudeAI {
    name: 'Kate Winslet',
    born: 1975,
    birthdate: date('1975-10-05'),
    nationality: 'British',
    oscarWins: 1,
    oscarNominations: 7,
    isActive: true,
    firstFilm: datetime('1994-10-28T00:00:00Z'),
    heightInMeters: 1.69,
    netWorth: 65000000,
    methodActingScore: 9.4
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Kate Winslet'})
SET p.languages = ['English', 'French']
SET p.filmography_titles = ['Titanic', 'Eternal Sunshine of the Spotless Mind', 'The Reader']
SET p.filmography_years = [1997, 2004, 2008]
SET p.filmography_roles = ['Rose DeWitt Bukater', 'Clementine Kruczynski', 'Hanna Schmitz'];

CREATE (FrancisFordCoppola:Person:GeneratedByClaudeAI {
    name: 'Francis Ford Coppola',
    born: 1939,
    birthdate: date('1939-04-07'),
    nationality: 'American',
    oscarWins: 5,
    oscarNominations: 14,
    isActive: true,
    firstFilm: datetime('1962-09-28T00:00:00Z'),
    heightInMeters: 1.82,
    netWorth: 400000000,
    wineBusinessOwner: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Francis Ford Coppola'})
SET p.languages = ['English', 'Italian']
SET p.filmography_titles = ['The Godfather', 'The Godfather: Part II', 'Apocalypse Now']
SET p.filmography_years = [1972, 1974, 1979]
SET p.directorStyle = 'Character-driven with technical innovation';

CREATE (HeathLedger:Person:GeneratedByClaudeAI {
    name: 'Heath Ledger',
    born: 1979,
    died: 2008,
    birthdate: date('1979-04-04'),
    deathdate: date('2008-01-22'),
    nationality: 'Australian',
    oscarWins: 1,
    oscarNominations: 1,
    isActive: false,
    firstFilm: datetime('1997-02-15T00:00:00Z'),
    lastFilm: datetime('2009-10-16T00:00:00Z'),
    heightInMeters: 1.85,
    characterImmersion: 'Total'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Heath Ledger'})
SET p.languages = ['English']
SET p.filmography_titles = ['The Dark Knight', 'Brokeback Mountain', '10 Things I Hate About You']
SET p.filmography_years = [2008, 2005, 1999]
SET p.filmography_roles = ['Joker', 'Ennis Del Mar', 'Patrick Verona']
SET p.posthumousAwards = 1;

CREATE (MarionCotillard:Person:GeneratedByClaudeAI {
    name: 'Marion Cotillard',
    born: 1975,
    birthdate: date('1975-09-30'),
    nationality: 'French',
    oscarWins: 1,
    oscarNominations: 2,
    isActive: true,
    firstFilm: datetime('1994-01-15T00:00:00Z'),
    heightInMeters: 1.69,
    netWorth: 40000000,
    musicianExperience: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Marion Cotillard'})
SET p.languages = ['French', 'English', 'Italian']
SET p.filmography_titles = ['La Vie en Rose', 'The Dark Knight Rises', 'Inception']
SET p.filmography_years = [2007, 2012, 2010]
SET p.filmography_roles = ['Édith Piaf', 'Miranda Tate', 'Mal Cobb'];

CREATE (AngLee:Person:GeneratedByClaudeAI {
    name: 'Ang Lee',
    born: 1954,
    birthdate: date('1954-10-23'),
    nationality: 'Taiwanese',
    oscarWins: 2,
    oscarNominations: 4,
    isActive: true,
    firstFilm: datetime('1992-05-04T00:00:00Z'),
    heightInMeters: 1.75,
    netWorth: 32000000,
    genreVersatility: 9.5
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Ang Lee'})
SET p.languages = ['Mandarin', 'English']
SET p.filmography_titles = ['Crouching Tiger, Hidden Dragon', 'Brokeback Mountain', 'Life of Pi']
SET p.filmography_years = [2000, 2005, 2012]
SET p.directorStyle = 'Visually poetic with cross-cultural themes';

CREATE (AlPacino:Person:GeneratedByClaudeAI {
    name: 'Al Pacino',
    born: 1940,
    birthdate: date('1940-04-25'),
    nationality: 'American',
    oscarWins: 1,
    oscarNominations: 9,
    isActive: true,
    firstFilm: datetime('1969-02-25T00:00:00Z'),
    heightInMeters: 1.70,
    netWorth: 120000000,
    methodActingScore: 9.8
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Al Pacino'})
SET p.languages = ['English', 'Italian']
SET p.filmography_titles = ['The Godfather', 'Scarface', 'Heat']
SET p.filmography_years = [1972, 1983, 1995]
SET p.filmography_roles = ['Michael Corleone', 'Tony Montana', 'Lt. Vincent Hanna'];

CREATE (QuentinTarantino:Person:GeneratedByClaudeAI {
    name: 'Quentin Tarantino',
    born: 1963,
    birthdate: date('1963-03-27'),
    nationality: 'American',
    oscarWins: 2,
    oscarNominations: 7,
    isActive: true,
    firstFilm: datetime('1992-01-21T00:00:00Z'),
    heightInMeters: 1.85,
    netWorth: 120000000,
    directorStyle: 'Non-linear narratives with homages'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Quentin Tarantino'})
SET p.languages = ['English']
SET p.filmography_titles = ['Pulp Fiction', 'Reservoir Dogs', 'Django Unchained']
SET p.filmography_years = [1994, 1992, 2012]
SET p.writerDirectorDuality = true;

CREATE (UmaThurman:Person:GeneratedByClaudeAI {
    name: 'Uma Thurman',
    born: 1970,
    birthdate: date('1970-04-29'),
    nationality: 'American',
    oscarNominations: 1,
    isActive: true,
    firstFilm: datetime('1988-06-23T00:00:00Z'),
    heightInMeters: 1.80,
    netWorth: 45000000,
    martialArtsTraining: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Uma Thurman'})
SET p.languages = ['English', 'French', 'German']
SET p.filmography_titles = ['Pulp Fiction', 'Kill Bill: Vol. 1', 'Kill Bill: Vol. 2']
SET p.filmography_years = [1994, 2003, 2004]
SET p.filmography_roles = ['Mia Wallace', 'The Bride', 'The Bride'];

CREATE (KeYinShih:Person:GeneratedByClaudeAI {
    name: 'Michelle Yeoh',
    born: 1962,
    birthdate: date('1962-08-06'),
    nationality: 'Malaysian',
    oscarWins: 1,
    oscarNominations: 1,
    isActive: true,
    firstFilm: datetime('1984-11-16T00:00:00Z'),
    heightInMeters: 1.63,
    netWorth: 40000000,
    martialArtsTraining: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Michelle Yeoh'})
SET p.languages = ['English', 'Malay', 'Cantonese', 'Mandarin']
SET p.filmography_titles = ['Crouching Tiger, Hidden Dragon', 'Everything Everywhere All at Once', 'Tomorrow Never Dies']
SET p.filmography_years = [2000, 2022, 1997]
SET p.filmography_roles = ['Yu Shu Lien', 'Evelyn Wang', 'Wai Lin'];

// Create Studios
CREATE (MiramaxFilms:Studio:GeneratedByClaudeAI {
    name: 'Miramax Films',
    founded: date('1979-10-01'),
    acquired: date('1993-05-21'),
    divested: date('2010-07-30'),
    headquartersLat: 34.0522,
    headquartersLong: -118.2437,
    yearlyRevenue1994: 250000000,
    yearlyRevenue1995: 320000000,
    yearlyRevenue1996: 375000000,
    digitalArchiveCreation: datetime('2005-06-15T00:00:00Z'),
    isActive: true,
    peakMarketShare: 0.08
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Miramax Films'})
SET s.subsidiaries = ['Dimension Films']
SET s.distributionMarkets = ['North America', 'Europe', 'Asia', 'Australia']
SET s.studioLotsLat = [34.0522, 40.7128]
SET s.studioLotsLong = [-118.2437, -74.0060]
SET s.foundedBy = ['Bob Weinstein', 'Harvey Weinstein']
SET s.acquiredBy = 'The Walt Disney Company'
SET s.independentFocus = true;

CREATE (ParamountPictures:Studio:GeneratedByClaudeAI {
    name: 'Paramount Pictures',
    founded: date('1912-05-08'),
    headquartersLat: 34.0841,
    headquartersLong: -118.3213,
    yearlyRevenue2020: 4500000000,
    yearlyRevenue2021: 6800000000,
    yearlyRevenue2022: 7200000000,
    digitalStreamingDate: datetime('2021-03-04T00:00:00Z'),
    isPublic: true,
    marketShare: 0.08,
    studioAge: 111
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Paramount Pictures'})
SET s.subsidiaries = ['Paramount Animation', 'Paramount Players', 'Paramount Television Studios']
SET s.distributionMarkets = ['Global']
SET s.studioLotsLat = [34.0841, 40.7590, 51.5112]
SET s.studioLotsLong = [-118.3213, -73.9845, -0.1198]
SET s.mountainLogo = true;

CREATE (WarnerBros:Studio:GeneratedByClaudeAI {
    name: 'Warner Bros. Pictures',
    founded: date('1923-04-04'),
    headquartersLat: 34.1516,
    headquartersLong: -118.3376,
    yearlyRevenue2020: 12500000000,
    yearlyRevenue2021: 15800000000,
    yearlyRevenue2022: 17200000000,
    digitalStreamingDate: datetime('2021-05-15T00:00:00Z'),
    isPublic: true,
    marketShare: 0.184
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'})
SET s.subsidiaries = ['New Line Cinema', 'DC Films', 'Warner Animation Group']
SET s.distributionMarkets = ['North America', 'Europe', 'Asia', 'Oceania', 'Africa']
SET s.studioLotsLat = [34.1516, 51.5400]
SET s.studioLotsLong = [-118.3376, -0.4178];

CREATE (SonyPictures:Studio:GeneratedByClaudeAI {
    name: 'Sony Pictures Entertainment',
    founded: date('1987-12-21'),
    headquartersLat: 34.0211,
    headquartersLong: -118.3787,
    yearlyRevenue2020: 7870000000,
    yearlyRevenue2021: 9240000000,
    yearlyRevenue2022: 8450000000,
    digitalStreamingDate: datetime('2021-04-08T00:00:00Z'),
    isPublic: true,
    marketShare: 0.095
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Sony Pictures Entertainment'})
SET s.subsidiaries = ['Columbia Pictures', 'TriStar Pictures', 'Sony Pictures Animation']
SET s.distributionMarkets = ['North America', 'Europe', 'Asia', 'Latin America', 'Africa', 'Oceania']
SET s.studioLotsLat = [34.0211, 35.6762]
SET s.studioLotsLong = [-118.3787, 139.6503];

// Create Production Events
CREATE (TitanicProduction:Production:GeneratedByClaudeAI {
    name: 'Titanic Production',
    startDate: date('1996-07-31'),
    endDate: date('1997-03-23'),
    durationMonths: 7,
    durationDays: 23,
    startTime: localtime('06:00:00'),
    isCompleted: true,
    budgetPersonnel: 70000000,
    budgetEquipment: 40000000,
    budgetSets: 50000000,
    budgetVFX: 30000000,
    budgetOther: 10000000,
    weatherGood: 65,
    weatherAcceptable: 25,
    weatherPoor: 10
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Titanic Production'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Underwater Filming', 'Wrap']
SET p.scheduleTimes = ['04:00:00', '05:30:00', '06:00:00', '14:00:00', '19:00:00']
SET p.scheduleDurations = [1.5, 0.5, 8, 5, 1]
SET p.setLocation = 'Rosarito, Mexico'
SET p.replicas = ['90% scale Titanic model', 'Full interior sets'];

CREATE (TheGodfatherProduction:Production:GeneratedByClaudeAI {
    name: 'The Godfather Production',
    startDate: date('1971-03-29'),
    endDate: date('1971-08-07'),
    durationMonths: 4,
    durationDays: 9,
    startTime: localtime('07:00:00'),
    isCompleted: true,
    budgetPersonnel: 2500000,
    budgetEquipment: 1000000,
    budgetLocations: 1500000,
    budgetSets: 800000,
    budgetOther: 200000,
    weatherGood: 80,
    weatherAcceptable: 15,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'The Godfather Production'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['05:00:00', '06:30:00', '07:00:00', '18:00:00']
SET p.scheduleDurations = [1.5, 0.5, 11, 1]
SET p.studioInterference = 'High'
SET p.castingDisputes = 'Multiple';

CREATE (TheDarkKnightProduction:Production:GeneratedByClaudeAI {
    name: 'The Dark Knight Production',
    startDate: date('2007-04-18'),
    endDate: date('2007-11-11'),
    durationMonths: 6,
    durationDays: 24,
    startTime: localtime('06:30:00'),
    isCompleted: true,
    budgetPersonnel: 60000000,
    budgetEquipment: 35000000,
    budgetLocations: 40000000,
    budgetVFX: 40000000,
    budgetOther: 10000000,
    weatherGood: 70,
    weatherAcceptable: 25,
    weatherPoor: 5
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'The Dark Knight Production'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'IMAX Setup', 'Wrap']
SET p.scheduleTimes = ['04:30:00', '06:00:00', '06:30:00', '12:30:00', '19:00:00']
SET p.scheduleDurations = [1.5, 0.5, 6, 6.5, 1]
SET p.citiesFilmed = ['Chicago', 'London', 'Hong Kong']
SET p.iMAXCameras = 6;

CREATE (PulpFictionProduction:Production:GeneratedByClaudeAI {
    name: 'Pulp Fiction Production',
    startDate: date('1993-09-20'),
    endDate: date('1993-11-30'),
    durationMonths: 2,
    durationDays: 10,
    startTime: localtime('07:00:00'),
    isCompleted: true,
    budgetPersonnel: 3000000,
    budgetEquipment: 1500000,
    budgetLocations: 1000000,
    budgetSets: 2000000,
    budgetOther: 500000,
    weatherGood: 90,
    weatherAcceptable: 8,
    weatherPoor: 2
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Pulp Fiction Production'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Filming', 'Wrap']
SET p.scheduleTimes = ['05:00:00', '06:30:00', '07:00:00', '19:00:00']
SET p.scheduleDurations = [1.5, 0.5, 12, 1]
SET p.independentFilming = true
SET p.filmingDays = 51;

CREATE (CrouchingTigerProduction:Production:GeneratedByClaudeAI {
    name: 'Crouching Tiger, Hidden Dragon Production',
    startDate: date('1999-04-15'),
    endDate: date('1999-09-17'),
    durationMonths: 5,
    durationDays: 2,
    startTime: localtime('05:30:00'),
    isCompleted: true,
    budgetPersonnel: 6000000,
    budgetEquipment: 3000000,
    budgetLocations: 3500000,
    budgetVFX: 3000000,
    budgetOther: 1500000,
    weatherGood: 60,
    weatherAcceptable: 30,
    weatherPoor: 10
})
WITH 1 as dummy
MATCH (p:Production:GeneratedByClaudeAI {name: 'Crouching Tiger, Hidden Dragon Production'})
SET p.scheduleActivities = ['Makeup', 'Rehearsal', 'Martial Arts Prep', 'Filming', 'Wrap']
SET p.scheduleTimes = ['03:30:00', '05:00:00', '05:30:00', '08:00:00', '19:00:00']
SET p.scheduleDurations = [1.5, 0.5, 2.5, 11, 1]
SET p.wireworkDays = 68
SET p.challengingLocations = ['Bamboo forest', 'Desert', 'Historic sites'];

// Add reviews
CREATE (TitanicReview:Review:GeneratedByClaudeAI {
    title: 'The Spectacle and Heart of Titanic',
    stars: 4.8,
    date: date('1997-12-22'),
    time: time('14:30:00-05:00'),
    isVerified: true,
    aspectDirection: 4.9,
    aspectActing: 4.7,
    aspectVisuals: 5.0,
    aspectMusic: 4.9,
    aspectEmotionalImpact: 4.8,
    reviewText: 'James Cameron\'s Titanic is a towering achievement that masterfully blends historical tragedy with intimate romance. The film\'s technical achievements are breathtaking, while DiCaprio and Winslet\'s performances ensure the human story remains captivating throughout the epic three-hour runtime.',
    upvotes: 24563
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'The Spectacle and Heart of Titanic'})
SET r.commentTimestamps = [datetime('1997-12-22T16:45:22-05:00'), datetime('1997-12-23T09:15:34-05:00'), datetime('1997-12-24T18:22:51-05:00')]
SET r.keywords = ['historical', 'romance', 'disaster', 'epic']
SET r.readerLocationsLat = [40.7128, 51.5074, 34.0522]
SET r.readerLocationsLong = [-74.0060, -0.1278, -118.2437];

CREATE (TheGodfatherReview:Review:GeneratedByClaudeAI {
    title: 'The Definitive American Crime Epic',
    stars: 5.0,
    date: date('1972-04-02'),
    time: time('11:30:00-05:00'),
    isVerified: true,
    aspectDirection: 5.0,
    aspectActing: 5.0,
    aspectWriting: 5.0,
    aspectCinematography: 5.0,
    aspectMusicScore: 5.0,
    reviewText: 'Francis Ford Coppola\'s The Godfather is filmmaking at its most sublime, a perfect confluence of outstanding performances, rich storytelling, and visual artistry. Marlon Brando\'s Don Corleone and Al Pacino\'s Michael create an unforgettable dramatic arc as the film explores themes of family, power, and the American Dream through the lens of organized crime.',
    historicalRelevance: 'Genre-defining'
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'The Definitive American Crime Epic'})
SET r.culturalImpactAssessments = [date('1982-04-02'), date('2002-04-02'), date('2022-04-02')]
SET r.historicalSignificanceRatings = [9.5, 9.8, 9.9]
SET r.assessmentYears = [1982, 2002, 2022]
SET r.keywords = ['crime', 'family', 'power', 'masterpiece', 'italian-american']
SET r.academicCitations = 3842;

CREATE (TheDarkKnightReview:Review:GeneratedByClaudeAI {
    title: 'A Revolutionary Superhero Film',
    stars: 4.9,
    date: date('2008-07-21'),
    time: time('18:45:30-04:00'),
    isVerified: true,
    aspectDirection: 4.9,
    aspectActing: 5.0,
    aspectWriting: 4.8,
    aspectCinematography: 4.9,
    aspectScore: 4.8,
    reviewText: 'Christopher Nolan\'s The Dark Knight transcends its superhero origins to deliver a gripping crime thriller with psychological depth. Heath Ledger\'s anarchic, terrifying Joker redefines the concept of the cinematic villain, while the film explores complex ethical themes about heroism, sacrifice, and the thin line between order and chaos.',
    upvotes: 35784
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'A Revolutionary Superhero Film'})
SET r.commentTimestamps = [datetime('2008-07-21T20:15:48-04:00'), datetime('2008-07-22T09:32:14-04:00'), datetime('2008-07-23T15:45:29-04:00')]
SET r.keywords = ['superhero', 'crime-thriller', 'joker', 'ethical-dilemma', 'imax']
SET r.readerLocationsLat = [40.7128, 34.0522, 41.8781]
SET r.readerLocationsLong = [-74.0060, -118.2437, -87.6298];

CREATE (PulpFictionReview:Review:GeneratedByClaudeAI {
    title: 'Tarantino\'s Narrative Masterpiece',
    stars: 5.0,
    date: date('1994-10-18'),
    time: time('15:20:00-04:00'),
    isVerified: true,
    aspectDirection: 5.0,
    aspectActing: 4.9,
    aspectWriting: 5.0,
    aspectStructure: 5.0,
    aspectDialogue: 5.0,
    reviewText: 'Pulp Fiction revolutionizes storytelling with its non-linear narrative and razor-sharp dialogue. Tarantino weaves together three interconnected crime stories with stylistic flair, creating moments both brutally violent and unexpectedly humorous. The ensemble cast delivers unforgettable performances in a film that permanently altered the landscape of independent cinema.',
    upvotes: 28935
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'Tarantino\'s Narrative Masterpiece'})
SET r.commentTimestamps = [datetime('1994-10-18T17:45:22-04:00'), datetime('1994-10-19T10:15:34-04:00'), datetime('1994-10-20T14:22:51-04:00')]
SET r.keywords = ['non-linear', 'crime', 'dialogue', 'indie', 'pop-culture']
SET r.readerLocationsLat = [40.7128, 34.0522, 51.5074]
SET r.readerLocationsLong = [-74.0060, -118.2437, -0.1278];

CREATE (CrouchingTigerReview:Review:GeneratedByClaudeAI {
    title: 'A Graceful Blend of Action and Poetry',
    stars: 4.8,
    date: date('2000-12-15'),
    time: time('19:45:00-05:00'),
    isVerified: true,
    aspectDirection: 4.9,
    aspectActing: 4.8,
    aspectVisuals: 5.0,
    aspectMartialArts: 5.0,
    aspectEmotionalDepth: 4.7,
    reviewText: 'Ang Lee\'s Crouching Tiger, Hidden Dragon elevates martial arts cinema to high art. The breathtaking fight choreography functions as visual poetry, with gravity-defying wire work that feels like an extension of the characters\' emotions. Beyond the spectacular action, the film is a moving exploration of honor, forbidden love, and personal freedom against the backdrop of Qing Dynasty China.',
    upvotes: 18452
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'A Graceful Blend of Action and Poetry'})
SET r.commentTimestamps = [datetime('2000-12-15T21:12:33-05:00'), datetime('2000-12-16T10:45:22-05:00'), datetime('2000-12-17T14:36:51-05:00')]
SET r.keywords = ['martial-arts', 'wuxia', 'visual-poetry', 'honor', 'foreign-language']
SET r.readerLocationsLat = [40.7128, 34.0522, 37.7749]
SET r.readerLocationsLong = [-74.0060, -118.2437, -122.4194];

// Create relationships between nodes
MATCH 
  (j:Person:GeneratedByClaudeAI {name: 'James Cameron'}),
  (t:Movie:GeneratedByClaudeAI {title: 'Titanic'})
CREATE (j)-[:DIRECTED {
    year: 1997,
    daysOnSet: 160,
    satisfaction: 4.8,
    awardNominations: 14,
    awardWins: 11,
    completionDate: date('1997-07-31'),
    premiereEvent: datetime('1997-12-14T19:30:00-05:00'),
    durationMonths: 7,
    budgetOverruns: true,
    scheduleOverruns: true
}]->(t);

MATCH 
  (f:Person:GeneratedByClaudeAI {name: 'Francis Ford Coppola'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (f)-[:DIRECTED {
    year: 1972,
    daysOnSet: 112,
    satisfaction: 4.7,
    awardNominations: 11,
    awardWins: 3,
    completionDate: date('1971-11-25'),
    premiereEvent: datetime('1972-03-14T20:00:00-05:00'),
    durationMonths: 4,
    studioFights: true,
    castingBattles: 'Significant'
}]->(g);

MATCH 
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (d:Movie:GeneratedByClaudeAI {title: 'The Dark Knight'})
CREATE (c)-[:DIRECTED {
    year: 2008,
    daysOnSet: 127,
    satisfaction: 4.9,
    awardNominations: 8,
    awardWins: 2,
    completionDate: date('2008-04-15'),
    premiereEvent: datetime('2008-07-14T19:00:00-04:00'),
    durationMonths: 6,
    iMAXUsage: 'Extensive',
    practicalEffectsPercentage: 70
}]->(d);

MATCH 
  (q:Person:GeneratedByClaudeAI {name: 'Quentin Tarantino'}),
  (p:Movie:GeneratedByClaudeAI {title: 'Pulp Fiction'})
CREATE (q)-[:DIRECTED {
    year: 1994,
    daysOnSet: 51,
    satisfaction: 4.9,
    awardNominations: 7,
    awardWins: 1,
    completionDate: date('1994-01-30'),
    premiereEvent: datetime('1994-05-21T20:30:00+02:00'),
    durationMonths: 2,
    scriptToScreen: 'Nearly identical',
    nonLinearExperiment: true
}]->(p);

MATCH 
  (a:Person:GeneratedByClaudeAI {name: 'Ang Lee'}),
  (c:Movie:GeneratedByClaudeAI {title: 'Crouching Tiger, Hidden Dragon'})
CREATE (a)-[:DIRECTED {
    year: 2000,
    daysOnSet: 135,
    satisfaction: 4.8,
    awardNominations: 10,
    awardWins: 4,
    completionDate: date('1999-12-25'),
    premiereEvent: datetime('2000-05-18T21:00:00+02:00'),
    durationMonths: 5,
    crossCulturalChallenges: true,
    actionChoreography: 'Revolutionary'
}]->(c);

// Actor to Movie relationships
MATCH
  (k:Person:GeneratedByClaudeAI {name: 'Kate Winslet'}),
  (t:Movie:GeneratedByClaudeAI {title: 'Titanic'})
CREATE (k)-[:ACTED_IN {
    roles: ['Rose DeWitt Bukater'],
    salary: 2000000,
    screenTimeMinutes: 120,
    startDate: date('1996-07-31'),
    endDate: date('1997-03-23'),
    scheduleConflicts: false,
    criticScore: 94,
    audienceScore: 95,
    awardNominations: 2,
    awardWins: 0,
    underwaterScenes: 7
}]->(t);

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Al Pacino'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (a)-[:ACTED_IN {
    roles: ['Michael Corleone'],
    salary: 35000,
    screenTimeMinutes: 95,
    startDate: date('1971-03-29'),
    endDate: date('1971-08-07'),
    scheduleConflicts: false,
    criticScore: 98,
    audienceScore: 97,
    awardNominations: 1,
    awardWins: 0,
    studioOpposition: true
}]->(g);

MATCH
  (h:Person:GeneratedByClaudeAI {name: 'Heath Ledger'}),
  (d:Movie:GeneratedByClaudeAI {title: 'The Dark Knight'})
CREATE (h)-[:ACTED_IN {
    roles: ['Joker'],
    salary: 5000000,
    screenTimeMinutes: 33,
    startDate: date('2007-04-18'),
    endDate: date('2007-08-25'),
    scheduleConflicts: false,
    criticScore: 99,
    audienceScore: 98,
    awardNominations: 10,
    awardWins: 8,
    characterImmersion: 'Extreme'
}]->(d);

MATCH
  (u:Person:GeneratedByClaudeAI {name: 'Uma Thurman'}),
  (p:Movie:GeneratedByClaudeAI {title: 'Pulp Fiction'})
CREATE (u)-[:ACTED_IN {
    roles: ['Mia Wallace'],
    salary: 500000,
    screenTimeMinutes: 28,
    startDate: date('1993-09-20'),
    endDate: date('1993-10-15'),
    scheduleConflicts: false,
    criticScore: 96,
    audienceScore: 95,
    awardNominations: 1,
    awardWins: 0,
    iconicScenes: ['Twist contest', 'Adrenaline shot']
}]->(p);

MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Michelle Yeoh'}),
  (c:Movie:GeneratedByClaudeAI {title: 'Crouching Tiger, Hidden Dragon'})
CREATE (m)-[:ACTED_IN {
    roles: ['Yu Shu Lien'],
    salary: 1000000,
    screenTimeMinutes: 95,
    startDate: date('1999-04-15'),
    endDate: date('1999-09-17'),
    scheduleConflicts: false,
    criticScore: 97,
    audienceScore: 94,
    awardNominations: 5,
    awardWins: 2,
    martialArtsPerformed: true,
    stuntPercentage: 90
}]->(c);

// Studio relationships
MATCH
  (p:Studio:GeneratedByClaudeAI {name: 'Paramount Pictures'}),
  (t:Movie:GeneratedByClaudeAI {title: 'Titanic'})
CREATE (p)-[:PRODUCED {
    investment: 100000000,
    return: 1097585239,
    roi: 10.98,
    contractSigned: date('1995-12-15'),
    studioShare: 0.5,
    directorShare: 0.25,
    producerShare: 0.15,
    topCastShare: 0.1,
    marketingBudget: 50000000,
    isProfitable: true,
    marketingStart: datetime('1997-06-15T00:00:00Z'),
    coProduction: 'Fox'
}]->(t);

MATCH
  (p:Studio:GeneratedByClaudeAI {name: 'Paramount Pictures'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (p)-[:PRODUCED {
    investment: 6000000,
    return: 245066411,
    roi: 40.84,
    contractSigned: date('1970-09-15'),
    studioShare: 0.7,
    directorShare: 0.1,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 1000000,
    isProfitable: true,
    marketingStart: datetime('1972-01-15T00:00:00Z'),
    executiveOpposition: true
}]->(g);

MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (d:Movie:GeneratedByClaudeAI {title: 'The Dark Knight'})
CREATE (w)-[:PRODUCED {
    investment: 185000000,
    return: 1003045358,
    roi: 5.42,
    contractSigned: date('2006-08-22'),
    studioShare: 0.6,
    directorShare: 0.2,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 100000000,
    isProfitable: true,
    marketingStart: datetime('2007-12-15T00:00:00Z'),
    franchiseEntry: 2
}]->(d);

MATCH
  (m:Studio:GeneratedByClaudeAI {name: 'Miramax Films'}),
  (p:Movie:GeneratedByClaudeAI {title: 'Pulp Fiction'})
CREATE (m)-[:PRODUCED {
    investment: 8000000,
    return: 213928762,
    roi: 26.74,
    contractSigned: date('1993-04-15'),
    studioShare: 0.6,
    directorShare: 0.2,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 10000000,
    isProfitable: true,
    marketingStart: datetime('1994-05-30T00:00:00Z'),
    festivalStrategy: 'Cannes premiere'
}]->(p);

MATCH
  (s:Studio:GeneratedByClaudeAI {name: 'Sony Pictures Entertainment'}),
  (c:Movie:GeneratedByClaudeAI {title: 'Crouching Tiger, Hidden Dragon'})
CREATE (s)-[:PRODUCED {
    investment: 17000000,
    return: 213525736,
    roi: 12.56,
    contractSigned: date('1998-08-15'),
    studioShare: 0.55,
    directorShare: 0.15,
    producerShare: 0.15,
    topCastShare: 0.15,
    marketingBudget: 15000000,
    isProfitable: true,
    marketingStart: datetime('2000-09-15T00:00:00Z'),
    internationalFocus: true
}]->(c);

// Studio to filming relationship
MATCH
  (p:Studio:GeneratedByClaudeAI {name: 'Paramount Pictures'}),
  (t:Production:GeneratedByClaudeAI {name: 'Titanic Production'})
CREATE (p)-[:FINANCED {
    contractDate: date('1995-12-15'),
    amount: 100000000,
    isFullyPaid: true,
    transferTime1: datetime('1996-01-15T00:00:00Z'),
    transferTime2: datetime('1996-06-15T00:00:00Z'),
    transferTime3: datetime('1996-12-15T00:00:00Z'),
    paymentDate1: date('1996-01-15'),
    paymentAmount1: 30000000,
    paymentDate2: date('1996-06-15'),
    paymentAmount2: 40000000,
    paymentDate3: date('1996-12-15'),
    paymentAmount3: 30000000,
    costOverrunConcerns: 'Significant'
}]->(t);

MATCH
  (p:Studio:GeneratedByClaudeAI {name: 'Paramount Pictures'}),
  (g:Production:GeneratedByClaudeAI {name: 'The Godfather Production'})
CREATE (p)-[:FINANCED {
    contractDate: date('1970-09-15'),
    amount: 6000000,
    isFullyPaid: true,
    transferTime1: datetime('1970-12-01T00:00:00Z'),
    transferTime2: datetime('1971-03-01T00:00:00Z'),
    paymentDate1: date('1970-12-01'),
    paymentAmount1: 3000000,
    paymentDate2: date('1971-03-01'),
    paymentAmount2: 3000000,
    budgetControl: 'Strict',
    producerOversight: 'Heavy'
}]->(g);

MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (d:Production:GeneratedByClaudeAI {name: 'The Dark Knight Production'})
CREATE (w)-[:FINANCED {
    contractDate: date('2006-08-22'),
    amount: 185000000,
    isFullyPaid: true,
    transferTime1: datetime('2007-01-15T00:00:00Z'),
    transferTime2: datetime('2007-04-15T00:00:00Z'),
    transferTime3: datetime('2007-07-15T00:00:00Z'),
    paymentDate1: date('2007-01-15'),
    paymentAmount1: 60000000,
    paymentDate2: date('2007-04-15'),
    paymentAmount2: 70000000,
    paymentDate3: date('2007-07-15'),
    paymentAmount3: 55000000,
    tentpoleStatus: true
}]->(d);

MATCH
  (m:Studio:GeneratedByClaudeAI {name: 'Miramax Films'}),
  (p:Production:GeneratedByClaudeAI {name: 'Pulp Fiction Production'})
CREATE (m)-[:FINANCED {
    contractDate: date('1993-04-15'),
    amount: 8000000,
    isFullyPaid: true,
    transferTime1: datetime('1993-07-01T00:00:00Z'),
    transferTime2: datetime('1993-09-01T00:00:00Z'),
    paymentDate1: date('1993-07-01'),
    paymentAmount1: 4000000,
    paymentDate2: date('1993-09-01'),
    paymentAmount2: 4000000,
    independentBudgeting: true,
    tightControls: true
}]->(p);

// Filming to movie relationship
MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Titanic Production'}),
  (t:Movie:GeneratedByClaudeAI {title: 'Titanic'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 7,
    durationDays: 23,
    locationCount: 5,
    setCount: 35,
    dailyAverageCost: 450000,
    scheduleAdherence: 0.75,
    weatherDelaysDays: 15,
    originalScheduledEnd: date('1997-01-15'),
    budgetOverrun: 0.3,
    scheduleOverrun: 0.4
}]->(t);

MATCH
  (p:Production:GeneratedByClaudeAI {name: 'The Godfather Production'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 4,
    durationDays: 9,
    locationCount: 12,
    setCount: 24,
    dailyAverageCost: 45000,
    scheduleAdherence: 0.85,
    weatherDelaysDays: 6,
    originalScheduledEnd: date('1971-07-20'),
    castingDisputes: 'Major',
    studioInterference: 'Significant'
}]->(g);

MATCH
  (p:Production:GeneratedByClaudeAI {name: 'The Dark Knight Production'}),
  (d:Movie:GeneratedByClaudeAI {title: 'The Dark Knight'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 6,
    durationDays: 24,
    locationCount: 10,
    setCount: 28,
    dailyAverageCost: 430000,
    scheduleAdherence: 0.9,
    weatherDelaysDays: 12,
    originalScheduledEnd: date('2007-10-30'),
    iMAXPercentage: 28,
    practicalEffects: 'Extensive'
}]->(d);

MATCH
  (p:Production:GeneratedByClaudeAI {name: 'Pulp Fiction Production'}),
  (pf:Movie:GeneratedByClaudeAI {title: 'Pulp Fiction'})
CREATE (p)-[:FOR_MOVIE {
    isCompleted: true,
    durationMonths: 2,
    durationDays: 10,
    locationCount: 25,
    setCount: 18,
    dailyAverageCost: 75000,
    scheduleAdherence: 0.95,
    weatherDelaysDays: 3,
    originalScheduledEnd: date('1993-11-25'),
    castChemistry: 'Exceptional',
    improvisationLevel: 'Moderate'
}]->(pf);

// Award relationships
MATCH
  (t:Movie:GeneratedByClaudeAI {title: 'Titanic'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (t)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 1998,
    ceremony: 70,
    isWinner: true,
    ceremonyDate: date('1998-03-23'),
    announcementTime: localtime('21:45:00'),
    votesFor: 4862,
    votesAgainst: 2153,
    totalOscars: 11,
    recordTying: true
}]->(a);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'James Cameron'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (j)-[:NOMINATED_FOR {
    category: 'Best Director',
    year: 1998,
    ceremony: 70,
    isWinner: true,
    ceremonyDate: date('1998-03-23'),
    announcementTime: localtime('21:15:00'),
    votesFor: 4715,
    votesAgainst: 2300,
    speechDuration: duration({minutes: 2, seconds: 45}),
    speechMemorable: true,
    quotedLine: 'I\'m the king of the world!'
}]->(a);

MATCH
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (g)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 1973,
    ceremony: 45,
    isWinner: true,
    ceremonyDate: date('1973-03-27'),
    announcementTime: localtime('21:45:00'),
    votesFor: 3982,
    votesAgainst: 1573,
    controversies: 'Marlon Brando boycott',
    culturalImpact: 'Groundbreaking'
}]->(a);

MATCH
  (h:Person:GeneratedByClaudeAI {name: 'Heath Ledger'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (h)-[:NOMINATED_FOR {
    category: 'Best Supporting Actor',
    year: 2009,
    ceremony: 81,
    isWinner: true,
    ceremonyDate: date('2009-02-22'),
    announcementTime: localtime('20:45:00'),
    votesFor: 5823,
    votesAgainst: 842,
    posthumousAward: true,
    acceptedBy: 'Family',
    emotionalImpact: 'Significant'
}]->(a);

MATCH
  (p:Movie:GeneratedByClaudeAI {title: 'Pulp Fiction'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (p)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 1995,
    ceremony: 67,
    isWinner: false,
    ceremonyDate: date('1995-03-27'),
    announcementTime: localtime('21:45:00'),
    votesFor: 3254,
    votesAgainst: 3645,
    competitionWinner: 'Forrest Gump',
    indieBreakthrough: true
}]->(a);

MATCH
  (q:Person:GeneratedByClaudeAI {name: 'Quentin Tarantino'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (q)-[:NOMINATED_FOR {
    category: 'Best Original Screenplay',
    year: 1995,
    ceremony: 67,
    isWinner: true,
    ceremonyDate: date('1995-03-27'),
    announcementTime: localtime('20:15:00'),
    votesFor: 4215,
    votesAgainst: 2682,
    speechDuration: duration({minutes: 1, seconds: 50}),
    independentCelebration: true
}]->(a);

MATCH
  (c:Movie:GeneratedByClaudeAI {title: 'Crouching Tiger, Hidden Dragon'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (c)-[:NOMINATED_FOR {
    category: 'Best Foreign Language Film',
    year: 2001,
    ceremony: 73,
    isWinner: true,
    ceremonyDate: date('2001-03-25'),
    announcementTime: localtime('20:30:00'),
    votesFor: 4561,
    votesAgainst: 1823,
    broadestRecognition: 'Foreign language film',
    additionalNominations: 9
}]->(a);

// Professional relationships between people
MATCH
  (j:Person:GeneratedByClaudeAI {name: 'James Cameron'}),
  (k:Person:GeneratedByClaudeAI {name: 'Kate Winslet'})
CREATE (j)-[:DIRECTED_ACTOR {
    films: 1,
    firstFilm: 'Titanic',
    firstYear: 1997,
    chemistry: 4.2,
    conflicts: 'Notable',
    intensityLevel: 'Very high',
    futurePlans: 'None stated',
    reconciliation: true
}]->(k);

MATCH
  (f:Person:GeneratedByClaudeAI {name: 'Francis Ford Coppola'}),
  (a:Person:GeneratedByClaudeAI {name: 'Al Pacino'})
CREATE (f)-[:DIRECTED_ACTOR {
    films: 3,
    firstFilm: 'The Godfather',
    firstYear: 1972,
    chemistry: 4.9,
    conflicts: 'Minimal',
    intensityLevel: 'High',
    collaborationQuotes: 'Career defining',
    artisticPartnership: 'Legendary'
}]->(a);

MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (h:Person:GeneratedByClaudeAI {name: 'Heath Ledger'})
CREATE (c)-[:DIRECTED_ACTOR {
    films: 1,
    firstFilm: 'The Dark Knight',
    firstYear: 2008,
    chemistry: 5.0,
    conflicts: 'None',
    intensityLevel: 'Very high',
    characterCreation: 'Collaborative',
    characterOwnership: 'Actor-driven',
    respectLevel: 'Profound'
}]->(h);

MATCH
  (q:Person:GeneratedByClaudeAI {name: 'Quentin Tarantino'}),
  (u:Person:GeneratedByClaudeAI {name: 'Uma Thurman'})
CREATE (q)-[:DIRECTED_ACTOR {
    films: 3,
    firstFilm: 'Pulp Fiction',
    firstYear: 1994,
    chemistry: 4.9,
    conflicts: 'Later projects',
    intensityLevel: 'Very high',
    museCategorization: true,
    collaborationLongevity: 'Multi-decade',
    inspirationLevel: 'Significant'
}]->(u);

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Ang Lee'}),
  (m:Person:GeneratedByClaudeAI {name: 'Michelle Yeoh'})
CREATE (a)-[:DIRECTED_ACTOR {
    films: 1,
    firstFilm: 'Crouching Tiger, Hidden Dragon',
    firstYear: 2000,
    chemistry: 4.8,
    conflicts: 'None',
    intensityLevel: 'Moderate',
    languageBarrier: 'Minimal',
    physicalDemands: 'Extreme',
    mutualRespect: 'Very high'
}]->(m);

// Create soundtracks
CREATE (TitanicSoundtrack:Soundtrack:GeneratedByClaudeAI {
    title: 'Titanic: Music from the Motion Picture',
    composer: 'James Horner',
    released: date('1997-11-18'),
    duration: duration({minutes: 72, seconds: 38}),
    trackCount: 15,
    recordingStudio: 'Air Lyndhurst Studios',
    recordingStudioLat: 51.5689,
    recordingStudioLong: -0.1781,
    peakChartPosition: 1,
    weeksAtNumberOne: 16,
    salesUnits: 30000000,
    streamingCount: 320000000
})
WITH 1 as dummy
MATCH (t:Movie:GeneratedByClaudeAI {title: 'Titanic'}),
      (s:Soundtrack:GeneratedByClaudeAI {title: 'Titanic: Music from the Motion Picture'})
CREATE (s)-[:COMPOSED_FOR {
    contractDate: date('1996-05-15'),
    completion: date('1997-08-25'),
    nominatedAwards: ['Academy Award', 'Golden Globe', 'Grammy Award'],
    wonAwards: ['Academy Award', 'Golden Globe', 'Grammy Award'],
    diamondCertification: true,
    iconicSongs: ['My Heart Will Go On'],
    vocalistFeatured: 'Celine Dion',
    orchestraSize: 85,
    recordingDays: 25
}]->(t);

CREATE (TheGodfatherSoundtrack:Soundtrack:GeneratedByClaudeAI {
    title: 'The Godfather: Music from the Original Motion Picture Soundtrack',
    composer: 'Nino Rota',
    released: date('1972-03-07'),
    duration: duration({minutes: 31, seconds: 24}),
    trackCount: 11,
    recordingStudio: 'Paramount Studios',
    recordingStudioLat: 34.0841,
    recordingStudioLong: -118.3213,
    peakChartPosition: 45,
    salesUnits: 500000,
    streamingCount: 150000000,
    culturalInfluence: 'Definitive'
})
WITH 1 as dummy
MATCH (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'}),
      (s:Soundtrack:GeneratedByClaudeAI {title: 'The Godfather: Music from the Original Motion Picture Soundtrack'})
CREATE (s)-[:COMPOSED_FOR {
    contractDate: date('1971-02-15'),
    completion: date('1971-11-10'),
    nominatedAwards: ['Academy Award', 'Grammy Award'],
    wonAwards: [],
    disqualificationReason: 'Previous usage',
    iconicThemes: ['Love Theme', 'The Godfather Waltz'],
    culturalResonance: 'Immediate and lasting',
    ethnicInfluences: 'Sicilian folk music',
    orchestraSize: 65
}]->(g);

// Create filming locations
CREATE (MexicoLocation:FilmingLocation:GeneratedByClaudeAI {
    name: 'Baja Studios',
    country: 'Mexico',
    region: 'Baja California',
    latitude: 32.3662,
    longitude: -117.0723,
    elevation: 10,
    elevationUnit: 'm',
    climate: 'Mediterranean',
    permitCost: 15000000,
    permitCurrency: 'USD',
    firstUsed: date('1996-07-31'),
    lastUsed: date('1997-03-23'),
    purpose: 'Water tank filming'
})
WITH 1 as dummy
MATCH (t:Movie:GeneratedByClaudeAI {title: 'Titanic'}),
      (l:FilmingLocation:GeneratedByClaudeAI {name: 'Baja Studios'})
CREATE (t)-[:FILMED_AT {
    startDate: date('1996-07-31'),
    endDate: date('1997-03-23'),
    sceneCount: 95,
    totalDays: 160,
    weatherDelayDays: 15,
    crewSize: 850,
    logisticsCost: 25000000,
    accommodationCost: 15000000,
    setConstruction: 'Full-size ship sections',
    waterTankGallons: 17000000,
    specialRequirements: 'Gimbal systems for sinking sequences'
}]->(l);

CREATE (ChicagoLocation:FilmingLocation:GeneratedByClaudeAI {
    name: 'Chicago',
    country: 'USA',
    region: 'Illinois',
    latitude: 41.8781,
    longitude: -87.6298,
    elevation: 182,
    elevationUnit: 'm',
    climate: 'Continental',
    permitCost: 8000000,
    permitCurrency: 'USD',
    firstUsed: date('2007-04-18'),
    lastUsed: date('2007-08-24'),
    buildingAccess: 'Multiple skyscrapers'
})
WITH 1 as dummy
MATCH (d:Movie:GeneratedByClaudeAI {title: 'The Dark Knight'}),
      (l:FilmingLocation:GeneratedByClaudeAI {name: 'Chicago'})
CREATE (d)-[:FILMED_AT {
    startDate: date('2007-04-18'),
    endDate: date('2007-08-24'),
    sceneCount: 75,
    totalDays: 95,
    weatherDelayDays: 8,
    crewSize: 450,
    logisticsCost: 15000000,
    accommodationCost: 8000000,
    characterPresent: ['Batman', 'Joker', 'Harvey Dent'],
    buildingsUsed: ['Sears Tower', 'Trump Tower', 'Board of Trade'],
    streetClosures: 42,
    helicopterShots: 28
}]->(l);

// Create costume designers
CREATE (JanetPatterson:Person:GeneratedByClaudeAI {
    name: 'Janet Patterson',
    born: 1956,
    died: 2016,
    birthdate: date('1956-06-27'),
    deathdate: date('2016-10-21'),
    nationality: 'Australian',
    oscarNominations: 4,
    isActive: false,
    firstFilm: datetime('1986-06-15T00:00:00Z'),
    lastFilm: datetime('2015-11-22T00:00:00Z'),
    careerLength: duration({years: 29}),
    specialization: 'Period Costume Design'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Janet Patterson'}),
      (t:Movie:GeneratedByClaudeAI {title: 'Titanic'})
CREATE (p)-[:DESIGNED_COSTUMES_FOR {
    year: 1997,
    costumesCreated: 1250,
    budget: 8500000,
    awardNominations: 1,
    awardWins: 1,
    startDate: date('1995-11-15'),
    completionDate: date('1996-07-15'),
    specialCostumes: ['Rose\'s boarding suit', 'Rose\'s evening gown', 'Flying dress'],
    researchHours: 850,
    historicalAccuracy: 'Very high',
    costumesSubmerged: 450
}]->(t);

CREATE (LindiHemming:Person:GeneratedByClaudeAI {
    name: 'Lindy Hemming',
    born: 1948,
    birthdate: date('1948-05-21'),
    nationality: 'British',
    oscarWins: 1,
    oscarNominations: 1,
    isActive: true,
    firstFilm: datetime('1985-06-15T00:00:00Z'),
    careerLength: duration({years: 38}),
    specialization: 'Character-driven Costume Design'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Lindy Hemming'}),
      (d:Movie:GeneratedByClaudeAI {title: 'The Dark Knight'})
CREATE (p)-[:DESIGNED_COSTUMES_FOR {
    year: 2008,
    costumesCreated: 650,
    budget: 6500000,
    awardNominations: 3,
    awardWins: 1,
    startDate: date('2006-12-15'),
    completionDate: date('2007-04-05'),
    specialCostumes: ['Batsuit', 'Joker costume', 'Two-Face makeup'],
    researchHours: 450,
    characterEmphasis: 'Psychological aspects',
    functionalDesign: true,
    batSuitIterations: 15
}]->(d);

// Create cinematographer relationships
CREATE (RussellCarpenter:Person:GeneratedByClaudeAI {
    name: 'Russell Carpenter',
    born: 1950,
    birthdate: date('1950-12-09'),
    nationality: 'American',
    oscarWins: 1,
    oscarNominations: 1,
    isActive: true,
    firstFilm: datetime('1983-05-15T00:00:00Z'),
    visualStyle: 'Cinematic grandeur with intimate moments',
    cameraPreference: 'Panavision',
    collaborations: 3
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Russell Carpenter'}),
      (t:Movie:GeneratedByClaudeAI {title: 'Titanic'})
CREATE (p)-[:CINEMATOGRAPHY_FOR {
    year: 1997,
    cameras: ['Panavision Panaflex Platinum', 'Panavision Panaflex Gold'],
    lenses: ['Panavision Primo', 'Panavision Super High Speed'],
    awardNominations: 5,
    awardWins: 1,
    startDate: date('1996-07-31'),
    completionDate: date('1997-03-23'),
    signature_shots: ['Bow flying scene', 'Grand staircase', 'Underwater corridors'],
    lighting_setups: 485,
    underwaterChallenges: true,
    epochalCinematography: true
}]->(t);

CREATE (GordonWillis:Person:GeneratedByClaudeAI {
    name: 'Gordon Willis',
    born: 1931,
    died: 2014,
    birthdate: date('1931-05-28'),
    deathdate: date('2014-05-18'),
    nationality: 'American',
    oscarNominations: 2,
    oscarHonoraryAward: true,
    isActive: false,
    firstFilm: datetime('1970-01-18T00:00:00Z'),
    lastFilm: datetime('1997-09-16T00:00:00Z'),
    careerLength: duration({years: 27}),
    visualStyle: 'Chiaroscuro lighting with deep shadows',
    nickname: 'Prince of Darkness'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Gordon Willis'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (p)-[:CINEMATOGRAPHY_FOR {
    year: 1972,
    cameras: ['Arriflex 35BL', 'Mitchell BNCR'],
    lenses: ['Cooke Speed Panchro', 'Angenieux Zoom'],
    awardNominations: 0,
    awardWins: 0,
    startDate: date('1971-03-29'),
    completionDate: date('1971-08-07'),
    signature_shots: ['Brando in shadow', 'Wedding sequence', 'Restaurant shooting'],
    lighting_setups: 215,
    colorScheme: 'Amber and shadows',
    innovationLevel: 'Revolutionary',
    academicStudies: 850
}]->(g);

// Create fan community for blockbuster
CREATE (TitanicFandom:FanCommunity:GeneratedByClaudeAI {
    name: 'Titanic Fan Community',
    established: date('1998-02-15'),
    memberCount: 1250000,
    onlinePlatforms: 18,
    annualEvents: 12,
    largestEventAttendance: 15000,
    contentCreators: 35000,
    fanfictionCount: 85000,
    fanArtCount: 150000,
    academicPapers: 350
})
WITH 1 as dummy
MATCH (f:FanCommunity:GeneratedByClaudeAI {name: 'Titanic Fan Community'}),
      (t:Movie:GeneratedByClaudeAI {title: 'Titanic'})
CREATE (f)-[:ENGAGED_WITH {
    anniversaryCelebrations: 25,
    commemorationEvents: ['Ship sinking date', 'Film release date'],
    romanticFocus: 0.7,
    historicalFocus: 0.3,
    debateTopics: ['Door Size Controversy', 'Historical Accuracy', 'Alternate Endings'],
    fanTheories: 235,
    museumExhibits: 35,
    shipwreckExpeditions: 12,
    merchandiseSales: 450000000,
    digitalPlatformRevival: 'Significant'
}]->(t);

// Create TDK Joker Costume
CREATE (JokerCostume:Prop:GeneratedByClaudeAI {
    name: 'The Dark Knight Joker Costume',
    movie: 'The Dark Knight',
    material: 'Mixed textiles, custom dyes',
    weight: 5.4,
    weightUnit: 'kg',
    createdDate: date('2007-03-15'),
    screenTime: duration({minutes: 33, seconds: 0}),
    isIconic: true,
    auctionValue: 5000000,
    copiesMade: 8
})
WITH 1 as dummy
MATCH (d:Movie:GeneratedByClaudeAI {title: 'Dark Knight'}),
      (p:Prop:GeneratedByClaudeAI {name: 'The Dark Knight Joker Costume'})
CREATE (p)-[:USED_IN {
    scenes: ['Bank robbery', 'Interrogation room', 'Hospital explosion'],
    sceneCount: 15,
    firstAppearance: time('00:04:22'),
    lastAppearance: time('02:12:15'),
    isCloseup: true,
    significance: 'Character defining',
    historicalImpact: 'Reinvented character visually',
    costumeElements: ['Purple coat', 'Green vest', 'Hexagonal pattern shirt', 'Makeup'],
    weatheringTechniques: ['Acid washing', 'Sandpaper distressing', 'Oil staining'],
    psychologicalImportance: 'Visual manifestation of chaos'
}]->(d);

// Create educational institution
CREATE (FilmSchool:Institution:GeneratedByClaudeAI {
    name: 'American Film Institute',
    founded: date('1967-06-05'),
    headquartersLat: 34.1184,
    headquartersLong: -118.3004,
    studentCount: 650,
    facultyCount: 120,
    courseCount: 85,
    filmArchiveSize: 60000,
    digitalArchiveSize: 45000,
    digitalArchiveUnit: 'TB',
    annualBudget: 65000000
})
WITH 1 as dummy
MATCH (i:Institution:GeneratedByClaudeAI {name: 'American Film Institute'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (i)-[:TEACHES_WITH {
    yearAdded: 1973,
    coursesUsedIn: 35,
    primaryFocus: ['Direction technique', 'Screenplay structure', 'Character development', 'Cinematography technique'],
    studentPapersCount: 25850,
    mostCommonAnalysisTopics: ['Visual storytelling', 'Character transformation', 'Thematic elements', 'Shadow and light'],
    teachingHoursAnnually: 820,
    requiredForDegrees: ['MFA Directing', 'MFA Cinematography', 'MFA Screenwriting'],
    teachingValue: 9.9,
    preservationEfforts: 'Significant',
    restorationPartnership: true
}]->(g);

// Create cultural movement for Pulp Fiction
CREATE (Independent90sCinema:CulturalMovement:GeneratedByClaudeAI {
    name: '1990s Independent Cinema',
    established: date('1989-01-15'),
    influentialDirectors: 25,
    internationalFestivals: 45,
    majorAwards: 85,
    criticalReception: 'Revolutionary',
    geographicalSpread: 'Global',
    periodStart: date('1989-01-15'),
    periodPeak: date('1994-10-14'),
    academicStudies: 350
})
WITH 1 as dummy
MATCH (c:CulturalMovement:GeneratedByClaudeAI {name: '1990s Independent Cinema'}),
      (p:Movie:GeneratedByClaudeAI {title: 'Pulp Fiction'})
CREATE (c)-[:DEFINED_BY {
    significanceRating: 9.8,
    globalImpact: 'Transformative',
    boxOfficeMultiplierEffect: 4.5,
    independentFilmIncrease: 0.85,
    subsequentDistributionDeals: 145,
    academicAnalyses: 525,
    filmSchoolAdoption: 'Immediate and canonical',
    newFilmmakersInspired: 'Generation defining',
    narrativeExperimentation: 'Widespread adoption',
    dialogueRevolution: 'Industry-changing',
    genreSubversionTechniques: 'Widely adopted'
}]->(p);

// Create merchandising relationship
CREATE (TitanicMerchandise:Merchandise:GeneratedByClaudeAI {
    name: 'Heart of the Ocean Necklace Replica',
    released: date('1998-01-10'),
    manufacturer: 'J. Peterman Company',
    manufacturerLocationLat: 38.0406,
    manufacturerLocationLong: -84.5037,
    retailPrice: 198.00,
    priceCurrency: 'USD',
    productionRun: 500000,
    materialQuality: 'Mixed',
    limitedEdition: false,
    marketingTagline: 'Inspired by the film that captured the world\'s heart',
    collectorValue: 'Moderate'
})
WITH 1 as dummy
MATCH (m:Merchandise:GeneratedByClaudeAI {name: 'Heart of the Ocean Necklace Replica'}),
      (t:Movie:GeneratedByClaudeAI {title: 'Titanic'})
CREATE (m)-[:DERIVED_FROM {
    licensingDeal: date('1997-10-15'),
    unitsSold: 385000,
    geographicalDistribution: ['North America', 'Europe', 'Asia', 'Australia', 'South America'],
    salesDistribution: [0.55, 0.25, 0.10, 0.05, 0.05],
    retailersCarrying: 18500,
    valentinesPeaks: 5,
    anniversarySalesBumps: 3,
    brandRecognition: 0.85,
    merchandisingLongevity: '25+ years, still available',
    collectibleStatus: 'Moderate',
    reissueVersions: 3
}]->(t);

// Create more movies connected to existing people, studios, and other entities

// Add sequel to The Godfather that connects to existing actors and director
CREATE (TheGodfather2:Movie:GeneratedByClaudeAI {
    title: 'The Godfather: Part II',
    released: 1974,
    tagline: 'I don\'t feel I have to wipe everybody out, Tom. Just my enemies.',
    budget: 13000000,
    revenue: 93000000,
    runtime_minutes: 202,
    rating_avg: 9.0,
    releaseDate: date('1974-12-20'),
    digitalRestoration: datetime('2008-09-23T00:00:00Z'),
    isOscarWinner: true,
    isPreservationRegistry: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'The Godfather: Part II'})
SET m.ratings = [9.1, 9.0, 9.0, 8.9]
SET m.genres = ['crime', 'drama']
SET m.certifications = ['R', '18']
SET m.filmingLocationLat = [40.7128, 37.7749, 23.1136]
SET m.filmingLocationLong = [-74.0060, -122.4194, -82.3666]
SET m.boxOfficeNA = 57300000
SET m.boxOfficeInternational = 35700000
SET m.preservationRegistry = 'National Film Registry'
SET m.culturalImpact = 'Sequel surpassing original';

// Connect Godfather 2 to existing people and studio
MATCH 
  (f:Person:GeneratedByClaudeAI {name: 'Francis Ford Coppola'}),
  (g2:Movie:GeneratedByClaudeAI {title: 'The Godfather: Part II'})
CREATE (f)-[:DIRECTED {
    year: 1974,
    daysOnSet: 125,
    satisfaction: 4.9,
    awardNominations: 11,
    awardWins: 6,
    completionDate: date('1974-10-15'),
    premiereEvent: datetime('1974-12-12T20:00:00-05:00'),
    durationMonths: 5,
    sequelPressure: 'Extreme',
    creativeControl: 'Complete'
}]->(g2);

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Al Pacino'}),
  (g2:Movie:GeneratedByClaudeAI {title: 'The Godfather: Part II'})
CREATE (a)-[:ACTED_IN {
    roles: ['Michael Corleone'],
    salary: 500000,
    screenTimeMinutes: 140,
    startDate: date('1973-10-01'),
    endDate: date('1974-03-15'),
    scheduleConflicts: false,
    criticScore: 99,
    audienceScore: 96,
    awardNominations: 4,
    awardWins: 0,
    characterEvolution: 'Significant darkness'
}]->(g2);

MATCH
  (p:Studio:GeneratedByClaudeAI {name: 'Paramount Pictures'}),
  (g2:Movie:GeneratedByClaudeAI {title: 'The Godfather: Part II'})
CREATE (p)-[:PRODUCED {
    investment: 13000000,
    return: 93000000,
    roi: 7.15,
    contractSigned: date('1972-12-15'),
    studioShare: 0.6,
    directorShare: 0.2,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 4000000,
    isProfitable: true,
    marketingStart: datetime('1974-09-15T00:00:00Z'),
    sequelStrategy: 'Quality over commercialism'
}]->(g2);

// Connect Godfather 2 to awards
MATCH
  (g2:Movie:GeneratedByClaudeAI {title: 'The Godfather: Part II'}),
  (a:Ceremony:GeneratedByClaudeAI {name: 'Academy Awards'})
CREATE (g2)-[:NOMINATED_FOR {
    category: 'Best Picture',
    year: 1975,
    ceremony: 47,
    isWinner: true,
    ceremonyDate: date('1975-04-08'),
    announcementTime: localtime('21:45:00'),
    votesFor: 4125,
    votesAgainst: 1450,
    historicalSignificance: 'First sequel to win Best Picture',
    totalOscars: 6
}]->(a);

// Add another Christopher Nolan film connecting to existing entities
CREATE (Inception:Movie:GeneratedByClaudeAI {
    title: 'Inception',
    released: 2010,
    tagline: 'Your mind is the scene of the crime',
    budget: 160000000,
    revenue: 836800000,
    runtime_minutes: 148,
    rating_avg: 8.8,
    releaseDate: date('2010-07-16'),
    digitalRelease: datetime('2010-12-03T00:00:00Z'),
    isOscarWinner: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Inception'})
SET m.ratings = [8.8, 8.7, 8.9, 8.8]
SET m.genres = ['sci-fi', 'action', 'thriller']
SET m.certifications = ['PG-13', '12A']
SET m.filmingLocationLat = [40.7128, 49.2827, 48.8566]
SET m.filmingLocationLong = [-74.0060, -123.1207, 2.3522]
SET m.boxOfficeNA = 292576195
SET m.boxOfficeEurope = 273417430
SET m.boxOfficeAsia = 159265823
SET m.boxOfficeOther = 111540552
SET m.dreamLevels = 4;

// Connect Inception to Nolan, DiCaprio and Warner Bros
MATCH 
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (c)-[:DIRECTED {
    year: 2010,
    daysOnSet: 140,
    satisfaction: 4.9,
    awardNominations: 8,
    awardWins: 4,
    completionDate: date('2010-04-15'),
    premiereEvent: datetime('2010-07-08T19:30:00+01:00'),
    durationMonths: 6,
    originalConcept: true,
    scriptDevelopmentYears: 10
}]->(i);

MATCH
  (l:Person {name: 'Leonardo DiCaprio'}), // From original graph
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (l)-[:ACTED_IN {
    roles: ['Dom Cobb'],
    salary: 20000000,
    screenTimeMinutes: 125,
    startDate: date('2009-07-15'),
    endDate: date('2009-12-22'),
    scheduleConflicts: false,
    criticScore: 95,
    audienceScore: 93,
    awardNominations: 6,
    awardWins: 2,
    psychologicalPreparation: 'Extensive'
}]->(i);

MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (w)-[:PRODUCED {
    investment: 160000000,
    return: 836800000,
    roi: 5.23,
    contractSigned: date('2008-12-01'),
    studioShare: 0.6,
    directorShare: 0.2,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 100000000,
    isProfitable: true,
    marketingStart: datetime('2010-01-15T00:00:00Z'),
    marketingInnovation: 'Viral mystery campaign'
}]->(i);

// Also connect Marion Cotillard and Cillian Murphy to Inception
MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Marion Cotillard'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (m)-[:ACTED_IN {
    roles: ['Mal Cobb'],
    salary: 3500000,
    screenTimeMinutes: 35,
    startDate: date('2009-08-10'),
    endDate: date('2009-11-15'),
    scheduleConflicts: false,
    criticScore: 96,
    audienceScore: 94,
    characterDepth: 'Psychological antagonist',
    emotionalImpact: 'Haunting'
}]->(i);

MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Cillian Murphy'}),
  (i:Movie:GeneratedByClaudeAI {title: 'Inception'})
CREATE (c)-[:ACTED_IN {
    roles: ['Robert Fischer'],
    salary: 2500000,
    screenTimeMinutes: 42,
    startDate: date('2009-08-05'),
    endDate: date('2009-11-10'),
    scheduleConflicts: false,
    criticScore: 93,
    audienceScore: 92,
    characterComplexity: 'Target and protagonist',
    reunionWithDirector: true
}]->(i);

// Add a James Cameron movie prior to Titanic
CREATE (Aliens:Movie:GeneratedByClaudeAI {
    title: 'Aliens',
    released: 1986,
    tagline: 'This time it\'s war',
    budget: 18500000,
    revenue: 183300000,
    runtime_minutes: 137,
    rating_avg: 8.4,
    releaseDate: date('1986-07-18'),
    digitalRestoration: datetime('2003-12-02T00:00:00Z'),
    isOscarWinner: true,
    sequelNumber: 2
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Aliens'})
SET m.ratings = [8.4, 8.5, 8.3, 8.4]
SET m.genres = ['sci-fi', 'action', 'thriller']
SET m.certifications = ['R', '18']
SET m.filmingLocationLat = [51.5072, 51.4964, 51.6032]
SET m.filmingLocationLong = [-0.1276, -0.1446, -0.0515]
SET m.boxOfficeNA = 85160248
SET m.boxOfficeInternational = 98139752
SET m.specialEffectsAwards = 1
SET m.practicalEffectsPercentage = 95;

// Connect Aliens to James Cameron and 20th Century Fox
MATCH 
  (j:Person:GeneratedByClaudeAI {name: 'James Cameron'}),
  (a:Movie:GeneratedByClaudeAI {title: 'Aliens'})
CREATE (j)-[:DIRECTED {
    year: 1986,
    daysOnSet: 96,
    satisfaction: 4.7,
    awardNominations: 7,
    awardWins: 2,
    completionDate: date('1986-04-30'),
    premiereEvent: datetime('1986-07-14T19:30:00+01:00'),
    durationMonths: 4,
    studioConflicts: true,
    directorStyleForming: 'Technical innovation with character depth'
}]->(a);

MATCH
  (t:Studio:GeneratedByClaudeAI {name: 'TwentiethCenturyFox'}),
  (a:Movie:GeneratedByClaudeAI {title: 'Aliens'})
CREATE (t)-[:PRODUCED {
    investment: 18500000,
    return: 183300000,
    roi: 9.91,
    contractSigned: date('1985-04-15'),
    studioShare: 0.7,
    directorShare: 0.15,
    producerShare: 0.1,
    topCastShare: 0.05,
    marketingBudget: 10000000,
    isProfitable: true,
    marketingStart: datetime('1986-03-15T00:00:00Z'),
    franchiseRevival: true
}]->(a);

// Add a Quentin Tarantino film connected to Uma Thurman
CREATE (KillBill:Movie:GeneratedByClaudeAI {
    title: 'Kill Bill: Vol. 1',
    released: 2003,
    tagline: 'Revenge is a dish best served cold',
    budget: 30000000,
    revenue: 180900000,
    runtime_minutes: 111,
    rating_avg: 8.2,
    releaseDate: date('2003-10-10'),
    digitalRelease: datetime('2004-04-13T00:00:00Z'),
    isOscarWinner: false,
    volumeNumber: 1
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Kill Bill: Vol. 1'})
SET m.ratings = [8.2, 8.1, 8.3, 8.2]
SET m.genres = ['action', 'crime', 'thriller']
SET m.certifications = ['R', '18']
SET m.filmingLocationLat = [34.0522, 35.0116, 35.6762]
SET m.filmingLocationLong = [-118.2437, 135.7681, 139.6503]
SET m.boxOfficeNA = 70099045
SET m.boxOfficeInternational = 110800955
SET m.martialArtsStyles = ['Kung Fu', 'Kenjutsu', 'Aikido']
SET m.homageFilms = ['Lady Snowblood', 'Game of Death', 'Samurai fiction'];

// Connect Kill Bill to Tarantino, Thurman and Miramax
MATCH 
  (q:Person:GeneratedByClaudeAI {name: 'Quentin Tarantino'}),
  (k:Movie:GeneratedByClaudeAI {title: 'Kill Bill: Vol. 1'})
CREATE (q)-[:DIRECTED {
    year: 2003,
    daysOnSet: 110,
    satisfaction: 4.9,
    awardNominations: 5,
    awardWins: 2,
    completionDate: date('2003-06-30'),
    premiereEvent: datetime('2003-09-29T19:00:00+02:00'),
    durationMonths: 5,
    genreBlending: 'Martial arts, spaghetti western, samurai',
    homageLevel: 'Extensive'
}]->(k);

MATCH
  (u:Person:GeneratedByClaudeAI {name: 'Uma Thurman'}),
  (k:Movie:GeneratedByClaudeAI {title: 'Kill Bill: Vol. 1'})
CREATE (u)-[:ACTED_IN {
    roles: ['The Bride/Beatrix Kiddo'],
    salary: 12000000,
    screenTimeMinutes: 95,
    startDate: date('2002-06-30'),
    endDate: date('2002-11-25'),
    scheduleConflicts: false,
    criticScore: 97,
    audienceScore: 94,
    awardNominations: 4,
    awardWins: 1,
    martialArtsTraining: 'Intensive 3-month program',
    characterIconicity: 'Instant classic'
}]->(k);

MATCH
  (m:Studio:GeneratedByClaudeAI {name: 'Miramax Films'}),
  (k:Movie:GeneratedByClaudeAI {title: 'Kill Bill: Vol. 1'})
CREATE (m)-[:PRODUCED {
    investment: 30000000,
    return: 180900000,
    roi: 6.03,
    contractSigned: date('2001-12-15'),
    studioShare: 0.55,
    directorShare: 0.25,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 25000000,
    isProfitable: true,
    marketingStart: datetime('2003-05-15T00:00:00Z'),
    twoPartRelease: true
}]->(k);

// Add a film starring Keanu Reeves that connects to the existing graph
CREATE (Matrix:Movie:GeneratedByClaudeAI {
    title: 'The Matrix',
    released: 1999,
    tagline: 'Welcome to the real world',
    budget: 63000000,
    revenue: 463517383,
    runtime_minutes: 136,
    rating_avg: 8.7,
    releaseDate: date('1999-03-31'),
    digitalRelease: datetime('1999-10-21T00:00:00Z'),
    isOscarWinner: true,
    visualEffectsBreakthrough: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'The Matrix'})
SET m.ratings = [8.7, 8.7, 8.8, 8.6]
SET m.genres = ['sci-fi', 'action']
SET m.certifications = ['R', '15']
SET m.filmingLocationLat = [-33.8688, -33.9680, -33.8882]
SET m.filmingLocationLong = [151.2093, 151.1054, 151.1875]
SET m.boxOfficeNA = 171479930
SET m.boxOfficeInternational = 292037453
SET m.specialEffectsAwards = 4
SET m.culturalImpact = 'Revolutionary';

// Connect The Matrix to existing studios and new actors
MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (m:Movie:GeneratedByClaudeAI {title: 'The Matrix'})
CREATE (w)-[:PRODUCED {
    investment: 63000000,
    return: 463517383,
    roi: 7.36,
    contractSigned: date('1997-08-15'),
    studioShare: 0.7,
    directorShare: 0.1,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 45000000,
    isProfitable: true,
    marketingStart: datetime('1999-01-15T00:00:00Z'),
    riskAssessment: 'High',
    gamblePayoff: 'Extraordinary'
}]->(m);

// Create a Keanu Reeves node and connect to The Matrix
CREATE (KeanuReeves:Person:GeneratedByClaudeAI {
    name: 'Keanu Reeves',
    born: 1964,
    birthdate: date('1964-09-02'),
    nationality: 'Canadian',
    oscarNominations: 0,
    isActive: true,
    firstFilm: datetime('1986-04-11T00:00:00Z'),
    heightInMeters: 1.86,
    netWorth: 380000000,
    martialArtsTraining: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Keanu Reeves'})
SET p.languages = ['English']
SET p.filmography_titles = ['The Matrix', 'Speed', 'John Wick']
SET p.filmography_years = [1999, 1994, 2014]
SET p.filmography_roles = ['Neo', 'Jack Traven', 'John Wick'];

MATCH
  (k:Person:GeneratedByClaudeAI {name: 'Keanu Reeves'}),
  (m:Movie:GeneratedByClaudeAI {title: 'The Matrix'})
CREATE (k)-[:ACTED_IN {
    roles: ['Neo'],
    salary: 10000000,
    screenTimeMinutes: 112,
    startDate: date('1998-03-31'),
    endDate: date('1998-08-25'),
    scheduleConflicts: false,
    criticScore: 96,
    audienceScore: 95,
    martialArtsTraining: '4 months intensive',
    stuntPercentage: 80,
    careerDefiningRole: true
}]->(m);

// Add a connection between Keanu and Hugo Weaving from the original graph
MATCH
  (k:Person:GeneratedByClaudeAI {name: 'Keanu Reeves'}),
  (h:Person {name: 'Hugo Weaving'}) // From original graph
CREATE (k)-[:WORKED_WITH {
    projects: 4,
    firstProject: 'The Matrix',
    firstYear: 1999,
    chemistry: 4.8,
    interviews: 35,
    relationship: 'Co-stars',
    iconic_confrontations: 'Multiple',
    screen_fights: 12
}]->(h);

// Add one of Ang Lee's earlier films
CREATE (SenseAndSensibility:Movie:GeneratedByClaudeAI {
    title: 'Sense and Sensibility',
    released: 1995,
    tagline: 'Lose your heart and come to your senses',
    budget: 16500000,
    revenue: 134993774,
    runtime_minutes: 136,
    rating_avg: 7.7,
    releaseDate: date('1995-12-13'),
    digitalRelease: datetime('1996-07-23T00:00:00Z'),
    isOscarWinner: true,
    isAdaptation: true,
    sourceAuthor: 'Jane Austen'
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Sense and Sensibility'})
SET m.ratings = [7.6, 7.8, 7.7, 7.7]
SET m.genres = ['drama', 'romance']
SET m.certifications = ['PG', 'U']
SET m.filmingLocationLat = [50.3465, 51.2798, 50.7184]
SET m.filmingLocationLong = [-4.1122, -0.5842, -3.5339]
SET m.boxOfficeNA = 43182776
SET m.boxOfficeInternational = 91810998
SET m.periodAccuracy = 'Highly authentic'
SET m.adaptationFidelity = 'High with creative license';

// Connect Sense and Sensibility to Ang Lee and Columbia Pictures
MATCH 
  (a:Person:GeneratedByClaudeAI {name: 'Ang Lee'}),
  (s:Movie:GeneratedByClaudeAI {title: 'Sense and Sensibility'})
CREATE (a)-[:DIRECTED {
    year: 1995,
    daysOnSet: 85,
    satisfaction: 4.8,
    awardNominations: 7,
    awardWins: 1,
    completionDate: date('1995-08-10'),
    premiereEvent: datetime('1995-11-27T19:30:00Z'),
    durationMonths: 3,
    genreDeparture: true,
    crossCulturalInsight: 'Eastern perspective on Western classic'
}]->(s);

MATCH
  (s:Studio {name: 'Columbia Pictures'}), // From original graph
  (ss:Movie:GeneratedByClaudeAI {title: 'Sense and Sensibility'})
CREATE (s)-[:PRODUCED {
    investment: 16500000,
    return: 134993774,
    roi: 8.18,
    contractSigned: date('1994-04-15'),
    studioShare: 0.65,
    directorShare: 0.1,
    producerShare: 0.15,
    topCastShare: 0.1,
    marketingBudget: 12000000,
    isProfitable: true,
    marketingStart: datetime('1995-09-15T00:00:00Z'),
    periodDramaApproach: 'Fresh perspective'
}]->(ss);

// Add Emma Thompson as screenwriter and actor
CREATE (EmmaThompson:Person:GeneratedByClaudeAI {
    name: 'Emma Thompson',
    born: 1959,
    birthdate: date('1959-04-15'),
    nationality: 'British',
    oscarWins: 2,
    oscarNominations: 5,
    isActive: true,
    firstFilm: datetime('1989-11-17T00:00:00Z'),
    heightInMeters: 1.73,
    netWorth: 40000000,
    writerSkill: 9.6
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Emma Thompson'})
SET p.languages = ['English', 'French']
SET p.filmography_titles = ['Sense and Sensibility', 'Howards End', 'Love Actually']
SET p.filmography_years = [1995, 1992, 2003]
SET p.filmography_roles = ['Elinor Dashwood', 'Margaret Schlegel', 'Karen']
SET p.adaptationCredits = ['Sense and Sensibility', 'Bridget Jones\'s Diary', 'Nanny McPhee'];

MATCH
  (e:Person:GeneratedByClaudeAI {name: 'Emma Thompson'}),
  (s:Movie:GeneratedByClaudeAI {title: 'Sense and Sensibility'})
CREATE (e)-[:ACTED_IN {
    roles: ['Elinor Dashwood'],
    salary: 1000000,
    screenTimeMinutes: 98,
    startDate: date('1994-04-15'),
    endDate: date('1994-07-22'),
    scheduleConflicts: false,
    criticScore: 97,
    audienceScore: 94,
    awardNominations: 2,
    awardWins: 0,
    period_costume_discomfort: 'Significant'
}]->(s);

MATCH
  (e:Person:GeneratedByClaudeAI {name: 'Emma Thompson'}),
  (s:Movie:GeneratedByClaudeAI {title: 'Sense and Sensibility'})
CREATE (e)-[:WROTE {
    year: 1995,
    draftCount: 16,
    writingStartDate: date('1991-06-15'),
    writingCompletionDate: date('1994-02-20'),
    adaptationSource: 'Jane Austen novel',
    fidelityBalance: 'Faithful with accessibility',
    awardNominations: 5,
    awardWins: 1,
    adaptationYears: 3,
    diaryKept: true
}]->(s);

// Add a connection between Sofia Coppola and Francis Ford Coppola (father-daughter)
MATCH
  (f:Person:GeneratedByClaudeAI {name: 'Francis Ford Coppola'}),
  (s:Person:GeneratedByClaudeAI {name: 'Sofia Coppola'})
CREATE (f)-[:PARENT_OF {
    childBorn: date('1971-05-14'),
    firstCollaboration: 'The Godfather Part III',
    firstCollaborationYear: 1990,
    mentorRelationship: true,
    influenceLevel: 'Significant but distinct styles',
    publicDiscussions: 15,
    jointInterviews: 8,
    familyLegacy: 'Multigenerational filmmaking'
}]->(s);

// Add another Christopher Nolan film with recurring collaborator Cillian Murphy
CREATE (Dunkirk:Movie:GeneratedByClaudeAI {
    title: 'Dunkirk',
    released: 2017,
    tagline: 'Survival is victory',
    budget: 100000000,
    revenue: 526900000,
    runtime_minutes: 106,
    rating_avg: 7.8,
    releaseDate: date('2017-07-21'),
    digitalRelease: datetime('2017-12-12T00:00:00Z'),
    isOscarWinner: true,
    iMAXFilming: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Dunkirk'})
SET m.ratings = [7.9, 7.7, 7.8, 7.8]
SET m.genres = ['war', 'action', 'drama', 'history']
SET m.certifications = ['PG-13', '12A']
SET m.filmingLocationLat = [51.0383, 51.2254, 50.9730]
SET m.filmingLocationLong = [2.3775, 1.4851, 1.8654]
SET m.boxOfficeNA = 188042171
SET m.boxOfficeInternational = 338857829
SET m.iMAXPercentage = 70
SET m.historicalAccuracy = 'High with dramatic license';

// Connect Dunkirk to Nolan, Murphy and Warner Bros
MATCH 
  (c:Person:GeneratedByClaudeAI {name: 'Christopher Nolan'}),
  (d:Movie:GeneratedByClaudeAI {title: 'Dunkirk'})
CREATE (c)-[:DIRECTED {
    year: 2017,
    daysOnSet: 110,
    satisfaction: 4.9,
    awardNominations: 8,
    awardWins: 3,
    completionDate: date('2017-04-10'),
    premiereEvent: datetime('2017-07-13T19:30:00+01:00'),
    durationMonths: 4,
    iMAXInnovation: 'Custom camera mounts',
    practicalEffectsPercentage: 80
}]->(d);

MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Cillian Murphy'}),
  (d:Movie:GeneratedByClaudeAI {title: 'Dunkirk'})
CREATE (c)-[:ACTED_IN {
    roles: ['Shivering Soldier'],
    salary: 4000000,
    screenTimeMinutes: 22,
    startDate: date('2016-05-25'),
    endDate: date('2016-07-15'),
    scheduleConflicts: false,
    criticScore: 94,
    audienceScore: 92,
    physicalDemands: 'Extreme exposure to elements',
    collaborationNumber: 5
}]->(d);

MATCH
  (w:Studio:GeneratedByClaudeAI {name: 'Warner Bros. Pictures'}),
  (d:Movie:GeneratedByClaudeAI {title: 'Dunkirk'})
CREATE (w)-[:PRODUCED {
    investment: 100000000,
    return: 526900000,
    roi: 5.27,
    contractSigned: date('2015-12-15'),
    studioShare: 0.6,
    directorShare: 0.2,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 80000000,
    isProfitable: true,
    marketingStart: datetime('2016-12-14T00:00:00Z'),
    marketingApproach: 'Historical significance and visceral experience'
}]->(d);

// Add another James Cameron film - connecting to studios
CREATE (Terminator2:Movie:GeneratedByClaudeAI {
    title: 'Terminator 2: Judgment Day',
    released: 1991,
    tagline: 'Same Make. Same Model. New Mission.',
    budget: 102000000,
    revenue: 520000000,
    runtime_minutes: 137,
    rating_avg: 8.6,
    releaseDate: date('1991-07-03'),
    digitalRestoration: datetime('2017-08-29T00:00:00Z'),
    isOscarWinner: true,
    specialEffectsBreakthrough: true
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Terminator 2: Judgment Day'})
SET m.ratings = [8.6, 8.5, 8.7, 8.6]
SET m.genres = ['action', 'sci-fi']
SET m.certifications = ['R', '15']
SET m.filmingLocationLat = [34.0522, 34.4858, 32.7157]
SET m.filmingLocationLong = [-118.2437, -118.1431, -117.1611]
SET m.boxOfficeNA = 204843350
SET m.boxOfficeInternational = 315156650
SET m.specialEffectsAwards = 2
SET m.cgiBreakthroughs = ['Liquid metal T-1000', 'Digital human motion'];

// Connect Terminator 2 to Cameron and appropriate studios
MATCH 
  (j:Person:GeneratedByClaudeAI {name: 'James Cameron'}),
  (t:Movie:GeneratedByClaudeAI {title: 'Terminator 2: Judgment Day'})
CREATE (j)-[:DIRECTED {
    year: 1991,
    daysOnSet: 120,
    satisfaction: 4.9,
    awardNominations: 6,
    awardWins: 4,
    completionDate: date('1991-05-08'),
    premiereEvent: datetime('1991-07-01T19:30:00-07:00'),
    durationMonths: 6,
    sequelVision: 'Technological and thematic expansion',
    technicalInnovations: 'Revolutionary CGI integration'
}]->(t);

// Connect with TriStar Pictures (exists in original graph)
MATCH
  (s:Studio {name: 'TriStar Pictures'}), // From original graph
  (t:Movie:GeneratedByClaudeAI {title: 'Terminator 2: Judgment Day'})
CREATE (s)-[:PRODUCED {
    investment: 102000000,
    return: 520000000,
    roi: 5.10,
    contractSigned: date('1990-02-15'),
    studioShare: 0.6,
    directorShare: 0.2,
    producerShare: 0.1,
    topCastShare: 0.1,
    marketingBudget: 60000000,
    isProfitable: true,
    marketingStart: datetime('1991-01-15T00:00:00Z'),
    riskAssessment: 'Very high budget for the time',
    payoff: 'Established new blockbuster template'
}]->(t);

// Add a connection from Arnold Schwarzenegger
CREATE (ArnoldSchwarzenegger:Person:GeneratedByClaudeAI {
    name: 'Arnold Schwarzenegger',
    born: 1947,
    birthdate: date('1947-07-30'),
    nationality: 'Austrian-American',
    oscarNominations: 0,
    isActive: true,
    firstFilm: datetime('1970-11-20T00:00:00Z'),
    heightInMeters: 1.88,
    netWorth: 450000000,
    politicalCareer: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Arnold Schwarzenegger'})
SET p.languages = ['English', 'German']
SET p.filmography_titles = ['Terminator 2: Judgment Day', 'Predator', 'Total Recall']
SET p.filmography_years = [1991, 1987, 1990]
SET p.filmography_roles = ['Terminator', 'Dutch', 'Douglas Quaid/Hauser']
SET p.governorYears = '2003-2011';

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Arnold Schwarzenegger'}),
  (t:Movie:GeneratedByClaudeAI {title: 'Terminator 2: Judgment Day'})
CREATE (a)-[:ACTED_IN {
    roles: ['Terminator/T-800/Model 101'],
    salary: 15000000,
    screenTimeMinutes: 94,
    startDate: date('1990-10-09'),
    endDate: date('1991-03-28'),
    scheduleConflicts: false,
    criticScore: 98,
    audienceScore: 96,
    catchphraseIconicity: 'Extremely high',
    stuntPercentage: 60,
    physicalTraining: 'Intensive',
    characterReversal: 'Villain to hero'
}]->(t);

// Create a connection from Terminator 2 to The Matrix (influence relationship)
MATCH
  (t:Movie:GeneratedByClaudeAI {title: 'Terminator 2: Judgment Day'}),
  (m:Movie:GeneratedByClaudeAI {title: 'The Matrix'})
CREATE (t)-[:INFLUENCED {
    aspectsInfluenced: ['Visual effects innovation', 'Action choreography', 'Man vs. machine themes'],
    influenceStrength: 'Significant',
    technicalInfluence: 'CGI revolution',
    directorsAcknowledged: true,
    academicRecognition: 'Extensively documented',
    styleContinuity: 'Genre-defining visual language',
    industryImpact: 'Established new blockbuster paradigm'
}]->(m);

// Create connections between actors across productions
MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Arnold Schwarzenegger'}),
  (j:Person:GeneratedByClaudeAI {name: 'James Cameron'})
CREATE (a)-[:COLLABORATED_WITH {
    projects: 3,
    firstProject: 'The Terminator',
    firstYear: 1984,
    lastProject: 'Terminator 2: Judgment Day',
    lastYear: 1991,
    publicPerception: 'Legendary partnership',
    financialSuccess: 'Extremely high',
    genreDefining: true,
    iconicCharacters: 1
}]->(j);

// Add a Japanese film to connect with international cinema
CREATE (SevenSamurai:Movie:GeneratedByClaudeAI {
    title: 'Seven Samurai',
    released: 1954,
    tagline: 'The Masterpiece of Japanese Cinema',
    budget: 500000,
    revenue: 2800000,
    runtime_minutes: 207,
    rating_avg: 8.6,
    releaseDate: date('1954-04-26'),
    digitalRestoration: datetime('2006-10-05T00:00:00Z'),
    isOscarWinner: false,
    isPreservationRegistry: true,
    isInternational: true,
    originalLanguage: 'Japanese'
})
WITH 1 as dummy
MATCH (m:Movie:GeneratedByClaudeAI {title: 'Seven Samurai'})
SET m.ratings = [8.6, 8.7, 8.5, 8.6]
SET m.genres = ['action', 'drama', 'adventure']
SET m.certifications = ['Not Rated', 'PG']
SET m.filmingLocationLat = [36.2048, 35.6762, 34.9768]
SET m.filmingLocationLong = [138.2529, 139.6503, 138.3831]
SET m.boxOfficeNA = 833533
SET m.boxOfficeInternational = 1966467
SET m.filmPreservation = 'Criterion Collection'
SET m.westernRemakes = 'The Magnificent Seven';

// Create Akira Kurosawa and connect to Seven Samurai
CREATE (AkiraKurosawa:Person:GeneratedByClaudeAI {
    name: 'Akira Kurosawa',
    born: 1910,
    died: 1998,
    birthdate: date('1910-03-23'),
    deathdate: date('1998-09-06'),
    nationality: 'Japanese',
    oscarWins: 1,
    oscarNominations: 4,
    isActive: false,
    firstFilm: datetime('1943-03-25T00:00:00Z'),
    lastFilm: datetime('1993-12-18T00:00:00Z'),
    careerLength: duration({years: 50}),
    paintingBackground: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Akira Kurosawa'})
SET p.languages = ['Japanese', 'English']
SET p.filmography_titles = ['Seven Samurai', 'Rashomon', 'Ran']
SET p.filmography_years = [1954, 1950, 1985]
SET p.westernInfluence = 'John Ford'
SET p.globalInfluence = 'Profound';

MATCH 
  (a:Person:GeneratedByClaudeAI {name: 'Akira Kurosawa'}),
  (s:Movie:GeneratedByClaudeAI {title: 'Seven Samurai'})
CREATE (a)-[:DIRECTED {
    year: 1954,
    daysOnSet: 148,
    satisfaction: 4.9,
    awardNominations: 2,
    awardWins: 1,
    completionDate: date('1954-03-01'),
    premiereEvent: datetime('1954-04-26T18:30:00+09:00'),
    durationMonths: 14,
    weatherChallenges: true,
    militaryPrecision: 'Legendary',
    paintingStoryboards: true
}]->(s);

// Create Toshiro Mifune and connect to Seven Samurai
CREATE (ToshiroMifune:Person:GeneratedByClaudeAI {
    name: 'Toshiro Mifune',
    born: 1920,
    died: 1997,
    birthdate: date('1920-04-01'),
    deathdate: date('1997-12-24'),
    nationality: 'Japanese',
    oscarNominations: 0,
    isActive: false,
    firstFilm: datetime('1947-05-15T00:00:00Z'),
    lastFilm: datetime('1995-11-22T00:00:00Z'),
    careerLength: duration({years: 48}),
    collaborationsWithKurosawa: 16
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Toshiro Mifune'})
SET p.languages = ['Japanese', 'English']
SET p.filmography_titles = ['Seven Samurai', 'Rashomon', 'Throne of Blood']
SET p.filmography_years = [1954, 1950, 1957]
SET p.filmography_roles = ['Kikuchiyo', 'Tajomaru', 'Taketoki Washizu']
SET p.actingStyle = 'Intense physical expression';

MATCH
  (t:Person:GeneratedByClaudeAI {name: 'Toshiro Mifune'}),
  (s:Movie:GeneratedByClaudeAI {title: 'Seven Samurai'})
CREATE (t)-[:ACTED_IN {
    roles: ['Kikuchiyo'],
    salary: 3500,
    screenTimeMinutes: 112,
    startDate: date('1952-12-15'),
    endDate: date('1953-12-01'),
    scheduleConflicts: false,
    criticScore: 99,
    audienceScore: 97,
    physicalDemands: 'Extreme',
    swordTraining: 'Extensive',
    improvisationLevel: 'Significant'
}]->(s);

// Create connections showing international influence
MATCH
  (s:Movie:GeneratedByClaudeAI {title: 'Seven Samurai'}),
  (c:Movie:GeneratedByClaudeAI {title: 'Crouching Tiger, Hidden Dragon'})
CREATE (s)-[:INFLUENCED {
    aspectsInfluenced: ['Action choreography', 'Warrior code themes', 'Visual composition'],
    influenceStrength: 'Significant',
    technicalInfluence: 'Combat staging and cinematography',
    directorsAcknowledged: true,
    academicRecognition: 'Extensively documented',
    eastAsianCinemaLegacy: 'Foundational',
    crossCulturalImpact: 'Bridge between Japan and China film traditions'
}]->(c);

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Akira Kurosawa'}),
  (g:Person:GeneratedByClaudeAI {name: 'Francis Ford Coppola'})
CREATE (a)-[:INFLUENCED {
    startYear: 1969,
    directInfluence: true,
    publicAcknowledgement: true,
    cinematic_techniques: ['Composition', 'Movement', 'Weather as metaphor'],
    narrativeApproaches: ['Character study', 'Power dynamics', 'Visual storytelling'],
    laterSupport: 'Financial backing for Kagemusha',
    mutualRespect: 'Profound'
}]->(g);

// Add key cast members from The Godfather
CREATE (MarlonBrando:Person:GeneratedByClaudeAI {
    name: 'Marlon Brando',
    born: 1924,
    died: 2004,
    birthdate: date('1924-04-03'),
    deathdate: date('2004-07-01'),
    nationality: 'American',
    oscarWins: 2,
    oscarNominations: 8,
    isActive: false,
    firstFilm: datetime('1950-09-29T00:00:00Z'),
    lastFilm: datetime('2001-09-07T00:00:00Z'),
    careerLength: duration({years: 51}),
    heightInMeters: 1.75,
    methodActingPioneer: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Marlon Brando'})
SET p.languages = ['English', 'French']
SET p.filmography_titles = ['The Godfather', 'On the Waterfront', 'Apocalypse Now']
SET p.filmography_years = [1972, 1954, 1979]
SET p.filmography_roles = ['Vito Corleone', 'Terry Malloy', 'Colonel Walter E. Kurtz']
SET p.actingInfluence = 'Revolutionary';

CREATE (JamesCaan:Person:GeneratedByClaudeAI {
    name: 'James Caan',
    born: 1940,
    died: 2022,
    birthdate: date('1940-03-26'),
    deathdate: date('2022-07-06'),
    nationality: 'American',
    oscarNominations: 1,
    isActive: false,
    firstFilm: datetime('1963-09-15T00:00:00Z'),
    lastFilm: datetime('2021-10-01T00:00:00Z'),
    careerLength: duration({years: 58}),
    heightInMeters: 1.76,
    athleticBackground: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'James Caan'})
SET p.languages = ['English']
SET p.filmography_titles = ['The Godfather', 'Misery', 'Elf']
SET p.filmography_years = [1972, 1990, 2003]
SET p.filmography_roles = ['Santino "Sonny" Corleone', 'Paul Sheldon', 'Walter Hobbs']
SET p.sportsPassions = ['Martial arts', 'Boxing', 'Baseball'];

CREATE (RobertDuvall:Person:GeneratedByClaudeAI {
    name: 'Robert Duvall',
    born: 1931,
    birthdate: date('1931-01-05'),
    nationality: 'American',
    oscarWins: 1,
    oscarNominations: 7,
    isActive: true,
    firstFilm: datetime('1962-04-28T00:00:00Z'),
    heightInMeters: 1.74,
    netWorth: 70000000,
    militaryService: 'United States Army'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Robert Duvall'})
SET p.languages = ['English', 'Spanish']
SET p.filmography_titles = ['The Godfather', 'Apocalypse Now', 'Tender Mercies']
SET p.filmography_years = [1972, 1979, 1983]
SET p.filmography_roles = ['Tom Hagen', 'Lieutenant Colonel Bill Kilgore', 'Mac Sledge']
SET p.directorCredits = 4;

CREATE (DianeKeaton:Person:GeneratedByClaudeAI {
    name: 'Diane Keaton',
    born: 1946,
    birthdate: date('1946-01-05'),
    nationality: 'American',
    oscarWins: 1,
    oscarNominations: 4,
    isActive: true,
    firstFilm: datetime('1970-05-27T00:00:00Z'),
    heightInMeters: 1.69,
    netWorth: 100000000,
    photographyExhibits: 2
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Diane Keaton'})
SET p.languages = ['English']
SET p.filmography_titles = ['The Godfather', 'Annie Hall', 'Something\'s Gotta Give']
SET p.filmography_years = [1972, 1977, 2003]
SET p.filmography_roles = ['Kay Adams', 'Annie Hall', 'Erica Barry']
SET p.bookAuthor = true;

// Connect cast members to The Godfather
MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Marlon Brando'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (m)-[:ACTED_IN {
    roles: ['Don Vito Corleone'],
    salary: 50000,
    bonuses: 'Percentage of gross',
    screenTimeMinutes: 45,
    startDate: date('1971-03-29'),
    endDate: date('1971-05-15'),
    scheduleConflicts: true,
    criticScore: 100,
    audienceScore: 98,
    awardNominations: 5,
    awardWins: 2,
    makeupHoursDaily: 3,
    improvisationLevel: 'Significant',
    methodPreparation: 'Extensive character backstory'
}]->(g);

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'James Caan'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (j)-[:ACTED_IN {
    roles: ['Santino "Sonny" Corleone'],
    salary: 35000,
    screenTimeMinutes: 32,
    startDate: date('1971-03-29'),
    endDate: date('1971-06-25'),
    scheduleConflicts: false,
    criticScore: 95,
    audienceScore: 96,
    awardNominations: 1,
    awardWins: 0,
    intensityLevel: 'Very high',
    physicalPreparation: 'Combat training',
    improvisation: 'Wedding scene fight'
}]->(g);

MATCH
  (r:Person:GeneratedByClaudeAI {name: 'Robert Duvall'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (r)-[:ACTED_IN {
    roles: ['Tom Hagen'],
    salary: 36000,
    screenTimeMinutes: 30,
    startDate: date('1971-03-29'),
    endDate: date('1971-07-10'),
    scheduleConflicts: false,
    criticScore: 96,
    audienceScore: 95,
    legalResearch: 'Consulted with attorneys',
    characterSubtlety: 'Highest level',
    loyaltyPortrayal: 'Central to character'
}]->(g);

MATCH
  (d:Person:GeneratedByClaudeAI {name: 'Diane Keaton'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (d)-[:ACTED_IN {
    roles: ['Kay Adams'],
    salary: 25000,
    screenTimeMinutes: 18,
    startDate: date('1971-03-29'),
    endDate: date('1971-06-15'),
    scheduleConflicts: false,
    criticScore: 92,
    audienceScore: 90,
    outsiderPerspective: 'Audience surrogate',
    characterArc: 'Disillusionment',
    sequelDevelopment: 'Substantial'
}]->(g);

// Add screenplay writers
CREATE (MarioPuzo:Person:GeneratedByClaudeAI {
    name: 'Mario Puzo',
    born: 1920,
    died: 1999,
    birthdate: date('1920-10-15'),
    deathdate: date('1999-07-02'),
    nationality: 'American',
    oscarWins: 2,
    oscarNominations: 3,
    isActive: false,
    firstNovel: datetime('1955-01-15T00:00:00Z'),
    lastNovel: datetime('1996-09-01T00:00:00Z'),
    careerLength: duration({years: 45}),
    novelistFirst: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Mario Puzo'})
SET p.languages = ['English', 'Italian']
SET p.book_titles = ['The Godfather', 'The Sicilian', 'The Last Don']
SET p.book_years = [1969, 1984, 1996]
SET p.screenplay_credits = ['The Godfather', 'The Godfather Part II', 'Superman']
SET p.mafia_knowledge = 'Research-based, not personal experience';

MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Mario Puzo'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (m)-[:WROTE {
    year: 1972,
    coWriter: 'Francis Ford Coppola',
    draftCount: 6,
    finalPageCount: 172,
    writingStartDate: date('1970-03-15'),
    writingCompletionDate: date('1971-01-10'),
    adaptationSource: 'His own novel',
    studioNotes: 'Extensive',
    scriptChanges: 'Significant from novel',
    scriptNominations: 5,
    scriptWins: 2,
    keyContributions: ['Family dynamics', 'Memorable dialogue', 'Crime authenticity']
}]->(g);

// Create the novel entity as source material for The Godfather
CREATE (TheGodfatherNovel:Book:GeneratedByClaudeAI {
    title: 'The Godfather',
    published: 1969,
    publisher: 'G. P. Putnam\'s Sons',
    pageCount: 448,
    wordCount: 192000,
    isbn: '0399103422',
    publicationDate: date('1969-03-10'),
    weeksOnBestsellerList: 67,
    totalSales: 14000000,
    initialPrintRun: 100000,
    advancePayment: 5000,
    genre: 'Crime fiction'
})
WITH 1 as dummy
MATCH (b:Book:GeneratedByClaudeAI {title: 'The Godfather'})
SET b.languages_translated = 25
SET b.themes = ['Family loyalty', 'Power', 'Americanization', 'Corruption', 'Honor']
SET b.literary_awards = ['None initially']
SET b.film_rights_cost = 12500
SET b.cultural_impact_rating = 9.5;

// Connect the novel to the film
MATCH
  (b:Book:GeneratedByClaudeAI {title: 'The Godfather'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (b)-[:ADAPTED_INTO {
    adaptationFidelity: 0.85,
    contractSigned: date('1969-10-15'),
    authorInvolvement: 'Extensive - co-wrote screenplay',
    significantChanges: ['Condensed timeline', 'Combined characters', 'Added wedding scene'],
    preservedElements: ['Core family dynamics', 'Key plot points', 'Iconic dialogue'],
    adaptation_quality: 'Considered superior to source',
    publicReception: 'Both acclaimed separately',
    adaptationRights: 12500,
    novelSalesAfterFilm: 5000000
}]->(g);

MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Mario Puzo'}),
  (b:Book:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (m)-[:AUTHORED {
    writingStartDate: date('1967-01-15'),
    writingCompletionDate: date('1968-10-20'),
    inspirationSources: ['Crime news', 'Depression-era upbringing', 'Italian-American experience'],
    researchMethods: ['News archives', 'Trial transcripts', 'Personal observations'],
    advance: 5000,
    royaltyPercentage: 0.12,
    initialExpectations: 'Modest commercial success',
    personalConnection: 'Italian-American heritage',
    literaryAim: 'Commercial success after literary novels'
}]->(b);

// Add key filming locations from The Godfather
CREATE (LittleItalyNYC:FilmingLocation:GeneratedByClaudeAI {
    name: 'Little Italy, New York City',
    country: 'USA',
    region: 'New York',
    district: 'Manhattan',
    latitude: 40.7192,
    longitude: -73.9970,
    elevation: 7,
    elevationUnit: 'm',
    climate: 'Temperate',
    permitCost: 75000,
    permitCurrency: 'USD',
    firstUsed: date('1971-04-10'),
    lastUsed: date('1971-05-15'),
    historicalContext: 'Italian-American enclave'
})
WITH 1 as dummy
MATCH (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'}),
      (l:FilmingLocation:GeneratedByClaudeAI {name: 'Little Italy, New York City'})
CREATE (g)-[:FILMED_AT {
    startDate: date('1971-04-10'),
    endDate: date('1971-05-15'),
    sceneCount: 25,
    totalDays: 35,
    weatherDelayDays: 5,
    crewSize: 85,
    logisticsCost: 300000,
    accommodationCost: 125000,
    scenesFilmed: ['Vito shot in street', 'Exterior Genco Olive Oil', 'Clemenza purchasing oranges'],
    securityChallenges: true,
    localReaction: 'Mixed - authentic representation but criminal stereotype',
    locationAccuracy: 'Historically authentic',
    permitDifficulties: 'Some resistance'
}]->(l);

CREATE (SicilyLocation:FilmingLocation:GeneratedByClaudeAI {
    name: 'Forza d\'Agrò, Sicily',
    country: 'Italy',
    region: 'Sicily',
    latitude: 37.9146,
    longitude: 15.3327,
    elevation: 420,
    elevationUnit: 'm',
    climate: 'Mediterranean',
    permitCost: 25000,
    permitCurrency: 'USD',
    firstUsed: date('1971-07-15'),
    lastUsed: date('1971-08-10'),
    historicalContext: 'Traditional Sicilian village',
    culturalSignificance: 'Corleone family origins'
})
WITH 1 as dummy
MATCH (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'}),
      (l:FilmingLocation:GeneratedByClaudeAI {name: 'Forza d\'Agrò, Sicily'})
CREATE (g)-[:FILMED_AT {
    startDate: date('1971-07-15'),
    endDate: date('1971-08-10'),
    sceneCount: 12,
    totalDays: 26,
    weatherDelayDays: 3,
    crewSize: 65,
    logisticsCost: 450000,
    accommodationCost: 175000,
    scenesFilmed: ['Michael in exile', 'Meeting Apollonia', 'Countryside walks'],
    localParticipation: true,
    authenticDialect: true,
    visualAuthenticity: 'Preserved historical village',
    logisticalChallenges: 'Remote location, equipment transport'
}]->(l);

// Create iconic props from The Godfather
CREATE (GodfatherPuppet:Prop:GeneratedByClaudeAI {
    name: 'Don Corleone\'s Cat',
    movie: 'The Godfather',
    type: 'Animal actor',
    animal: 'Cat',
    breed: 'Stray',
    weight: 3.6,
    weightUnit: 'kg',
    acquisitionDate: date('1971-04-02'),
    screenTime: duration({minutes: 2, seconds: 45}),
    isIconic: true,
    isImprovised: true,
    handlerCount: 2
})
WITH 1 as dummy
MATCH (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'}),
      (p:Prop:GeneratedByClaudeAI {name: 'Don Corleone\'s Cat'})
CREATE (p)-[:USED_IN {
    scenes: ['Opening office scene'],
    sceneCount: 1,
    firstAppearance: time('00:03:30'),
    lastAppearance: time('00:06:15'),
    isCloseup: true,
    significance: 'Characterization device',
    symbolism: 'Affection beneath ruthlessness',
    isImprovisedElement: true,
    propOrigin: 'Found on studio lot',
    directorNote: 'Brando bonded with the cat between takes',
    culturalImpact: 'Widely referenced visual'
}]->(g);

CREATE (CanoliProp:Prop:GeneratedByClaudeAI {
    name: 'Clemenza\'s Cannoli',
    movie: 'The Godfather',
    type: 'Food',
    material: 'Pastry and cream',
    weight: 0.15,
    weightUnit: 'kg',
    createdDate: date('1971-05-12'),
    screenTime: duration({minutes: 0, seconds: 30}),
    isIconic: true,
    isConsumed: true,
    propMaster: 'Angelo Graham',
    replicas: 12
})
WITH 1 as dummy
MATCH (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'}),
      (p:Prop:GeneratedByClaudeAI {name: 'Clemenza\'s Cannoli'})
CREATE (p)-[:USED_IN {
    scenes: ['Leave the gun, take the cannoli'],
    sceneCount: 1,
    firstAppearance: time('01:42:10'),
    lastAppearance: time('01:42:40'),
    isCloseup: false,
    significance: 'Character defining moment',
    symbolism: 'Casual attitude toward violence',
    quotableConnection: 'Generated iconic line',
    propContinuity: 'Multiple takes required fresh cannoli',
    culturalImpact: 'Entered lexicon',
    merchandisingValue: 'Significant'
}]->(g);

// Add the iconic soundtrack information
CREATE (GodfatherSoundtrack:Soundtrack:GeneratedByClaudeAI {
    title: 'The Godfather: Music from the Original Motion Picture Soundtrack',
    composer: 'Nino Rota',
    released: date('1972-03-07'),
    duration: duration({minutes: 31, seconds: 24}),
    trackCount: 11,
    recordingStudio: 'Paramount Studios',
    recordingStudioLat: 34.0841,
    recordingStudioLong: -118.3213,
    peakChartPosition: 45,
    salesUnits: 500000,
    streamingCount: 150000000,
    culturalInfluence: 'Definitive'
})
WITH 1 as dummy
MATCH (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'}),
      (s:Soundtrack:GeneratedByClaudeAI {title: 'The Godfather: Music from the Original Motion Picture Soundtrack'})
CREATE (s)-[:COMPOSED_FOR {
    contractDate: date('1971-02-15'),
    completion: date('1971-11-10'),
    nominatedAwards: ['Academy Award', 'Grammy Award'],
    wonAwards: [],
    disqualificationReason: 'Previous usage',
    iconicThemes: ['Love Theme', 'The Godfather Waltz'],
    orchestraSize: 65,
    recordingSessions: 8,
    mainInstrumentation: ['Mandolin', 'Orchestra', 'Trumpet solo'],
    emotionalImpact: 9.7,
    directorCollaboration: 'Very close',
    thematicElements: ['Sicilian traditions', 'Melancholy', 'Family bonds']
}]->(g);

// Add composer information and connection
CREATE (NinoRota:Person:GeneratedByClaudeAI {
    name: 'Nino Rota',
    born: 1911,
    died: 1979,
    birthdate: date('1911-12-03'),
    deathdate: date('1979-04-10'),
    nationality: 'Italian',
    oscarWins: 1,
    oscarNominations: 2,
    isActive: false,
    firstFilm: datetime('1933-01-01T00:00:00Z'),
    lastFilm: datetime('1979-03-05T00:00:00Z'),
    careerLength: duration({years: 46}),
    compositionsCount: 176
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Nino Rota'})
SET p.languages = ['Italian', 'English', 'French']
SET p.collaboration_directors = ['Federico Fellini', 'Francis Ford Coppola', 'Luchino Visconti']
SET p.collaboration_years = ['1952-1979', '1972-1974', '1954-1963']
SET p.musical_education = 'Milan Conservatory'
SET p.composition_style = 'Melodic with classical influences';

MATCH
  (n:Person:GeneratedByClaudeAI {name: 'Nino Rota'}),
  (s:Soundtrack:GeneratedByClaudeAI {title: 'The Godfather: Music from the Original Motion Picture Soundtrack'})
CREATE (n)-[:COMPOSED {
    year: 1972,
    compositionPeriod: duration({months: 8}),
    themes: 14,
    originalPieces: 8,
    adaptedPieces: 3,
    instrumentsPlayed: ['Piano'],
    recordingSupervision: true,
    collaborators: ['Carmine Coppola (conductor)'],
    compositionMethod: 'Piano sketches then orchestration',
    themeInspirations: ['Sicilian folk music', 'Italian opera', 'American jazz'],
    directorFeedback: 'Extensive collaboration'
}]->(s);

// Add cinematographer relationship
CREATE (GordonWillis:Person:GeneratedByClaudeAI {
    name: 'Gordon Willis',
    born: 1931,
    died: 2014,
    birthdate: date('1931-05-28'),
    deathdate: date('2014-05-18'),
    nationality: 'American',
    oscarNominations: 2,
    oscarHonoraryAward: true,
    isActive: false,
    firstFilm: datetime('1970-01-18T00:00:00Z'),
    lastFilm: datetime('1997-09-16T00:00:00Z'),
    careerLength: duration({years: 27}),
    visualStyle: 'Chiaroscuro lighting with deep shadows',
    nickname: 'Prince of Darkness'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Gordon Willis'})
SET p.languages = ['English']
SET p.filmography_titles = ['The Godfather', 'The Godfather Part II', 'All the President\'s Men', 'Manhattan']
SET p.filmography_years = [1972, 1974, 1976, 1979]
SET p.camera_preference = 'Panavision'
SET p.lighting_style = 'Naturalistic with heavy shadows';

MATCH
  (g:Person:GeneratedByClaudeAI {name: 'Gordon Willis'}),
  (f:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (g)-[:CINEMATOGRAPHY_FOR {
    year: 1972,
    cameras: ['Panavision Panaflex', 'Mitchell BNCR'],
    lenses: ['Panavision Primo', 'Panavision Ultra Speed'],
    filmStock: 'Eastman Kodak 5254',
    awardNominations: 0,
    awardWins: 0,
    startDate: date('1971-03-29'),
    completionDate: date('1971-08-07'),
    signature_techniques: ['Top-lighting', 'Underexposed faces', 'Amber color palette'],
    lighting_setups: 215,
    challenges_overcome: ['Low light interiors', 'Studio resistance to dark look', 'Period authenticity'],
    technical_innovations: ['Exposure techniques', 'Color timing process'],
    cinematographic_influence: 'Revolutionized Hollywood lighting',
    studio_conflicts: 'Executives concerned about dark visuals'
}]->(f);

// Add costume designer relationship
CREATE (AnnaDeCurio:Person:GeneratedByClaudeAI {
    name: 'Anna Hill Johnstone',
    born: 1913,
    died: 1992,
    birthdate: date('1913-04-15'),
    deathdate: date('1992-04-17'),
    nationality: 'American',
    oscarNominations: 1,
    isActive: false,
    firstFilm: datetime('1950-09-22T00:00:00Z'),
    lastFilm: datetime('1985-06-28T00:00:00Z'),
    careerLength: duration({years: 35}),
    specialization: 'Period Costume Design',
    designPhilosophy: 'Authentic character-driven'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Anna Hill Johnstone'})
SET p.languages = ['English', 'Italian']
SET p.filmography_titles = ['The Godfather', 'On the Waterfront', 'East of Eden']
SET p.filmography_years = [1972, 1954, 1955]
SET p.design_specialties = ['1940s menswear', 'Italian-American style', 'Socioeconomic distinctions through clothing']
SET p.research_methodology = 'Extensive historical photo analysis';

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Anna Hill Johnstone'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (a)-[:DESIGNED_COSTUMES_FOR {
    year: 1972,
    costumesCreated: 500,
    budget: 150000,
    awardNominations: 1,
    awardWins: 0,
    startDate: date('1971-01-15'),
    completionDate: date('1971-03-15'),
    specialCostumes: ['Vito Corleone suits', 'Wedding gowns', 'Military uniforms'],
    researchHours: 450,
    historicalAccuracy: 'Highly authentic',
    specificChallenges: ['Period accuracy', 'Showing wealth gradations', 'Character evolution'],
    fabricsSourced: ['Italian wool', 'American cotton', 'Silk blends'],
    fabricCost: 45000,
    characterProgression: 'Michael\'s suits evolve as he takes power',
    colorSymbolism: 'Studied use of black and gray for power dynamics'
}]->(g);

// Create fan community for The Godfather
CREATE (GodfatherFandom:FanCommunity:GeneratedByClaudeAI {
    name: 'The Godfather Legacy Community',
    established: date('1972-05-15'),
    formalized: date('1997-03-24'),
    memberCount: 750000,
    onlinePlatforms: 12,
    annualEvents: 8,
    largestEventAttendance: 12000,
    contentCreators: 22000,
    fanfictionCount: 45000,
    academicContributions: 850,
    preservationEfforts: true
})
WITH 1 as dummy
MATCH (f:FanCommunity:GeneratedByClaudeAI {name: 'The Godfather Legacy Community'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (f)-[:CELEBRATES {
    anniversaryCelebrations: 50,
    commemorationEvents: ['Film anniversaries', 'Restoration premieres', 'Cast reunions'],
    academicConferences: 35,
    preservationDonations: 2500000,
    quotationContests: true,
    documentaryProductions: 12,
    memorabiliaValue: 'High collectibles market',
    tourismImpact: 'Sicily and New York tours',
    dialogueMemorizationLevel: 'Extremely high',
    culturalDefenseActivities: 'Combating stereotypes while celebrating artistry',
    educationalPrograms: ['Film schools', 'Cinema history courses', 'Screenwriting analysis'],
    merchandisingSales: 75000000
}]->(g);

// Add educational institution teaching The Godfather
CREATE (FilmSchool:Institution:GeneratedByClaudeAI {
    name: 'USC School of Cinematic Arts',
    founded: date('1929-02-06'),
    headquartersLat: 34.0243,
    headquartersLong: -118.2878,
    studentCount: 1850,
    facultyCount: 145,
    courseCount: 230,
    filmArchiveSize: 80000,
    digitalArchiveSize: 175000,
    digitalArchiveUnit: 'TB',
    annualBudget: 85000000,
    endowment: 250000000,
    prestigeRanking: 1
})
WITH 1 as dummy
MATCH (i:Institution:GeneratedByClaudeAI {name: 'USC School of Cinematic Arts'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (i)-[:TEACHES_WITH {
    yearAdded: 1973,
    coursesUsedIn: 47,
    primaryFocus: ['Direction technique', 'Screenplay structure', 'Cinematography', 'Character development', 'Adaptation methodology'],
    studentPapersCount: 35850,
    mostCommonAnalysisTopics: ['Visual storytelling', 'Character arcs', 'Adaptation from novel', 'Cultural impact', 'Photography techniques'],
    teachingHoursAnnually: 950,
    requiredForDegrees: ['MFA Directing', 'MFA Cinematography', 'MFA Screenwriting', 'BA Film Theory'],
    teachingValue: 10.0,
    preservationPartnership: true,
    originalMaterialsAccess: 'Archival agreement with Paramount',
    technicalDeconstruction: ['Lighting workshops', 'Scene analysis seminars', 'Screenplay structure classes'],
    alumniConnections: 'Several faculty worked on film or with creators'
}]->(g);

// Create cultural impact connections
CREATE (ItalianAmericanCulture:CulturalMovement:GeneratedByClaudeAI {
    name: 'Italian-American Cultural Representation',
    established: date('1890-01-01'),
    formalized: date('1945-06-15'),
    influentialWorks: 45,
    politicalImpact: 'Significant',
    academicStudies: 850,
    criticalReception: 'Mixed evolution',
    geographicalSpread: 'North America with global influence',
    periodStart: date('1890-01-01'),
    periodPeak: date('1972-03-15'),
    culturalInstitutions: 125
})
WITH 1 as dummy
MATCH (c:CulturalMovement:GeneratedByClaudeAI {name: 'Italian-American Cultural Representation'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (c)-[:INFLUENCED_BY {
    significanceRating: 9.9,
    culturalImpact: 'Transformative but complicated',
    identityEffects: ['Reinforced stereotypes', 'Added complexity', 'Created enduring iconography'],
    communityReactions: ['Criticism of criminal focus', 'Appreciation of authentic elements', 'Pride in artistic achievement'],
    languageContributions: ['Introduced Italian terms', 'Popularized mafia terminology', 'Created quotable dialogue'],
    academicAnalyses: 1250,
    mediaCoverage: 'Extensive and ongoing',
    culturalShift: 'Redefined Italian-American portrayal',
    controversyLevel: 'Significant but diminishing',
    authenticityClaims: 'Mixed - fictional but culturally informed',
    subsequentPortrayals: 'Set template for decades'
}]->(g);

// Create an organized crime expert who consulted on the film
CREATE (JosephMaio:Person:GeneratedByClaudeAI {
    name: 'Joseph Bonanno',
    born: 1905,
    died: 2002,
    birthdate: date('1905-01-18'),
    deathdate: date('2002-05-11'),
    nationality: 'Italian-American',
    livedInSicily: true,
    isActive: false,
    firstPublicAppearance: datetime('1957-11-14T00:00:00Z'),
    lastPublicAppearance: datetime('1983-05-06T00:00:00Z'),
    careerLength: duration({years: 70}),
    heightInMeters: 1.73,
    memoirAuthor: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Joseph Bonanno'})
SET p.languages = ['English', 'Italian', 'Sicilian']
SET p.public_titles = ['Businessman', 'Memoirist', 'Historical figure']
SET p.activities = ['Commerce', 'Family business', 'Historical consulting']
SET p.book_titles = ['A Man of Honor: The Autobiography of Joseph Bonanno']
SET p.book_years = [1983]
SET p.family_origin = 'Castellammare del Golfo, Sicily';

MATCH
  (j:Person:GeneratedByClaudeAI {name: 'Joseph Bonanno'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (j)-[:CONSULTED_FOR {
    year: 1971,
    officialCapacity: false,
    indirectConsultation: true,
    compensation: 0,
    areasAdvised: ['Family structure', 'Traditional customs', 'Historical context', 'Sicilian traditions'],
    informationFlow: 'Through intermediaries',
    accuracyContribution: 'Authentic cultural details',
    publicAcknowledgement: false,
    legalDistancing: true,
    culturalAuthenticity: 'Significant contribution to realism',
    laterComments: 'Acknowledged similarities in memoir'
}]->(g);

// Create iconic scenes from The Godfather
CREATE (HorsesHeadScene:Scene:GeneratedByClaudeAI {
    name: 'Horse Head Scene',
    movie: 'The Godfather',
    sceneNumber: 42,
    duration: duration({minutes: 2, seconds: 45}),
    scriptPages: 3,
    locationCount: 2,
    interiorsOnly: true,
    actors: 2,
    extras: 5,
    animalsUsed: 1,
    stuntsRequired: 0,
    specialEffectsComplexity: 'High',
    dialogueLines: 6
})
WITH 1 as dummy
MATCH (s:Scene:GeneratedByClaudeAI {name: 'Horse Head Scene'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (s)-[:PART_OF {
    timeIndex: time('01:39:15'),
    runningOrder: 42,
    story_significance: 'Shows Corleone power and ruthlessness',
    character_development: 'Establishes Corleone methods',
    filmingDays: 3,
    filmingChallenges: ['Animal welfare', 'Realistic prop', 'Actor reaction'],
    technical_specifications: ['Low light cinematography', 'Practical effects', 'Minimal music'],
    shooting_location: 'Paramount Studios',
    production_cost: 45000,
    trivia: 'Used real horse head from slaughterhouse',
    cultural_impact: 'Iconic scene regularly referenced',
    viewer_reaction: 'Shock and disgust',
    controversies: 'Animal rights concerns',
    symbolic_meaning: 'Ultimate threat against ego and livelihood'
}]->(g);

CREATE (WeddingScene:Scene:GeneratedByClaudeAI {
    name: 'Opening Wedding Scene',
    movie: 'The Godfather',
    sceneNumber: 1,
    duration: duration({minutes: 28, seconds: 15}),
    scriptPages: 31,
    locationCount: 1,
    interiorsOnly: false,
    actors: 24,
    extras: 120,
    animalsUsed: 4,
    stuntsRequired: 2,
    specialEffectsComplexity: 'Low',
    dialogueLines: 112
})
WITH 1 as dummy
MATCH (s:Scene:GeneratedByClaudeAI {name: 'Opening Wedding Scene'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (s)-[:PART_OF {
    timeIndex: time('00:03:15'),
    runningOrder: 1,
    story_significance: 'Introduces all key characters and dynamics',
    character_development: 'Establishes family relationships and hierarchy',
    filmingDays: 12,
    filmingChallenges: ['Weather', 'Crowd management', 'Animal coordination'],
    technical_specifications: ['Extensive tracking shots', 'Natural lighting', 'Complex sound mixing'],
    shooting_location: 'Staten Island and Paramount Studios',
    production_cost: 175000,
    trivia: 'Many extras were actual Italian-American neighborhood residents',
    cultural_impact: 'Defined cinematic portrayal of Italian wedding',
    viewer_reaction: 'Immersive introduction to world',
    directing_technique: 'Masterful blocking and crowd choreography',
    exposition_method: 'Natural dialogue and visual storytelling'
}]->(g);

// Create business entities related to The Godfather
CREATE (GalloWineries:Business:GeneratedByClaudeAI {
    name: 'Paramount Pictures Merchandising',
    founded: date('1933-09-15'),
    headquartersLat: 34.0841,
    headquartersLong: -118.3213,
    employees: 850,
    annualRevenue: 450000000,
    marketValueUSD: 750000000,
    publiclyTraded: true,
    tickerSymbol: 'PARA',
    ceoCompensation: 12000000,
    globalOffices: 15,
    digitalTransformation: date('1995-06-12')
})
WITH 1 as dummy
MATCH (b:Business:GeneratedByClaudeAI {name: 'Paramount Pictures Merchandising'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (b)-[:MERCHANDISED {
    contractStart: date('1972-02-15'),
    contractEnd: date('2050-12-31'),
    initialProducts: ['Posters', 'Soundtrack', 'Film stills'],
    expandedProducts: ['Clothing', 'Home decor', 'Collectibles', 'Digital content'],
    anniversaryReleases: [1997, 2002, 2007, 2012, 2022],
    totalRevenue: 850000000,
    highestGrossingProduct: 'DVD/Blu-ray collections',
    productRevenues: [350000000, 200000000, 150000000, 100000000, 50000000],
    productCategories: ['Media', 'Apparel', 'Collectibles', 'Publishing', 'Digital'],
    licensingPartnerships: 125,
    globalDistribution: 'Worldwide with focus on North America and Europe',
    intellectualPropertyRights: 'Exclusive with narrow exceptions',
    digitalExpansion: 'Significant since 2005'
}]->(g);

// Create restoration project for The Godfather
CREATE (GodfatherRestoration:DigitalProject:GeneratedByClaudeAI {
    name: 'The Godfather 4K Restoration',
    started: date('2007-06-15'),
    completed: date('2008-09-22'),
    teamSize: 30,
    originalNegativeUsed: true,
    resolutionOutput: '4096x3112',
    colorDepth: '16-bit',
    storageSizeRaw: 225,
    storageSizeUnit: 'TB',
    finalMasterSize: 18,
    finalMasterUnit: 'TB',
    budget: 1500000,
    supervisionLevel: 'Director and cinematographer involved'
})
WITH 1 as dummy
MATCH (d:DigitalProject:GeneratedByClaudeAI {name: 'The Godfather 4K Restoration'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (d)-[:PRESERVED {
    frameCorrectionCount: 542500,
    frameTotalCount: 189216,
    originalDamagePercentage: 0.23,
    restorationFidelity: 0.988,
    audioChannelsPreserved: 4,
    audioSamplingRate: 192,
    audioSamplingUnit: 'kHz',
    primaryRestorationChallenges: ['Color timing', 'Negative deterioration', 'Audio synchronization', 'Director approval'],
    challengeComplexity: [9.7, 9.5, 8.5, 9.2],
    technologiesUsed: ['Frame-by-frame restoration', 'Wetgate scanning', 'Neural network cleanup', 'HDR color grading'],
    directorInvolvement: 'Francis Ford Coppola personally supervised',
    cinematographerConsultation: 'Gordon Willis consulted on color timing',
    preservationStandard: 'Library of Congress Archival Standard',
    publicReception: 'Critically acclaimed restoration',
    physicalPreservationCopies: 5,
    archivalStorageLocations: ['Library of Congress', 'Paramount Archives', 'Academy Film Archive']
}]->(g);

// Create a critical review for The Godfather from a prominent critic
CREATE (PaulineKaelReview:Review:GeneratedByClaudeAI {
    title: 'Gangster Baroque',
    author: 'Pauline Kael',
    publication: 'The New Yorker',
    date: date('1972-03-18'),
    time: time('09:00:00-05:00'),
    isVerified: true,
    aspectDirection: 5.0,
    aspectActing: 5.0,
    aspectWriting: 4.8,
    aspectCinematography: 5.0,
    aspectMusic: 4.9,
    reviewText: 'Francis Ford Coppola has made one of the most brutal and moving chronicles of American life ever designed within the limits of popular entertainment. The Godfather has been executed with such authenticity that it becomes a genuine work of art.',
    wordCount: 3500,
    criticalInfluence: 'Highly influential'
})
WITH 1 as dummy
MATCH (r:Review:GeneratedByClaudeAI {title: 'Gangster Baroque'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (r)-[:FOR_MOVIE {
    isPublished: true,
    views: 'Unknown historically',
    reprintCount: 35,
    anthologized: true,
    publicationPage: 'Lead review',
    criticalImpact: 'Set critical consensus',
    academicCitations: 845,
    historicalValue: 'Definitive contemporary assessment',
    culturalContext: 'Recognized immediate significance',
    industryInfluence: 'Helped secure film\'s reputation',
    criticPerspective: 'Aesthetic and sociological analysis',
    publicationDateTime: datetime('1972-03-18T09:00:00-05:00')
}]->(g);

// Create a connection between the critic and the review
CREATE (PaulineKael:Person:GeneratedByClaudeAI {
    name: 'Pauline Kael',
    born: 1919,
    died: 2001,
    birthdate: date('1919-06-19'),
    deathdate: date('2001-09-03'),
    nationality: 'American',
    oscarInfluence: 'Significant',
    isActive: false,
    firstReview: datetime('1953-10-15T00:00:00Z'),
    lastReview: datetime('1991-02-20T00:00:00Z'),
    careerLength: duration({years: 38}),
    reviewCount: 6500,
    criticalApproach: 'Visceral and intellectual'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Pauline Kael'})
SET p.languages = ['English']
SET p.publications = ['The New Yorker', 'McCall\'s', 'Various film journals']
SET p.books = ['I Lost It at the Movies', 'Going Steady', 'Reeling', 'Taking It All In']
SET p.critical_philosophy = 'Emotional honesty and artistic integrity'
SET p.writing_style = 'Direct, passionate, and witty';

MATCH
  (p:Person:GeneratedByClaudeAI {name: 'Pauline Kael'}),
  (r:Review:GeneratedByClaudeAI {title: 'Gangster Baroque'})
CREATE (p)-[:WROTE {
    date: date('1972-03-15'),
    timeSpentWriting: duration({days: 3}),
    wordCount: 3500,
    isVerified: true,
    submissionTime: time('18:45:00-05:00'),
    editorialChanges: 'Minimal',
    researchConducted: 'Film viewing and film history context',
    influenceLevel: 'Set critical standard',
    laterReassessments: 'None - stood by original assessment',
    perspectiveApplied: 'Cultural, aesthetic, and narrative analysis',
    paymentReceived: 1200,
    recognitionReceived: 'National Magazine Award consideration'
}]->(r);

// Connect The Godfather to other mob films it influenced
MATCH
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'}),
  (g2:Movie:GeneratedByClaudeAI {title: 'The Godfather: Part II'})
CREATE (g)-[:INFLUENCED {
    aspectsInfluenced: ['Direct sequel', 'Character continuation', 'Visual style', 'Thematic expansion'],
    influenceStrength: 'Direct and fundamental',
    continuityElements: ['Characters', 'Visual language', 'Musical themes', 'Narrative structure'],
    expandedThemes: ['Immigration', 'Corruption', 'American Dream'],
    creativeTeamOverlap: 0.85,
    narrativeConnection: 'Both prequel and sequel',
    criticComparison: 'Often considered superior to original',
    academicAnalysis: 'Studied as rare case of sequel equaling or surpassing original'
}]->(g2);

// Create awards received by The Godfather
CREATE (BestPictureOscar:Award:GeneratedByClaudeAI {
    name: 'Academy Award for Best Picture',
    presentedBy: 'Academy of Motion Picture Arts and Sciences',
    firstAwarded: date('1929-05-16'),
    category: 'Best Picture',
    prestige: 10.0,
    recipients: 93,
    monetary: false,
    physicalAward: true,
    awardMaterial: 'Gold-plated britannium',
    awardHeight: 34.3,
    heightUnit: 'cm',
    awardWeight: 3.856,
    weightUnit: 'kg',
    applicationRequired: false
})
WITH 1 as dummy
MATCH (a:Award:GeneratedByClaudeAI {name: 'Academy Award for Best Picture'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (a)-[:AWARDED_TO {
    ceremonyNumber: 45,
    awardDate: date('1973-03-27'),
    presentedBy: 'Clint Eastwood',
    acceptedBy: 'Albert S. Ruddy',
    competitor1: 'Cabaret',
    competitor2: 'Deliverance',
    competitor3: 'The Emigrants',
    competitor4: 'Sounder',
    acceptanceSpeechLength: duration({minutes: 2, seconds: 15}),
    controversies: 'Marlon Brando boycott',
    historicalContext: 'End of "Old Hollywood" era',
    industryImpact: 'New Hollywood legitimization',
    votingPercentage: 0.58,
    mediaHeadlines: 'Triumph of "New Hollywood"'
}]->(g);

// Create editor relationship
CREATE (WilliamReynolds:Person:GeneratedByClaudeAI {
    name: 'William Reynolds',
    born: 1910,
    died: 1997,
    birthdate: date('1910-06-14'),
    deathdate: date('1997-07-16'),
    nationality: 'American',
    oscarNominations: 2,
    oscarWins: 0,
    isActive: false,
    firstFilm: datetime('1936-05-11T00:00:00Z'),
    lastFilm: datetime('1977-12-18T00:00:00Z'),
    careerLength: duration({years: 41}),
    editingStyle: 'Character-focused pacing'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'William Reynolds'})
SET p.languages = ['English']
SET p.filmography_titles = ['The Godfather', 'The Sound of Music', 'The Sting']
SET p.filmography_years = [1972, 1965, 1973]
SET p.technical_expertise = 'Moviola editing system master'
SET p.working_style = 'Close collaboration with directors';

MATCH
  (w:Person:GeneratedByClaudeAI {name: 'William Reynolds'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (w)-[:EDITED {
    year: 1972,
    editingSystems: ['Moviola'],
    cuttingRatio: 20.1,
    footageReviewed: 500000,
    footageUnit: 'feet',
    editingSessions: 185,
    directorSessions: 65,
    completionDate: date('1972-01-15'),
    narrativeContributions: ['Parallel action sequences', 'Pacing adjustments', 'Scene reordering'],
    significantEdits: ['Wedding sequence compression', 'Hospital sequence tension', 'Final montage'],
    initialCutLength: duration({hours: 3, minutes: 15}),
    finalCutLength: duration({hours: 2, minutes: 55}),
    editingApproach: 'Character-driven rhythms',
    controversies: 'Studio pressure to shorten',
    directorRelationship: 'Collaborative and supportive'
}]->(g);

// Connection between Puzo and The Godfather Part II
MATCH
  (m:Person:GeneratedByClaudeAI {name: 'Mario Puzo'}),
  (g2:Movie:GeneratedByClaudeAI {title: 'The Godfather: Part II'})
CREATE (m)-[:WROTE {
    year: 1974,
    coWriter: 'Francis Ford Coppola',
    draftCount: 5,
    finalPageCount: 165,
    writingStartDate: date('1973-02-10'),
    writingCompletionDate: date('1973-08-15'),
    originalMaterial: 'Expanded from unused novel sections',
    adaptationSource: 'Partial novel material with new content',
    studioNotes: 'Limited after original success',
    sequelChallenges: ['Narrative complexity', 'Dual timeline', 'Meeting expectations'],
    narrativeInnovations: ['Parallel past/present', 'Character devolution', 'Thematic expansion'],
    scriptNominations: 2,
    scriptWins: 1
}]->(g2);

// Create the production challenges node
CREATE (GodfatherChallenges:ProductionChallenge:GeneratedByClaudeAI {
    name: 'The Godfather Production Obstacles',
    productionPhase: 'Pre-production and principal photography',
    startDate: date('1971-02-15'),
    endDate: date('1971-08-07'),
    severityLevel: 8.5,
    budgetImpact: 1200000,
    scheduleImpact: duration({days: 25}),
    departmentsAffected: 6,
    resolutionSuccess: 0.95,
    documentationLevel: 'Extensively chronicled',
    industryLessons: 'Legendary case study'
})
WITH 1 as dummy
MATCH (c:ProductionChallenge:GeneratedByClaudeAI {name: 'The Godfather Production Obstacles'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (c)-[:AFFECTED {
    chiefChallenges: ['Studio interference', 'Casting disputes', 'Location difficulties', 'Budget constraints', 'Mafia intimidation'],
    challengeRatings: [9.5, 9.2, 8.7, 8.5, 7.9],
    riskedCancellation: true,
    studioConflicts: 'Paramount executives opposed nearly all creative decisions',
    castingBattles: ['Studio opposed Brando', 'Studio opposed Pacino', 'Studio wanted established stars'],
    locationProblems: ['Permit difficulties', 'Mafia threats', 'Neighborhood access'],
    keyAdvocates: ['Robert Evans', 'Peter Bart', 'Albert Ruddy'],
    resolutionStrategies: ['Director persistence', 'Screen tests', 'Producer diplomacy', 'Budget compromise'],
    compromisesMade: ['Budget limitations', 'Schedule tightening', 'Some cast reassignments'],
    victoriousDecisions: ['Brando casting', 'Pacino casting', 'Period setting', 'Visual style'],
    historicalLegacy: 'Template for director-studio creative battles'
}]->(g);

// Create dialect coach for authentic Italian
CREATE (DialectCoach:Person:GeneratedByClaudeAI {
    name: 'Saro Urzì',
    born: 1913,
    died: 1979,
    birthdate: date('1913-02-24'),
    deathdate: date('1979-11-01'),
    nationality: 'Italian',
    sicilianNative: true,
    isActive: false,
    firstFilm: datetime('1940-06-15T00:00:00Z'),
    lastFilm: datetime('1978-11-20T00:00:00Z'),
    careerLength: duration({years: 38}),
    dialectsKnown: 5,
    actingCredits: 98
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Saro Urzì'})
SET p.languages = ['Italian', 'Sicilian', 'English']
SET p.dialect_expertise = ['Sicilian regional variations', 'Italian regional accents', 'Italian-American adaptations']
SET p.film_appearances = ['The Godfather', 'The Leopard', 'Divorce Italian Style']
SET p.appearance_years = [1972, 1963, 1961]
SET p.teaching_methodology = 'Immersive with cultural context';

MATCH
  (s:Person:GeneratedByClaudeAI {name: 'Saro Urzì'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (s)-[:COACHED_DIALECTS_FOR {
    year: 1972,
    languagesTaught: ['Sicilian', 'Italian', 'Italian-American English'],
    actorsTrained: ['Marlon Brando', 'Al Pacino', 'James Caan', 'Robert Duvall'],
    trainingHours: 120,
    startDate: date('1971-02-15'),
    completionDate: date('1971-07-25'),
    methodsUsed: ['Phonetic breakdown', 'Cultural context', 'Phrase memorization'],
    dialectSpecifics: ['Castellammare accent', 'Corleone dialect markers', 'Generational differences'],
    pronunciationAccuracy: 0.92,
    culturalContextTeaching: 'Hand gestures, body language, social customs',
    audienceReception: 'Highly authentic to native speakers',
    caseDifferences: ['Brando: stylized but effective', 'Pacino: highly authentic', 'Caan: good for American-born character']
}]->(g);

// Create connection between Diane Keaton and Al Pacino (romantic relationship during filming)
MATCH
  (d:Person:GeneratedByClaudeAI {name: 'Diane Keaton'}),
  (a:Person:GeneratedByClaudeAI {name: 'Al Pacino'})
CREATE (d)-[:ROMANTICALLY_INVOLVED_WITH {
    startDate: date('1971-04-15'),
    endDate: date('1974-06-30'),
    relationship_duration: duration({years: 3, months: 2}),
    met_on_set: 'The Godfather',
    public_disclosure: date('1972-05-10'),
    professional_collaborations: 3,
    collaborative_projects: ['The Godfather', 'The Godfather Part II', 'Godfather Saga'],
    collaboration_years: [1972, 1974, 1977],
    on_screen_chemistry: 'Powerful, complex dynamic',
    media_coverage: 'Moderate but respectful',
    relationship_impact: 'Enhanced screen dynamics',
    relationship_end: 'Amicable, continued professional respect'
}]->(a);

// Create luxury item from the film set that became collectible
CREATE (GodftherDesk:Collectible:GeneratedByClaudeAI {
    name: 'Don Corleone\'s Desk',
    type: 'Furniture',
    material: 'Walnut',
    dimensions: '180x90x76',
    dimensionUnit: 'cm',
    weight: 125,
    weightUnit: 'kg',
    creationDate: date('1971-02-10'),
    acquisitionDate: date('1972-09-15'),
    appraised_value: 450000,
    valuation_currency: 'USD',
    insured: true,
    authenticity_verified: true,
    condition: 'Excellent'
})
WITH 1 as dummy
MATCH (c:Collectible:GeneratedByClaudeAI {name: 'Don Corleone\'s Desk'}),
      (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (c)-[:FEATURED_IN {
    scenes: ['Opening scene', 'Various office scenes'],
    screen_minutes: 18,
    significance: 'Symbolic seat of power',
    original_cost: 2500,
    auction_house: 'Christie\'s',
    auction_date: date('1999-06-15'),
    auction_lot: 157,
    hammer_price: 375000,
    buyer_premium: 75000,
    total_price: 450000,
    competing_bidders: 12,
    provenance: 'Paramount Studios → Private collection → Auction',
    exhibition_history: ['Museum of Modern Art', 'Academy Museum of Motion Pictures'],
    exhibition_dates: [date('2012-05-15'), date('2021-09-30')],
    cultural_significance: 'Iconic symbol of power and business',
    restoration: 'Minor conservation work only'
}]->(g);

// Add key producers for The Godfather
CREATE (AlbertRuddy:Person:GeneratedByClaudeAI {
    name: 'Albert S. Ruddy',
    born: 1930,
    birthdate: date('1930-03-28'),
    nationality: 'Canadian-American',
    oscarWins: 2,
    oscarNominations: 2,
    isActive: true,
    firstProduction: datetime('1965-09-15T00:00:00Z'),
    heightInMeters: 1.80,
    netWorth: 85000000,
    businessBackground: 'Construction and Architecture'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Albert S. Ruddy'})
SET p.languages = ['English', 'Italian']
SET p.production_titles = ['The Godfather', 'Million Dollar Baby', 'The Longest Yard']
SET p.production_years = [1972, 2004, 1974]
SET p.education = 'Brooklyn College, University of Southern California'
SET p.negotiation_style = 'Direct and persistent';

MATCH
  (a:Person:GeneratedByClaudeAI {name: 'Albert S. Ruddy'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (a)-[:PRODUCED {
    role: 'Primary Producer',
    contractSigned: date('1970-09-15'),
    budget_secured: 6000000,
    profit_percentage: 0.08,
    production_challenges: ['Studio interference', 'Casting battles', 'Location security', 'Budget constraints'],
    key_decisions: ['Supporting Coppola vision', 'Negotiating with real mafia figures', 'Managing studio expectations'],
    day_to_day_involvement: 'Very high',
    crisis_management: 'Essential buffer between director and studio',
    studio_relationship: 'Contentious but effective',
    marketing_input: 'Moderate',
    award_acceptance: 'Accepted Best Picture Oscar',
    career_impact: 'Defining project',
    production_company: 'Alfran Productions'
}]->(g);

CREATE (RobertEvans:Person:GeneratedByClaudeAI {
    name: 'Robert Evans',
    born: 1930,
    died: 2019,
    birthdate: date('1930-06-29'),
    deathdate: date('2019-10-26'),
    nationality: 'American',
    oscarNominations: 0,
    isActive: false,
    firstProduction: datetime('1967-05-15T00:00:00Z'),
    lastProduction: datetime('2003-11-25T00:00:00Z'),
    careerLength: duration({years: 36}),
    heightInMeters: 1.78,
    studioExecutive: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Robert Evans'})
SET p.languages = ['English']
SET p.studio_role = 'Head of Production, Paramount Pictures'
SET p.key_productions = ['The Godfather', 'Chinatown', 'Rosemary\'s Baby', 'Love Story']
SET p.production_years = [1972, 1974, 1968, 1970]
SET p.business_background = 'Actor turned executive';

MATCH
  (r:Person:GeneratedByClaudeAI {name: 'Robert Evans'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (r)-[:EXECUTIVE_PRODUCED {
    role: 'Head of Production at Paramount',
    authority_level: 'Final approval on major decisions',
    budget_approval: date('1970-08-10'),
    risk_assessment: 'High risk with high potential',
    studio_advocates: ['Peter Bart', 'Stanley Jaffe'],
    studio_opponents: ['Charles Bluhdorn', 'Frank Yablans'],
    key_contributions: ['Approving Coppola as director', 'Supporting Brando casting', 'Defending film runtime'],
    corporate_pressure_handling: 'Repeatedly risked position to protect film',
    marketing_strategies: ['Emphasize bestselling novel connection', 'Focus on family drama, not just crime'],
    boardroom_battles: 5,
    personal_stake: 'Reputation and career',
    retrospective_assessment: 'Career-defining decision'
}]->(g);

// Add Charles Bluhdorn as the Gulf+Western CEO (parent company of Paramount)
CREATE (CharlesBluhdorn:Person:GeneratedByClaudeAI {
    name: 'Charles Bluhdorn',
    born: 1926,
    died: 1983,
    birthdate: date('1926-09-13'),
    deathdate: date('1983-02-19'),
    nationality: 'Austrian-American',
    isActive: false,
    corporateRole: 'Chairman and CEO, Gulf+Western',
    heightInMeters: 1.75,
    netWorth: 100000000,
    businessBackground: 'Conglomerate building'
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Charles Bluhdorn'})
SET p.languages = ['English', 'German']
SET p.business_titles = ['Chairman', 'CEO', 'President']
SET p.business_entities = ['Gulf+Western', 'Paramount Pictures (parent company)', 'Madison Square Garden']
SET p.leadership_years = ['1956-1983']
SET p.acquisition_strategy = 'Aggressive conglomeration';

MATCH
  (c:Person:GeneratedByClaudeAI {name: 'Charles Bluhdorn'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (c)-[:CORPORATE_OVERSIGHT {
    company_role: 'Chairman and CEO of Gulf+Western (Paramount parent)',
    investment_approval: true,
    budget_concerns: 'Significant initial skepticism',
    profit_expectations: 'Limited initial expectations',
    corporate_interference: 'Several attempts to redirect project',
    key_interventions: ['Initial opposition to Coppola', 'Questioning Brando insurance', 'Budget limitation enforcement'],
    quarterly_reports_impact: 'Monitored project as significant financial risk',
    executive_chain: 'Bluhdorn → Frank Yablans → Robert Evans → Albert Ruddy',
    reaction_to_success: 'Claimed credit in annual report',
    financial_analysis_commissioned: 'Return-on-investment case study',
    shareholder_communication: 'Highlighted in 1972 annual report',
    corporate_strategy_impact: 'Influenced future film investment strategy'
}]->(g);

// Add Peter Bart as development executive
CREATE (PeterBart:Person:GeneratedByClaudeAI {
    name: 'Peter Bart',
    born: 1932,
    birthdate: date('1932-07-24'),
    nationality: 'American',
    isActive: false,
    firstPosition: datetime('1967-08-15T00:00:00Z'),
    heightInMeters: 1.79,
    executiveRole: 'Paramount Pictures VP of Production',
    journalismBackground: true,
    tradePublicationLeadership: true
})
WITH 1 as dummy
MATCH (p:Person:GeneratedByClaudeAI {name: 'Peter Bart'})
SET p.languages = ['English']
SET p.career_positions = ['Paramount Pictures executive', 'New York Times reporter', 'Variety Editor-in-Chief']
SET p.position_years = ['1967-1975', '1961-1967', '1989-2009']
SET p.key_developments = ['The Godfather', 'Harold and Maude', 'Paper Moon']
SET p.development_years = [1972, 1971, 1973];

MATCH
  (p:Person:GeneratedByClaudeAI {name: 'Peter Bart'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (p)-[:DEVELOPED {
    executive_role: 'Vice President of Production at Paramount',
    project_champion: true,
    book_rights_advocate: true,
    development_start: date('1969-07-10'),
    novel_acquisition: date('1969-03-10'),
    price_negotiated: 12500,
    price_currency: 'USD',
    key_negotiations: ['Novel rights', 'Coppola contract', 'Budget approvals'],
    director_selection_influence: 'Strongly advocated for Coppola after others declined',
    script_development_supervision: 'Multiple drafts reviewed',
    project_timeline_oversight: 'Maintained pressure for timely delivery',
    production_notes_provided: 'Extensive screenplay feedback',
    internal_advocacy: 'Crucial support within Paramount hierarchy',
    creative_insights: 'Recognized potential despite commercial risk'
}]->(g);

// Add Paramount Pictures as the main studio
CREATE (ParamountPictures:Studio:GeneratedByClaudeAI {
    name: 'Paramount Pictures Corporation',
    founded: date('1912-05-08'),
    reorganized: date('1966-10-19'),
    headquartersLat: 34.0841,
    headquartersLong: -118.3213,
    yearlyRevenue1971: 96000000,
    yearlyRevenue1972: 129000000,
    yearlyRevenue1973: 152000000,
    filmReleases1972: 18,
    totalStudioLots: 2,
    totalSoundstages: 30,
    employeeCount: 2450,
    parentCompany: 'Gulf+Western Industries'
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Paramount Pictures Corporation'})
SET s.subsidiaries = ['Paramount Television', 'Famous Music', 'Paramount Home Entertainment']
SET s.distribution_markets = ['Global']
SET s.studioLotsLat = [34.0841, 40.7590]
SET s.studioLotsLong = [-118.3213, -73.9845]
SET s.chairmen_history = ['Adolph Zukor', 'Barney Balaban', 'Charles Bluhdorn']
SET s.production_heads = ['Robert Evans', 'Frank Yablans', 'Barry Diller']
SET s.mountain_logo = true;

MATCH
  (p:Studio:GeneratedByClaudeAI {name: 'Paramount Pictures Corporation'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (p)-[:STUDIO_PRODUCED {
    project_greenlight: date('1970-08-10'),
    total_investment: 6000000,
    return: 245066411,
    roi: 40.84,
    production_account: 'PA-GF-1971-001',
    financial_risk_assessment: 'High',
    completion_guarantor: 'Film Finances, Inc.',
    insurance_underwriter: 'Lloyd\'s of London',
    special_insurance: 'Marlon Brando health policy',
    production_facilities_provided: ['Soundstages 14-16', 'Backlot streets', 'Editing suites'],
    distribution_commitment: 'Wide national release',
    marketing_budget_initial: 1000000,
    marketing_budget_expanded: 1500000,
    theatrical_distribution_strategy: 'Platform release expanding to wide',
    corporate_tension: 'Significant throughout production',
    profit_participants: ['Coppola', 'Puzo', 'Brando', 'Paramount executives'],
    profit_sharing_tiers: ['First dollar gross', 'Net profit', 'Backend points']
}]->(g);

// Add Alfran Productions as the production company
CREATE (AlfranProductions:Studio:GeneratedByClaudeAI {
    name: 'Alfran Productions',
    founded: date('1970-06-15'),
    headquarters: 'Los Angeles',
    headquartersLat: 34.0522,
    headquartersLong: -118.2437,
    employeeCount: 8,
    annualBudget: 6500000,
    companyType: 'Independent Production Company',
    namedFor: 'Albert Francis Ruddy',
    parentCompany: null,
    officeSpace: 1200,
    officeSpaceUnit: 'square feet'
})
WITH 1 as dummy
MATCH (s:Studio:GeneratedByClaudeAI {name: 'Alfran Productions'})
SET s.production_titles = ['The Godfather', 'The Longest Yard', 'Matilda']
SET s.production_years = [1972, 1974, 1978]
SET s.studio_partnerships = ['Paramount Pictures', 'Columbia Pictures']
SET s.founded_for = 'The Godfather production'
SET s.company_structure = 'S-Corporation';

MATCH
  (a:Studio:GeneratedByClaudeAI {name: 'Alfran Productions'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (a)-[:PRODUCTION_COMPANY_FOR {
    contract_signed: date('1970-06-15'),
    legal_entity_type: 'Special Purpose Vehicle',
    paramount_deal_terms: 'Negative pickup arrangement',
    company_formed_for_film: true,
    production_staff: 8,
    overhead_budget: 450000,
    office_location: 'Paramount lot, bungalow C',
    company_responsibilities: ['Physical production', 'Budget management', 'Location logistics', 'Cast and crew contracts'],
    liability_coverage: 10000000,
    completion_bond: 6500000,
    production_bank: 'Bank of America',
    production_account_number: 'GF-7172-AP',
    signatory_status: 'Full unions signatory',
    cost_reporting_frequency: 'Weekly',
    paramount_oversight_level: 'High'
}]->(g);

// Add Gulf+Western as the parent corporation
CREATE (GulfWestern:Business:GeneratedByClaudeAI {
    name: 'Gulf+Western Industries',
    founded: date('1956-09-15'),
    acquired_paramount: date('1966-10-19'),
    headquartersLat: 40.7484,
    headquartersLong: -73.9857,
    employees: 100000,
    annualRevenue1972: 3500000000,
    marketValueUSD1972: 1750000000,
    publiclyTraded: true,
    tickerSymbol: 'GW',
    ceoCompensation: 450000,
    globalOperations: 35,
    diversificationLevel: 'Extreme',
    conglomerateStructure: true
})
WITH 1 as dummy
MATCH (b:Business:GeneratedByClaudeAI {name: 'Gulf+Western Industries'})
SET b.business_sectors = ['Entertainment', 'Manufacturing', 'Financial Services', 'Automotive', 'Sugar Production']
SET b.key_subsidiaries = ['Paramount Pictures', 'Madison Square Garden', 'Simon & Schuster', 'Consolidated Cigar', 'New Jersey Zinc']
SET b.annual_reports = [1967, 1968, 1969, 1970, 1971, 1972, 1973]
SET b.ceo_tenure = '1956-1983'
SET b.acquisition_strategy = 'Aggressive conglomeration';

MATCH
  (g:Business:GeneratedByClaudeAI {name: 'Gulf+Western Industries'}),
  (p:Studio:GeneratedByClaudeAI {name: 'Paramount Pictures Corporation'})
CREATE (g)-[:CORPORATE_PARENT_OF {
    acquisition_date: date('1966-10-19'),
    acquisition_price: 125000000,
    price_currency: 'USD',
    ownership_percentage: 100.0,
    board_seats: 5,
    corporate_representatives: ['Charles Bluhdorn', 'David Judelson', 'Martin Davis'],
    annual_investment: 50000000,
    profit_expectation: 15.5,
    expectation_unit: 'Percentage',
    quarterly_reviews: 4,
    financial_reporting_requirements: 'Extensive',
    autonomy_level: 'Moderate',
    capital_allocation_committee: 'Yes',
    investment_approval_threshold: 1000000,
    corporate_synergy_requirements: 'Limited',
    conglomerate_portfolio_position: 'Prestige acquisition'
}]->(p);

MATCH
  (g:Business:GeneratedByClaudeAI {name: 'Gulf+Western Industries'}),
  (gf:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (g)-[:ULTIMATE_OWNER {
    investment_category: 'Entertainment division capital expenditure',
    board_approval: date('1970-07-15'),
    financial_oversight: 'Quarterly review',
    risk_assessment: 'High risk, high potential return',
    corporate_resources_allocated: 'Studio facilities and distribution network',
    project_code: 'PAR-71-GF',
    quarterly_reports_mentioned: 4,
    annual_report_highlight: 'Featured in 1972 shareholder letter',
    stock_impact: 'Positive after release',
    conglomerate_synergy_attempts: 'Book publishing division promotion',
    executive_visits: 3,
    shareholder_questions: 'Addressed in 1972 annual meeting',
    financial_impact_rating: 'Significant to entertainment division',
    corporate_prestige_factor: 'Major enhancement to corporate image'
}]->(gf);

// Add detailed budget breakdown for The Godfather
CREATE (GodfatherBudget:FinancialRecord:GeneratedByClaudeAI {
    name: 'The Godfather Budget',
    created: date('1970-09-15'),
    finalized: date('1971-02-28'),
    total_amount: 6000000,
    currency: 'USD',
    accounting_standard: 'Film industry standard',
    line_items: 215,
    revisions: 12,
    final_approval: date('1971-03-01'),
    tracking_system: 'Weekly variance reports',
    accounting_firm: 'Price Waterhouse',
    audit_status: 'Fully audited',
    preservation_status: 'Paramount financial archives'
})
WITH 1 as dummy
MATCH (f:FinancialRecord:GeneratedByClaudeAI {name: 'The Godfather Budget'})
SET f.department_allocations = ['Cast', 'Crew', 'Sets', 'Locations', 'Wardrobe', 'Transportation', 'Post-production', 'Music']
SET f.department_amounts = [1300000, 1100000, 800000, 950000, 350000, 400000, 600000, 500000]
SET f.contingency_amount = 500000
SET f.completion_bond = 450000
SET f.insurance_costs = 350000
SET f.major_overages = ['Sicily location', 'Extended shooting schedule', 'Special effects']
SET f.overage_amounts = [175000, 225000, 125000];

MATCH
  (f:FinancialRecord:GeneratedByClaudeAI {name: 'The Godfather Budget'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (f)-[:FINANCIAL_PLAN_FOR {
    prepared_by: 'Paramount Pictures Financial Affairs',
    authorized_by: 'Robert Evans, Albert S. Ruddy',
    initial_budget: 4500000,
    final_budget: 6000000,
    actual_spend: 6200000,
    variance_percentage: 3.33,
    cost_overrun_approval: date('1971-07-10'),
    cost_categories: ['Above-the-line', 'Below-the-line', 'Post-production', 'Other'],
    category_allocations: [2500000, 2300000, 700000, 500000],
    key_talent_costs: ['Brando: $50,000 + points', 'Pacino: $35,000', 'Caan: $35,000'],
    set_construction_costs: 625000,
    location_fees: 345000,
    transportation_logistics: 285000,
    daily_shooting_costs: 42000,
    accounting_code: 'PAR-71-GF-FIN',
    financial_reporting_cycle: 'Weekly with monthly summaries',
    studio_overhead_allocation: 750000,
    distribution_advance: 1500000
}]->(g);

// Add box office performance details
CREATE (GodfatherBoxOffice:FinancialRecord:GeneratedByClaudeAI {
    name: 'The Godfather Box Office Performance',
    created: date('1972-12-31'),
    updated: date('1975-06-30'),
    total_amount: 245066411,
    currency: 'USD',
    accounting_standard: 'MPAA reporting standards',
    line_items: 45,
    revisions: 8,
    final_certification: date('1975-07-15'),
    tracking_system: 'Paramount distribution reports',
    accounting_firm: 'Price Waterhouse',
    audit_status: 'Fully audited',
    preservation_status: 'Paramount financial archives'
})
WITH 1 as dummy
MATCH (f:FinancialRecord:GeneratedByClaudeAI {name: 'The Godfather Box Office Performance'})
SET f.revenue_streams = ['Domestic theatrical', 'International theatrical', 'Re-releases', 'Television rights', 'Early ancillary']
SET f.revenue_amounts = [134966411, 110100000, 5000000, 12000000, 8000000]
SET f.top_markets = ['United States', 'United Kingdom', 'France', 'Italy', 'Japan', 'Germany']
SET f.market_revenues = [129966411, 18500000, 16200000, 15800000, 14600000, 13500000]
SET f.theatrical_runs = 3
SET f.peak_theaters = 1150
SET f.weeks_in_release = 78;

MATCH
  (f:FinancialRecord:GeneratedByClaudeAI {name: 'The Godfather Box Office Performance'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (f)-[:FINANCIAL_PERFORMANCE_OF {
    tracking_start: date('1972-03-24'),
    tracking_end: date('1975-06-30'),
    opening_weekend: 302393,
    opening_theaters: 5,
    platform_release: true,
    wide_release_date: date('1972-04-07'),
    wide_release_theaters: 316,
    peak_weekly_gross: 5263765,
    weeks_at_number_one: 8,
    domestic_total: 134966411,
    international_total: 110100000,
    distribution_fee_percentage: 30,
    exhibitor_split_percentage: 55,
    profit_calculation_method: 'Standard distribution waterfall',
    profit_participants: ['Paramount', 'Producers', 'Director', 'Key cast', 'Mario Puzo'],
    profit_tiers: ['First dollar gross', 'Adjusted gross', 'Net profit'],
    breakeven_date: date('1972-05-12'),
    profit_participation_payments: 25000000,
    studio_net_profit: 115000000
}]->(g);

// Add theatrical distribution details
CREATE (GodfatherDistribution:DistributionPlan:GeneratedByClaudeAI {
    name: 'The Godfather Theatrical Distribution Strategy',
    created: date('1971-12-15'),
    implemented: date('1972-03-24'),
    territories: 62,
    domestic_theaters_initial: 5,
    domestic_theaters_wide: 316,
    international_territories: 61,
    language_versions: 32,
    subtitled_versions: 38,
    dubbed_versions: 20,
    print_count_domestic: 350,
    print_count_international: 850,
    marketing_territories: 45
})
WITH 1 as dummy
MATCH (d:DistributionPlan:GeneratedByClaudeAI {name: 'The Godfather Theatrical Distribution Strategy'})
SET d.release_strategy = 'Platform release expanding to wide'
SET d.key_markets = ['United States', 'Canada', 'United Kingdom', 'France', 'Italy', 'Japan', 'Germany']
SET d.release_dates = ['1972-03-24', '1972-03-24', '1972-08-24', '1972-10-18', '1972-09-14', '1972-12-09', '1972-09-28']
SET d.censorship_issues = ['Italy', 'Spain', 'South Korea', 'Philippines']
SET d.distribution_partners = ['United International Pictures', 'CIC']
SET d.theatrical_windows = 'Extended due to popularity';

MATCH
  (d:DistributionPlan:GeneratedByClaudeAI {name: 'The Godfather Theatrical Distribution Strategy'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (d)-[:DISTRIBUTION_STRATEGY_FOR {
    plan_architect: 'Frank Yablans, Paramount Distribution',
    release_pattern: 'Platform release with slow geographic expansion',
    initial_markets: ['New York', 'Los Angeles', 'Chicago', 'San Francisco', 'Boston'],
    expansion_timeline: 'Weekly addition of top 10 markets',
    nationwide_date: date('1972-04-07'),
    print_strategy: 'Limited initial with expansion as demand proven',
    theaters_targeted: 'Premium first-run venues with prestige positioning',
    booking_approach: 'Reserved seating in select venues',
    run_length_guarantee: 'Minimum 4 weeks with extension options',
    exhibition_terms: '90/10 first week, 80/20 second week, 70/30 third week, 60/40 thereafter',
    international_strategy: 'Major European markets 4-6 months after US',
    censorship_negotiations: 'Significant in catholic countries',
    release_pattern_success_metrics: 'Word-of-mouth amplification, sustained weekly grosses',
    distribution_team_size: 85,
    logistics_base: 'Paramount distribution headquarters, New York'
}]->(g);

// Add marketing campaign details
CREATE (GodfatherMarketing:MarketingCampaign:GeneratedByClaudeAI {
    name: 'The Godfather Marketing Campaign',
    created: date('1971-10-15'),
    launched: date('1972-01-15'),
    completed: date('1972-06-30'),
    total_budget: 1500000,
    currency: 'USD',
    target_demographics: 'Adult males 18-49, secondary adult females 25-54',
    markets: 'National with urban emphasis',
    creative_agencies: 3,
    media_buyers: 2,
    publicists: 8,
    press_events: 12,
    premieres: 5,
    awards_campaign: true,
    taglines: 4
})
WITH 1 as dummy
MATCH (m:MarketingCampaign:GeneratedByClaudeAI {name: 'The Godfather Marketing Campaign'})
SET m.marketing_channels = ['Print', 'Television', 'Radio', 'Outdoor', 'Theatrical trailers', 'Press coverage']
SET m.channel_allocation = [350000, 450000, 200000, 150000, 100000, 250000]
SET m.key_publications = ['New York Times', 'Time Magazine', 'Variety', 'Hollywood Reporter', 'Life Magazine']
SET m.tv_networks = ['ABC', 'CBS', 'NBC']
SET m.key_visuals = ['Marlon Brando portrait', 'Puppet strings logo', 'Wedding scene']
SET m.campaign_phases = ['Teaser', 'Novel connection', 'Critical acclaim', 'Awards push'];

MATCH
  (m:MarketingCampaign:GeneratedByClaudeAI {name: 'The Godfather Marketing Campaign'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (m)-[:MARKETED {
    campaign_director: 'Martin Davis, Paramount VP Marketing',
    primary_tagline: 'The Godfather - the most anticipated film of the year',
    secondary_tagline: 'An offer you can\'t refuse',
    campaign_concept: 'Prestige literary adaptation with star power',
    key_art_development: 'Puppet strings concept with strong Brando imagery',
    media_strategy: 'Heavy emphasis on print media and selective television',
    publicity_focus: 'Brando comeback, literary source, Italian-American saga',
    controversy_management: 'Italian-American civic groups concerns addressed',
    preview_screenings: 25,
    media_impressions: 250000000,
    press_coverage_inches: 14500,
    tv_spot_count: 12,
    radio_spot_count: 24,
    newspaper_insertions: 450,
    magazine_insertions: 65,
    billboard_locations: 35,
    premiere_strategy: 'Exclusive New York opening with celebrity attendance',
    promotional_partnerships: 'Fawcett Books (novel tie-in)',
    merchandising_limited: 'Minimal due to adult theme'
}]->(g);

// Add film investment structure
CREATE (GodfatherFinancing:FinancialStructure:GeneratedByClaudeAI {
    name: 'The Godfather Production Financing',
    created: date('1970-08-15'),
    executed: date('1970-09-20'),
    total_amount: 6000000,
    currency: 'USD',
    structure_type: 'Studio financing with completion bond',
    primary_investor: 'Paramount Pictures (Gulf+Western)',
    secondary_investors: 'None',
    gap_financing: 'None',
    tax_structures: 'Standard US production',
    completion_guarantor: 'Film Finances, Inc.',
    banking_partner: 'Bank of America',
    legal_counsel: 'Paramount legal department'
})
WITH 1 as dummy
MATCH (f:FinancialStructure:GeneratedByClaudeAI {name: 'The Godfather Production Financing'})
SET f.funding_sources = ['Studio equity', 'Distribution advances', 'Foreign pre-sales']
SET f.funding_amounts = [4500000, 1000000, 500000]
SET f.financial_triggers = ['Script approval', 'Cast approval', 'Production commencement', 'Rough cut delivery']
SET f.trigger_payments = [500000, 1500000, 3000000, 1000000]
SET f.recoupment_priority = ['Distribution expenses', 'Negative cost', 'Studio overhead', 'Profit participants']
SET f.risk_mitigation = 'Full completion bond with contingency';

MATCH
  (f:FinancialStructure:GeneratedByClaudeAI {name: 'The Godfather Production Financing'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (f)-[:FINANCED {
    deal_structure: 'Studio financing with negative pickup',
    financing_method: 'Direct studio investment from Gulf+Western capital allocation',
    funding_approvals: 'Corporate investment committee and studio head',
    payment_schedule: 'Pre-production, principal photography, post-production phases',
    cash_flow_management: 'Weekly disbursement against approved budget',
    financial_controls: 'Daily cost reports, weekly variance analysis',
    completion_guarantee: 'Full guarantee with studio as beneficiary',
    insurance_coverage: 'Cast, negative, props, general liability, errors and omissions',
    currency_hedging: 'Forward contracts for Italian lira during Sicily filming',
    tax_considerations: 'Standard US production without special incentives',
    profit_definition: 'Standard distribution waterfall with negotiated definitions',
    financial_reporting_requirements: 'Weekly to Paramount, monthly to Gulf+Western',
    audit_rights: 'Studio, completion guarantor, and profit participants',
    banking_relationships: 'Production account through Bank of America',
    financial_close_process: 'Final cost report and audit completed November 1972'
}]->(g);

// Add contracts and negotiations
CREATE (GodfatherContracts:LegalDocument:GeneratedByClaudeAI {
    name: 'The Godfather Key Contracts Collection',
    created: date('1970-08-01'),
    executed: date('1971-02-28'),
    document_count: 287,
    pages_total: 1450,
    signatories: 312,
    amendments: 45,
    legal_jurisdictions: 5,
    governing_law: 'California',
    dispute_mechanisms: 'Arbitration with JAMS',
    confidentiality_level: 'High',
    storage_location: 'Paramount legal archives'
})
WITH 1 as dummy
MATCH (l:LegalDocument:GeneratedByClaudeAI {name: 'The Godfather Key Contracts Collection'})
SET l.contract_types = ['Employment', 'Rights acquisitions', 'Location agreements', 'Distribution', 'Licensing']
SET l.contract_counts = [145, 38, 52, 12, 40]
SET l.key_signatories = ['Paramount Pictures', 'Francis Ford Coppola', 'Mario Puzo', 'Marlon Brando', 'Al Pacino']
SET l.legal_disputes = 2
SET l.dispute_resolutions = ['Settlement', 'Arbitration ruling']
SET l.template_sources = ['Paramount standard agreements', 'WGA agreements', 'SAG agreements'];

MATCH
  (l:LegalDocument:GeneratedByClaudeAI {name: 'The Godfather Key Contracts Collection'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (l)-[:LEGAL_FRAMEWORK_FOR {
    chief_counsel: 'Barry Langberg, Paramount Pictures',
    key_agreements: ['Novel rights acquisition', 'Director employment', 'Cast agreements', 'Production services', 'Distribution'],
    novel_rights_acquired: date('1969-03-10'),
    rights_purchase_price: 12500,
    rights_additional_terms: 'Percentage of net profits, sequel rights options',
    director_contract_executed: date('1970-09-05'),
    director_compensation: '$125,000 plus 6% of net profits',
    brando_contract_special_terms: '$50,000 plus $50,000 bonus and percentage of gross',
    pacino_contract_negotiations: 'Lengthy with multiple screen tests required',
    pacino_final_terms: '$35,000 with small percentage of profits',
    guild_agreements: 'WGA, DGA, SAG, IATSE, Teamsters',
    completion_guarantor_contract: 'Film Finances, Inc. - standard terms',
    location_agreement_challenges: 'New York permits required political intervention',
    music_rights_clearances: 'Extensive for wedding sequence',
    contract_execution_timeline: 'Accelerated to meet production schedule',
    legal_department_staffing: '4 attorneys dedicated to production',
    rights_chain_documentation: 'Complete with title clearance report'
}]->(g);

// Add production logistics details
CREATE (GodfatherLogistics:ProductionLogistics:GeneratedByClaudeAI {
    name: 'The Godfather Production Logistics',
    created: date('1970-11-15'),
    implemented: date('1971-03-29'),
    completed: date('1971-08-07'),
    total_shooting_days: 93,
    locations: 14,
    soundstages: 4,
    cast_members: 110,
    crew_size: 120,
    extras_total: 450,
    vehicles_used: 85,
    equipment_vendors: 35,
    catering_services: 2,
    hotel_room_nights: 4500
})
WITH 1 as dummy
MATCH (p:ProductionLogistics:GeneratedByClaudeAI {name: 'The Godfather Production Logistics'})
SET p.location_types = ['Urban streets', 'Estates', 'Sound stages', 'Restaurants', 'Churches', 'International']
SET p.location_shooting_days = [35, 12, 24, 8, 5, 9]
SET p.primary_locations = ['New York City', 'Long Island', 'Los Angeles', 'Sicily']
SET p.location_days = [28, 14, 45, 6]
SET p.transportation_fleet = ['Cast cars', 'Crew vans', 'Equipment trucks', 'Period vehicles', 'Production RVs']
SET p.fleet_counts = [12, 8, 15, 32, 4];

MATCH
  (p:ProductionLogistics:GeneratedByClaudeAI {name: 'The Godfather Production Logistics'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (p)-[:OPERATIONS_FOR {
    production_manager: 'Fred Gallo',
    first_assistant_director: 'Fred Roos',
    location_manager: 'Robert Greenhut',
    shooting_schedule: 'March 29, 1971 to August 7, 1971',
    shooting_order: 'Non-sequential based on location availability',
    company_moves: 26,
    daily_call_times: '6:00 AM typical',
    average_wrap_time: '7:30 PM typical',
    overtime_frequency: '35% of shooting days',
    weather_delays: 9,
    crew_composition: 'Union with Italian specialists',
    equipment_package: 'Panavision cameras with extensive lighting',
    dailies_review: 'Evening screenings at Paramount',
    security_concerns: 'High in New York locations',
    mafia_interactions: 'Several unofficially documented',
    permit_challenges: 'Significant in New York',
    sicily_logistics: 'Challenging with limited infrastructure',
    production_office_locations: ['Paramount Studios', 'New York location office'],
    communication_systems: 'Pre-mobile era with runners and radios',
    catering_approach: 'Full Italian meals featured',
    transportation_coordination: 'Complex for period vehicles and equipment',
    accommodation_strategy: 'Hotels near location clusters',
    insurance_claims: 3,
    safety_incidents: 'Minor only'
}]->(g);

// Add international distribution partners
CREATE (InternationalDistribution:DistributionNetwork:GeneratedByClaudeAI {
    name: 'The Godfather International Distribution Network',
    established: date('1971-12-10'),
    activated: date('1972-03-24'),
    territories: 62,
    distribution_partners: 24,
    language_versions: 32,
    subtitled_markets: 38,
    dubbed_markets: 20,
    censorship_challenges: 8,
    material_delivery_date: date('1972-02-15'),
    international_prints: 850,
    marketing_localization: 42,
    box_office_reporting: 'Weekly'
})
WITH 1 as dummy
MATCH (d:DistributionNetwork:GeneratedByClaudeAI {name: 'The Godfather International Distribution Network'})
SET d.key_markets = ['United Kingdom', 'France', 'Italy', 'Germany', 'Japan', 'Australia', 'Brazil', 'Mexico']
SET d.market_distributors = ['CIC', 'Paramount France', 'Dear Film', 'CIC Germany', 'Toho-Towa', 'CIC Australia', 'Paramount Brazil', 'Paramount Mexico']
SET d.release_dates = ['1972-08-24', '1972-10-18', '1972-09-14', '1972-09-28', '1972-12-09', '1972-08-30', '1972-11-02', '1972-10-05']
SET d.censorship_countries = ['Italy', 'Spain', 'Ireland', 'South Korea', 'Philippines', 'South Africa', 'Brazil', 'Argentina']
SET d.censorship_issues = ['Violence', 'Crime glorification', 'Religious disrespect', 'Language', 'Sexual content']
SET d.international_awards = 35;

MATCH
  (d:DistributionNetwork:GeneratedByClaudeAI {name: 'The Godfather International Distribution Network'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (d)-[:DISTRIBUTED {
    distribution_head: 'Frank Yablans, Paramount International',
    global_strategy: 'Staggered release focusing on major territories first',
    distribution_model: 'Studio-owned distribution in major markets, sub-distributors in smaller territories',
    revenue_split_structure: 'Varied by territory, averaging 35-40% to distributor',
    materials_provided: ['35mm prints', 'Marketing materials', 'Press kits', 'Publicity stills'],
    subtitle_quality_control: 'Rigorous with cultural consultants',
    dubbing_supervision: 'Director-approved voice casting in major markets',
    censorship_negotiation_strategy: 'Minimal cuts with alternative versions prepared',
    international_premiere_approach: 'Major festival launches where possible',
    european_distribution_headquarters: 'London with Paris satellite',
    asian_distribution_headquarters: 'Tokyo',
    latin_american_coordination: 'Mexico City',
    box_office_collection_methods: 'On-ground auditors in key markets',
    currency_repatriation_challenges: 'Significant in developing markets',
    piracy_protection_measures: 'Print serialization and security',
    international_critical_reception: 'Overwhelmingly positive',
    cultural_impact_variance: 'Strongest in Italy, significant worldwide'
}]->(g);

// Add the production insurance policy
CREATE (GodfatherInsurance:InsurancePolicy:GeneratedByClaudeAI {
    name: 'The Godfather Production Insurance Package',
    issued: date('1971-02-15'),
    effective: date('1971-03-01'),
    expiration: date('1971-12-31'),
    premium_total: 350000,
    currency: 'USD',
    underwriter: 'Lloyd\'s of London',
    broker: 'Marsh & McLennan',
    policy_number: 'PP-GF-7172-001',
    coverage_limit: 12000000,
    deductible: 50000,
    claims_filed: 3,
    claims_paid: 2,
    claims_total: 85000
})
WITH 1 as dummy
MATCH (i:InsurancePolicy:GeneratedByClaudeAI {name: 'The Godfather Production Insurance Package'})
SET i.coverage_types = ['Cast insurance', 'Negative insurance', 'Props & sets', 'Third-party liability', 'Workers compensation', 'E&O insurance']
SET i.coverage_limits = [5000000, 2000000, 1500000, 2000000, 1000000, 500000]
SET i.special_endorsements = ['Marlon Brando health', 'Sicily filming', 'Vintage automobiles', 'Period weapons']
SET i.premium_allocations = [120000, 85000, 60000, 40000, 25000, 20000]
SET i.excluded_risks = ['War', 'Nuclear incident', 'Intentional damage', 'Pre-existing conditions']
SET i.policy_extensions = 2;

MATCH
  (i:InsurancePolicy:GeneratedByClaudeAI {name: 'The Godfather Production Insurance Package'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (i)-[:INSURED {
    policy_holder: 'Paramount Pictures/Alfran Productions',
    additional_insureds: ['Cast members', 'Key crew', 'Location owners', 'Equipment vendors'],
    special_risk_assessment: 'High-profile production with multiple risk factors',
    brando_medical_examination: date('1971-02-20'),
    medical_underwriting: 'Extensive for lead actors',
    location_risk_surveys: 'Completed for all shooting locations',
    script_breakdown_analysis: 'Scene-by-scene risk assessment',
    stunt_coordination_review: 'Pre-approved with safety protocols',
    completion_bond_integration: 'Coordinated coverage with Film Finances, Inc.',
    claim_incidents: ['Minor set damage', 'Equipment theft', 'Weather delay'],
    claim_resolutions: ['Paid in full', 'Paid partial', 'Denied'],
    policy_adjustments: 'Extended twice for post-production',
    premium_payment_schedule: 'Quarterly with final audit',
    certificate_holders: 15,
    international_coverage_extensions: 'Special rider for Sicily',
    coverage_territories: 'Worldwide with notification requirements',
    exclusions_negotiated: 'Reduced war risk exclusion for Sicily',
    risk_management_program: 'Weekly safety meetings and reports'
}]->(g);

// Add archive and preservation details
CREATE (GodfatherPreservation:ArchiveRecord:GeneratedByClaudeAI {
    name: 'The Godfather Preservation Project',
    established: date('1990-05-15'),
    updated: date('2020-09-30'),
    materials_cataloged: 1450,
    physical_elements: 385,
    digital_elements: 1065,
    storage_locations: 4,
    climate_controlled: true,
    disaster_recovery_plan: true,
    access_level: 'Restricted',
    scholarly_access: 'By application',
    public_exhibitions: 15,
    restoration_projects: 4,
    preservation_budget: 1750000,
    historical_designation: 'National Film Registry'
})
WITH 1 as dummy
MATCH (a:ArchiveRecord:GeneratedByClaudeAI {name: 'The Godfather Preservation Project'})
SET a.material_types = ['Original negative', 'Camera reports', 'Sound elements', 'Continuity photos', 'Production documents', 'Marketing materials']
SET a.material_counts = [15, 125, 85, 450, 650, 125]
SET a.storage_facilities = ['Paramount Archives', 'Library of Congress', 'Academy Film Archive', 'Eastman House']
SET a.restoration_years = [1997, 2007, 2015, 2022]
SET a.restoration_technologies = ['Photochemical', 'Digital 2K', 'Digital 4K', 'Digital 4K HDR']
SET a.access_requests_annual = 45;

MATCH
  (a:ArchiveRecord:GeneratedByClaudeAI {name: 'The Godfather Preservation Project'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (a)-[:PRESERVES {
    preservation_status: 'Full archival protection',
    original_negative_condition: 'Good with some deterioration addressed',
    preservation_elements_created: 'Multiple fine grain masters and digital masters',
    digital_scan_resolution: '4K from original negative',
    color_timing_reference: 'Gordon Willis approved timing lights',
    audio_preservation: 'Original magnetic stems to digital',
    paper_materials_digitization: '100% with acid-free storage of originals',
    conservation_treatments: 'Completed with minimal intervention philosophy',
    access_copies_available: 'Various formats for approved researchers',
    rights_documentation: 'Comprehensive with chain of title',
    cultural_significance_documentation: 'Extensive scholarly analysis',
    technical_history_documentation: 'Complete production technology context',
    restoration_philosophy: 'Maintain original artistic intent',
    director_involvement: 'Francis Ford Coppola approved final restorations',
    cinematographer_consultation: 'Gordon Willis consulted until his death',
    registered_cultural_heritage: 'Multiple national registries',
    preservation_partners: 'Major film archives and Paramount',
    future_preservation_plan: 'Ongoing monitoring with technology migration'
}]->(g);

// Add labor relations and union agreements
CREATE (GodfatherLaborRelations:LaborAgreement:GeneratedByClaudeAI {
    name: 'The Godfather Union Agreements',
    negotiated: date('1970-12-15'),
    effective: date('1971-03-01'),
    expiration: date('1971-12-31'),
    signatory_unions: 6,
    total_union_members: 168,
    grievances_filed: 3,
    grievances_resolved: 3,
    work_stoppages: 0,
    contract_variations: 12,
    payroll_service: 'Cast & Crew',
    compliance_audit: date('1972-02-15'),
    pension_contributions: 187500,
    health_contributions: 224000
})
WITH 1 as dummy
MATCH (l:LaborAgreement:GeneratedByClaudeAI {name: 'The Godfather Union Agreements'})
SET l.union_agreements = ['Directors Guild of America', 'Screen Actors Guild', 'Writers Guild of America', 'IATSE', 'Teamsters', 'Musicians Union']
SET l.agreement_variations = ['Extended hours', 'Location premiums', 'International provisions', 'Period costume allowances']
SET l.payroll_categories = ['Cast', 'Director/Producers', 'Below-the-line', 'Writers', 'Musicians']
SET l.payroll_totals = [1850000, 450000, 2200000, 250000, 85000]
SET l.overtime_hours = 2450
SET l.meal_penalties = 185;

MATCH
  (l:LaborAgreement:GeneratedByClaudeAI {name: 'The Godfather Union Agreements'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (l)-[:LABOR_FRAMEWORK_FOR {
    signatory_production_company: 'Alfran Productions',
    guarantor: 'Paramount Pictures',
    labor_relations_director: 'Michael Eisner, Paramount VP',
    union_business_representatives: ['DGA: Joe Riley', 'SAG: Chester Davis', 'IATSE: Thomas Short'],
    special_conditions_negotiated: ['Extended shooting days in New York', 'Italian location provisions', 'Second unit arrangements'],
    work_rules_modifications: 'Turnaround adjustments for night shooting',
    international_travel_accommodations: 'Business class for key personnel',
    per_diem_rates: 'Standard plus location adjustments',
    pension_and_health_calculations: 'Standard guild formulas',
    working_condition_provisions: 'Era-appropriate with safety considerations',
    grievance_procedure: 'Standard with production-specific representatives',
    jurisdictional_agreements: 'Clear delineation between crafts',
    credit_requirements: 'Guild standard with negotiated exceptions',
    residual_structure: 'Standard with perpetuity provisions',
    foreign_levies: 'Standard collection agreements',
    payroll_processing: 'Weekly with daily tracking',
    compliance_documentation: 'Comprehensive with studio oversight',
    labor_peace_commitment: 'No work stoppage guarantee with arbitration'
}]->(g);

// Add the merchandising and licensing program
CREATE (GodfatherMerchandising:LicensingProgram:GeneratedByClaudeAI {
    name: 'The Godfather Merchandising & Licensing Program',
    established: date('1971-10-15'),
    activated: date('1972-02-10'),
    product_categories: 6,
    licensees: 12,
    territories: 35,
    license_term: duration({years: 3}),
    renewal_options: 2,
    minimum_guarantees: 250000,
    royalty_rates: '8-12%',
    approval_process: 'Multi-stage with studio sign-off',
    quality_control: 'Strict with product samples',
    marketing_support: 'Coordinated with film release',
    program_manager: 'Paramount Consumer Products'
})
WITH 1 as dummy
MATCH (l:LicensingProgram:GeneratedByClaudeAI {name: 'The Godfather Merchandising & Licensing Program'})
SET l.product_lines = ['Publishing', 'Soundtrack', 'Apparel', 'Posters', 'Collectibles', 'Board game']
SET l.licensee_advances = [75000, 50000, 40000, 35000, 30000, 20000]
SET l.top_markets = ['United States', 'Canada', 'United Kingdom', 'Japan', 'Germany', 'France', 'Italy']
SET l.market_revenues = [650000, 125000, 110000, 95000, 85000, 80000, 75000]
SET l.design_guidelines = 'Comprehensive 45-page style guide'
SET l.logo_treatments = 5;

MATCH
  (l:LicensingProgram:GeneratedByClaudeAI {name: 'The Godfather Merchandising & Licensing Program'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (l)-[:MERCHANDISE_RIGHTS_FOR {
    licensing_director: 'Howard Leeds, Paramount Consumer Products',
    program_approach: 'Tasteful adult-oriented products emphasizing prestige',
    key_licensed_categories: ['Book tie-ins', 'Soundtrack', 'Film stills', 'Limited collectibles'],
    prohibited_categories: ['Toys', 'Children\'s products', 'Weapons replicas', 'Controversial items'],
    approval_chain: 'Product concept → design → pre-production sample → final product',
    rights_restrictions: 'No character merchandising without specific approval',
    intellectual_property_elements: ['Film logo', 'Key art', 'Selected film stills', 'Limited quotes'],
    royalty_collection: 'Quarterly with annual audits',
    minimum_guarantees_structure: 'Recoupable against royalties',
    quality_control_process: 'Physical samples reviewed by studio',
    contract_term: '3 years with performance-based renewal options',
    top_performing_licensee: 'Fawcett Books - novel tie-in',
    international_adaptation: 'Limited with cultural sensitivity review',
    marketing_coordination: 'Joint promotional activities around film release',
    retail_distribution_channels: 'Bookstores, record stores, specialty retailers',
    program_evolution: 'Expanded significantly with sequels',
    second_phase_activation: 'Reactivated for home video release',
    legacy_program_development: 'Continued as classic film property'
}]->(g);

// Add product placement deals
CREATE (GodfatherProductPlacements:CommercialDeal:GeneratedByClaudeAI {
    name: 'The Godfather Product Integrations',
    negotiated: date('1971-01-15'),
    executed: date('1971-03-01'),
    brands_featured: 5,
    cash_compensation: 25000,
    in_kind_value: 75000,
    screen_time_total: duration({minutes: 3, seconds: 45}),
    negotiation_rounds: 8,
    contract_pages: 65,
    legal_review_hours: 35,
    authenticity_restrictions: 'Period appropriate only',
    anachronism_avoidance: 'Strict historical review',
    director_approvals: 'Required for all placements'
})
WITH 1 as dummy
MATCH (c:CommercialDeal:GeneratedByClaudeAI {name: 'The Godfather Product Integrations'})
SET c.product_categories = ['Automobiles', 'Beverages', 'Clothing', 'Food', 'Tobacco']
SET c.brand_names = ['Lincoln Continental', 'Jack Daniel\'s', 'Florsheim', 'Genco Olive Oil (fictional)', 'Camel']
SET c.compensation_types = ['Vehicle provision', 'Cash payment', 'Wardrobe provision', 'Product supply', 'Historical props']
SET c.compensation_values = [60000, 15000, 10000, 5000, 10000]
SET c.screen_placements = [4, 2, 6, 3, 5]
SET c.placement_seconds = [65, 35, 60, 45, 55];

MATCH
  (c:CommercialDeal:GeneratedByClaudeAI {name: 'The Godfather Product Integrations'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (c)-[:BRAND_INTEGRATION_FOR {
    integration_director: 'Fred Gallo, Production Manager',
    period_authenticity_requirement: 'Strict 1945-1955 appropriate products only',
    placement_philosophy: 'Subtle integration serving narrative',
    negotiation_priority: 'Authenticity over compensation',
    historical_consistency_review: 'Thorough with production design department',
    legal_clearance_process: 'Full trademark clearances for visible brands',
    automobile_supplier_agreement: 'Period vehicles provided with technical support',
    beverage_integration_parameters: 'Background presence only with authentic packaging',
    clothing_supplier_arrangement: 'Historical accurate wardrobe supplementation',
    additional_consideration: 'Technical advisors for period authenticity',
    brand_approval_restrictions: 'No contemporary marketing allowed during release',
    contemporaneous_promotion_prohibition: 'No tie-in advertising permitted',
    screen_credit_provisions: 'Thank you credits only, no logos',
    integration_subtlety_requirement: 'No focal attention to commercial products',
    product_supply_logistics: 'Delivery to set with historical documentation',
    future_rights_limitations: 'No merchandising or promotional usage',
    deal_structure_innovation: 'Focused on production value enhancement not promotion'
}]->(g);

// Add post-production facilities
CREATE (GodfatherPostProduction:PostProductionFacility:GeneratedByClaudeAI {
    name: 'The Godfather Post-Production Services',
    engaged: date('1971-08-10'),
    completed: date('1972-02-15'),
    facility_locations: 3,
    editing_suites: 5,
    sound_stages: 2,
    mixing_rooms: 3,
    screening_rooms: 4,
    technical_staff: 45,
    creative_staff: 15,
    equipment_value: 4500000,
    dailies_processed: 875000,
    dailies_unit: 'feet',
    final_runtime: duration({hours: 2, minutes: 55})
})
WITH 1 as dummy
MATCH (p:PostProductionFacility:GeneratedByClaudeAI {name: 'The Godfather Post-Production Services'})
SET p.service_categories = ['Film editing', 'Sound design', 'Music recording', 'Color timing', 'Optical effects', 'Film processing']
SET p.facility_names = ['Paramount Editorial', 'Todd-AO Sound', 'Paramount Scoring Stage', 'Technicolor', 'Cinema Research', 'Consolidated Film Industries']
SET p.service_durations = [24, 16, 6, 8, 5, 22]
SET p.service_durations_unit = 'weeks'
SET p.technical_systems = ['Moviola editing', 'Mag film sound', '35mm projection', 'Optical printer']
SET p.deliverable_formats = ['35mm theatrical prints', 'Magnetic soundtrack masters', 'Optical soundtrack negatives'];

MATCH
  (p:PostProductionFacility:GeneratedByClaudeAI {name: 'The Godfather Post-Production Services'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (p)-[:POST_PRODUCED {
    post_supervisor: 'Peter Zinner',
    editorial_process: 'Traditional film cutting on Moviolas',
    primary_editing_location: 'Paramount Pictures Editorial Department',
    editor_collaboration_approach: 'Co-editors with sequence responsibilities',
    workprint_creation: 'Dailies synced and assembled next day',
    screening_schedule: 'Weekly with director and producers',
    sound_design_facility: 'Todd-AO Studios',
    foley_recording: 'Custom effects for gun shots and period authenticity',
    sound_mixing_approach: '6-track mix down to mono theatrical',
    music_recording_studio: 'Paramount Scoring Stage',
    orchestra_size: 65,
    color_timing_supervision: 'Gordon Willis personally supervised at Technicolor',
    lab_processing: 'Consolidated Film Industries with special instructions',
    optical_effects_house: 'Cinema Research for titles and opticals',
    title_design_process: 'Multiple concepts presented with puppet strings winning',
    dailies_processing: 'Overnight with morning screening',
    edit_decision_workflow: 'Director/Editor collaborative with producer input',
    technical_challenges: 'Low light cinematography requiring special processing',
    post_schedule_adherence: 'On schedule with planned extensions',
    delivery_requirements: '600 release prints with precise quality control'
}]->(g);

// Add film laboratory services
CREATE (TechnicolorLab:FilmLaboratory:GeneratedByClaudeAI {
    name: 'Technicolor Film Laboratory - Hollywood',
    established: date('1915-11-19'),
    project_engaged: date('1971-03-29'),
    project_completed: date('1972-03-10'),
    facility_size: 120000,
    facility_size_unit: 'square feet',
    employees: 450,
    processing_capacity: 1000000,
    capacity_unit: 'feet per day',
    film_formats: '35mm, 65mm, 16mm',
    processing_systems: 'Proprietary Technicolor, Standard ECN',
    quality_control_points: 24,
    technical_certifications: 8,
    industry_leadership: 'Color processing innovation'
})
WITH 1 as dummy
MATCH (f:FilmLaboratory:GeneratedByClaudeAI {name: 'Technicolor Film Laboratory - Hollywood'})
SET f.services_provided = ['Negative processing', 'Daily prints', 'Optical printing', 'Color timing', 'Release printing', 'Preservation elements']
SET f.equipment_types = ['Processing machines', 'Printing machines', 'Sensitometry equipment', 'Color analyzers', 'Densitometers']
SET f.equipment_counts = [24, 36, 12, 18, 15]
SET f.chemical_systems = ['ECN-1 negative process', 'ECP-1 print process', 'Silver recovery systems']
SET f.processing_standards = ['ASA standards', 'Technicolor proprietary', 'SMPTE specifications']
SET f.client_list = ['Paramount', 'Warner Bros.', 'Universal', 'Independent productions'];

MATCH
  (f:FilmLaboratory:GeneratedByClaudeAI {name: 'Technicolor Film Laboratory - Hollywood'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (f)-[:LABORATORY_SERVICES_FOR {
    lab_contact: 'Richard Dayton, Technicolor Account Executive',
    services_contracted: ['Negative processing', 'Daily prints', 'Color timing', 'Answer prints', 'Release prints'],
    dailies_turnaround: '24-hour standard, rush available',
    negative_developing_process: 'ECN-1 with special instructions',
    special_processing_instructions: 'Underexposed negative compensation',
    color_timing_approach: 'Gordon Willis supervised personally',
    amber_tone_development: 'Custom filtration and timing for period look',
    print_specification: 'Release prints with amber bias',
    quality_control_process: 'Multiple checkpoints with cinematographer approval',
    print_runs: 'Answer print → color timing → check print → release prints',
    technical_challenges: 'Maintaining consistent dark exposure look',
    process_innovations: 'Special development times for low-light footage',
    release_print_order: 600,
    print_quality_control: 'Individual inspection of first 50 prints',
    archival_elements_created: 'Preservation YCM separations created',
    `lab-studio_relationship`: 'Long-standing Paramount account',
    processing_schedule: 'Dailies priority scheduling',
    confidentiality_protocols: 'Special security for high-profile production',
    technical_documentation: 'Comprehensive timing records preserved'
}]->(g);

// Add accounting and financial reporting services
CREATE (GodfatherAccounting:FinancialService:GeneratedByClaudeAI {
    name: 'The Godfather Production Accounting Services',
    engaged: date('1970-09-15'),
    completed: date('1972-12-31'),
    accounting_staff: 6,
    transactions_processed: 12500,
    invoices_processed: 4250,
    payroll_transactions: 6800,
    financial_reports: 85,
    audits_conducted: 3,
    tax_filings: 12,
    accounting_system: 'Studio production accounting system',
    chart_of_accounts: 'Standard film production CoA',
    fiscal_year: 'Calendar year',
    record_retention: '7 years physical, permanent digital'
})
WITH 1 as dummy
MATCH (f:FinancialService:GeneratedByClaudeAI {name: 'The Godfather Production Accounting Services'})
SET f.service_categories = ['Production accounting', 'Payroll services', 'Cash management', 'Tax compliance', 'Financial reporting', 'Audit support']
SET f.report_types = ['Daily cost reports', 'Weekly cost reports', 'Monthly summaries', 'Cost-to-complete', 'Variance analysis', 'Cash flow projections']
SET f.report_recipients = ['Production team', 'Studio executives', 'Completion guarantor', 'Paramount finance', 'Gulf+Western corporate']
SET f.compliance_frameworks = ['GAAP', 'Film industry practices', 'Studio requirements', 'Completion bond requirements']
SET f.software_systems = ['Studio proprietary systems', 'Cast & Crew payroll', 'Manual ledgers']
SET f.banking_relationships = ['Bank of America', 'Chemical Bank'];

MATCH
  (f:FinancialService:GeneratedByClaudeAI {name: 'The Godfather Production Accounting Services'}),
  (g:Movie:GeneratedByClaudeAI {title: 'The Godfather'})
CREATE (f)-[:FINANCIAL_SERVICES_FOR {
    production_accountant: 'Joseph Scotti, CPA',
    accounting_team_structure: 'Controller, payroll supervisor, AP specialist, production accountants (3)',
    accounting_system_implementation: 'Paramount standard production accounting system',
    chart_of_accounts_customization: 'Standard film production with project-specific cost centers',
    daily_cost_reporting: 'Detailed actuals vs. budget by department',
    weekly_financial_meetings: 'Production team with studio representatives',
    monthly_financial_review: 'Studio executives and production leadership',
    cash_flow_management: 'Weekly disbursements against approved expenses',
    banking_structure: 'Production accounts with controlled disbursement',
    petty_cash_controls: 'Daily reconciliation with receipts',
    purchase_order_system: 'Standard with approval hierarchies',
    vendor_payment_terms: 'Net 30 standard with exceptions',
    payroll_processing: 'Weekly for crew, by production block for cast',
    tax_withholding_management: 'Multi-state and international considerations',
    completion_bond_reporting: 'Weekly cost reports and variance analysis',
    audit_trails_maintenance: 'Complete documentation for all transactions',
    financial_controls_implementation: 'Segregation of duties and approval levels',
    cost_containment_measures: 'Exception reporting and approval escalation',
    final_cost_reporting: 'Comprehensive cost analysis by category',
    profit_participation_accounting: 'Foundation for subsequent statement preparation'
}]->(g);
