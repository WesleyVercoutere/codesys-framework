// Bestemming voor logregels: txt-bestand, array van strings, Hyperion, ...
// Een logger is een buffer: loggen kost bijna niets in de cyclus van de aanroeper,
// het wegschrijven naar de echte bestemming gebeurt asynchroon in de logger.
// Tijdstempel en teller voegt de logger zelf toe.
INTERFACE I_Logger
