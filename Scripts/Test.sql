SELECT
	CASE 
		WHEN LENGTH(s_ustid_ustid__051_) > 19 OR (genius_s_ustid_ustid__051_.STATUS IS NOT NULL AND genius_s_ustid_ustid__051__.STATUS != 'ok' THEN 'check'
	ELSE 'ok'
	END AS STATUS
	,LTRIM(CASE
		WHEN LENGTH(s_ustid_ustid__051_) > 19
		THEN CHAR(10) || 'S_UStID.UStID (051) exceeds field length (max 19 digits)'
		ELSE ''
	END ||
	CASE
		WHEN (genius_s_ustid_ustid__051_.STATUS IS NOT NULL AND genius_s_ustid_ustid__051__.STATUS != 'ok'
		THEN CHAR(10) || 'S_UStID.UStID (051) is not a valid VAT ID'
		ELSE ''
	END,CHAR(10)) AS DEFICIENCY_MININNG_MESSAGE
	,s_ustid_ustid__051_ AS "S_UStID.UStID (051)",
	s_kunde_kunde__001_ AS "S_Kunde.Kunde (001)",
	s_adresse_adressnr__002_ AS "S_Adresse.AdressNr (002)",
	s_adresse_name1__003_ AS "S_Adresse.Name1 (003)",
	s_adresse_staat__004_ AS "S_Adresse.Staat (004)",
	s_adresse_ort__005_ AS "S_Adresse.Ort (005)",
	s_adresse_suchbegriff__006_ AS "S_Adresse.Suchbegriff (006)",
	s_adresse_selektion__007_ AS "S_Adresse.Selektion (007)",
	s_adresse_name2__012_ AS "S_Adresse.Name2 (012)",
	s_adresse_name3__013_ AS "S_Adresse.Name3 (013)",
	s_adresse_plz__014_ AS "S_Adresse.PLZ (014)",
	s_adresse_strasse__018_ AS "S_Adresse.Strasse (018)",
	s_adresse_hausnummer__020_ AS "S_Adresse.Hausnummer (020)",
	s_adresse_bundesland__021_ AS "S_Adresse.Bundesland (021)",
	s_adresse_plz_postfach__022_ AS "S_Adresse.PLZ_Postfach (022)",
	s_adresse_postfach__023_ AS "S_Adresse.Postfach (023)",
	s_adresse_telefonbuch__024_ AS "S_Adresse.Telefonbuch (024)",
	s_adresse_email__025_ AS "S_Adresse.EMail (025)",
	s_adresse_homepage__026_ AS "S_Adresse.HomePage (026)",
	s_adresse_handy__027_ AS "S_Adresse.Handy (027)",
	s_adresse_telefon__028_ AS "S_Adresse.Telefon (028)",
	s_adresse_telefax__030_ AS "S_Adresse.Telefax (030)",
	s_kunde_suchbegriff__035_ AS "S_Kunde.Suchbegriff (035)",
	s_kunde_selektion__036_ AS "S_Kunde.Selektion (036)",
	s_kunde_sachbearbeiter__040_ AS "S_Kunde.Sachbearbeiter (040)",
	s_kunde_sprache__041_ AS "S_Kunde.Sprache (041)",
	s_kunde_abc_klasse__042_ AS "S_Kunde.Abc_klasse (042)",
	s_kunde_artikelstatistik__043_ AS "S_Kunde.Artikelstatistik (043)",
	s_kunde_webshop__044_ AS "S_Kunde.Webshop (044)",
	s_kunde_lieferantennummer__048_ AS "S_Kunde.lieferantennummer (048)",
	s_kunde_inlaendische_steuernr__049_ AS "S_Kunde.inlaendische_steuernr (049)",
	s_kunde_rechnungsintervall__052_ AS "S_Kunde.rechnungsintervall (052)",
	s_kunde_rechnungskennzeichen__053_ AS "S_Kunde.rechnungskennzeichen (053)",
	s_kunde_rechnung_an__054_ AS "S_Kunde.rechnung_an (054)",
	s_kunde_konzern__055_ AS "S_Kunde.konzern (055)",
	s_verband_mahnempfaenger__059_ AS "S_Verband.Mahnempfaenger (059)",
	s_verband_zahlungsregulierung__060_ AS "S_Verband.Zahlungsregulierung (060)",
	s_kunde_mahnempfaenger_verband__062_ AS "S_Kunde.mahnempfaenger_verband (062)",
	s_kunde_stgr_mit_st__064_ AS "S_Kunde.stgr_mit_st (064)",
	s_kunde_stgr_ohne_st__065_ AS "S_Kunde.stgr_ohne_st (065)",
	s_kunde_stgreu_mit_st__066_ AS "S_Kunde.stgreu_mit_st (066)",
	s_kunde_stgreu_ohne_st__067_ AS "S_Kunde.stgreu_ohne_st (067)",
	s_kunde_stgraus_mit_st__068_ AS "S_Kunde.stgraus_mit_st (068)",
	s_kunde_stgraus_ohne_st__069_ AS "S_Kunde.stgraus_ohne_st (069)",
	s_kunde_kreditlimit_ueberwachen__074_ AS "S_Kunde.kreditlimit_ueberwachen (074)",
	s_kunde_mahnverfahren__075_ AS "S_Kunde.mahnverfahren (075)",
	f_kundeverzug_manuell__078_ AS "F_KundeVerzug.manuell (078)",
	s_kunde_rabattart__089_ AS "S_Kunde.rabattart (089)",
	s_kunde_fracht_skontofaehig__090_ AS "S_Kunde.fracht_skontofaehig (090)",
	s_kunde_zuschlag_skontofaehig__091_ AS "S_Kunde.zuschlag_skontofaehig (091)",
	s_ustid_bestaetigt__094_ AS "S_UStID.bestaetigt (094)",
	s_ustid_isdefault__096_ AS "S_UStID.IsDefault (096)"
FROM
	mig.
LEFT JOIN
	MIG.SHARED_NAIGENT genius_s_adresse_homepage__026_
ON  
	    genius_s_adresse_homepage__026_.CLASSIFICATION = 'URL'
	AND genius_s_adresse_homepage__026_.VALUE          = s_adresse_homepage__026_
LEFT JOIN
	MIG.SHARED_NAIGENT genius_s_ustid_ustid__051_
ON  
	    genius_s_ustid_ustid__051_.CLASSIFICATION = 'VAT_ID'
	AND genius_s_ustid_ustid__051_.VALUE          = s_ustid_ustid__051_
