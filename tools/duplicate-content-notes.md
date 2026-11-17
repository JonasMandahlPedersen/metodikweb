# Duplikeret indhold — analyse (ingen sider omskrevet)

To par af sider er bygget som næsten identiske skabeloner, hvor kun målgruppeordene er skiftet ud (kommune/borger/forvaltning ↔ virksomhed/kunde/afdeling). Det er en risiko for duplicate-content i Googles øjne og en svaghed i AI-søgning, fordi der ikke er noget der gør hver side uundværlig for sin egen målgruppe.

## Par 1: kommuner.html ↔ virksomheder.html

**Hvor meget overlapper:**
- Hero-struktur, "Udfordringen"-sektion, Rapport-sektion (alle 6 kort), Proces-sektion (alle 4 trin), Undervisning-sektion (alle 4 kursusbeskrivelser), FAQ (alle 5 spørgsmål) og CTA-sektion er strukturelt 1:1 ens — kun substantiver er byttet ud (borgere→kunder, forvaltning→virksomhed, udvalg→ledelse).
- "Hvorfor Metodik"-sektionen er ordret identisk bortset fra ét ord ("borgerne"/"kunderne").

**Konkrete forslag til at gøre hver side unik:**
1. **Udfordringen-sektionen**: Kommunesiden nævner i dag generiske ting som "Digital Post" blev allerede fjernet, men listen kunne gøres mere specifik med reelle kommunale smertepunkter: sagsbehandlingstid på konkrete lovpligtige sagsområder (byggesager, borgerservice-ventetider, jobcenter-opfølgning), politisk/udvalgsstyring af prioriteringer, indkøbsregler (udbudspligt). Virksomhedssiden kunne i stedet fokusere på kundetabsrisiko, konkurrence fra digitalt modne konkurrenter, og medarbejderomsætning i kundeservice.
2. **Rapport-kortene**: Begge sider har identiske 6 kort. Kommunesidens "Risiko, jura og informationssikkerhed"-kort kunne specifikt nævne forvaltningsloven, offentlighedsloven og databeskyttelsesrådgiverens rolle — virksomhedssiden kunne i stedet fokusere på kundedata, markedsføringsloven og databehandleraftaler med kommercielle SaaS-leverandører.
3. **Eksempler-sektionen**: Begge bruger samme 6 eksempler (sortering af post, svarudkast osv.) med kun ord byttet ud. Kommunesiden kunne bruge virkelige kommunale use-cases (byggesagsbehandling, pladsanvisning, affaldssortering-henvendelser), virksomhedssiden kunne bruge B2B/B2C-specifikke cases (ordrestatus, reklamationer, leveringsforsinkelser).
4. **Terminologi gennemgående**: Kommunesiden kunne konsekvent bruge "forvaltning", "sagsbehandler", "borgerrettet" — virksomhedssiden "afdeling", "medarbejder", "kunderettet". Lige nu er sprogbrugen næsten mekanisk byttet 1:1, hvilket gør siderne lette at identificere som skabeloner.
5. **FAQ**: Tilføj mindst ét spørgsmål der kun giver mening for hver målgruppe — fx for kommuner: "Kan rapporten bruges i et udbud?" eller "Hvordan forholder analysen sig til forvaltningsloven?". For virksomheder: "Kan rapporten bruges til at argumentere over for bestyrelsen?" eller "Dækker analysen flere afdelinger eller kun én?".
6. **Proces-sektionen**: Kommunesidens trin kunne nævne involvering af direktion/udvalg eksplicit som et trin, virksomhedssidens trin kunne nævne ledelsesgruppe/bestyrelse.

## Par 2: teknologi-loefter-borgeroplevelsen-i-kommunen.html ↔ teknologi-loefter-kundeoplevelsen-i-virksomheden.html

**Hvor meget overlapper:**
- Næsten hele artikelstrukturen er identisk: samme 5 overskrifter i samme rækkefølge ("Presset er reelt", "Den klassiske fejl", "Fire steder teknologi gør en forskel", "Hvorfor rapport frem for indkøb", "Resultatet"), samme eksempel-boks-pointe ("chatbot blev valgt før problemet var kortlagt"), samme decision-box med identiske 6 spørgsmål.
- De fire konkrete eksempler i "Fire steder teknologi gør en forskel" er indholdsmæssigt identiske (sortering, svarudkast, selvbetjening, sagsopsummering) — kun "borger/kommune" er byttet til "kunde/virksomhed".

**Konkrete forslag til at gøre hver artikel unik:**
1. **Konkrete eksempler i stedet for generiske**: Kommune-artiklen kunne bruge et konkret, navngivet (men ikke-identificerbart) sagsområde som eksempel — fx byggesagsbehandling eller pladsanvisning — i stedet for den generiske "AI-chatbot"-historie. Virksomheds-artiklen kunne bruge et konkret B2B/B2C-scenarie som ordrehåndtering eller reklamationssager.
2. **"Den klassiske fejl"-eksempel**: Begge bruger ordret samme opbygning ("En [afdeling/virksomhed] investerer i en AI-chatbot... Seks måneder efter..."). Differentiér med forskellige teknologivalg: kommunen kunne have købt et sagsstyringssystem, virksomheden et CRM-tillæg — med forskellige konsekvenser.
3. **Juridisk/regulatorisk vinkel**: Kommune-artiklen kunne gå dybere i forvaltningsretlige krav (aktindsigt, journaliseringspligt) i decision-boxen. Virksomheds-artiklen kunne i stedet fokusere på kundedata/GDPR fra et kommercielt perspektiv og evt. branchespecifikke krav.
4. **Afsnittet "Presset er reelt"**: Kommune-artiklen nævner allerede konkrete afdelinger (jobcenter, teknik og miljø) — godt. Virksomheds-artiklen kunne tilsvarende blive mere konkret om branche (fx detailhandel, B2B-service) i stedet for generisk "salg, support, administration".
5. **Forskellig case-reference**: Lad kommune-artiklen linke videre til et konkret element fra kommuner.html (fx et af de 6 rapport-punkter), og virksomheds-artiklen til et andet, fremfor at begge pege generisk på "#rapport".

## Opsummering
Begge par er funktionelt fint som landingpages/artikler hver for sig, men den mekaniske ord-for-ord-oversættelse gør dem sårbare for at blive opfattet som duplicate content af søgemaskiner og som mindre troværdige af AI-søgeværktøjer, der typisk foretrækker kilder med specifik, ikke-generisk substans. Den hurtigste forbedring med mindst indsats er nok punkt 3 i par 1 (konkrete use-cases) og punkt 1 i par 2 (konkrete eksempler) — det er der den generiske "skabelon-følelse" er tydeligst.
