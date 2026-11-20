// Alle events van één eigenaar (mode, module of service).
// De groep bevat de FB_Event-instanties, vult hun config in en geeft de logger door.
// De eigenaar krijgt de groep via FB_Init en spreekt de events aan via zijn eigen enum:
//   _fbEvents.Condition(iEvent := E_AirPressureEvent.PressureNok, xCondition := NOT _fbHw.AirPressureOk);
// De EventService registreert groepen, geen losse events.
INTERFACE I_EventGroup
