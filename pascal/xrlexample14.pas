program xraylibtest;
{$linklib libxrl}
uses xraylib;
var
	Energy : Double;
	cdtest : PcompoundData;
	mystring : string;
	i : longint;

begin

	SetErrorMessages(0);

        writeln('Example of Pascal program using xraylib');
  	writeln('Density of pure Al: ', ElementDensity(13),' g/cm3');
  	writeln('Ca K-alpha Fluorescence Line Energy: ', LineEnergy(20,KA_LINE));
	writeln('Fe partial photoionization cs of L3 at 6.0 keV: ',CS_Photo_Partial(26,L3_SHELL,6.0));
	writeln('Zr L1 edge energy: ',EdgeEnergy(40,L1_SHELL));
	writeln('Pb Lalpha XRF production cs at 20.0 keV (jump approx): ',CS_FluorLine(82,LA_LINE,20.0));
	writeln('Pb Lalpha XRF production cs at 20.0 keV (Kissel): ',CS_FluorLine_Kissel(82,LA_LINE,20.0));
	writeln('Bi M1N2 radiative rate: ',RadRate(83,M1N2_LINE));
	writeln('U M3O3 Fluorescence Line Energy: ',LineEnergy(92,M3O3_LINE));
	{parser test for Ca(HCO3)2 (calcium bicarbonate)}
	cdtest := CompoundParser('Ca(HCO3)2');
	if (cdtest = nil) then
	begin
		Halt(1)
	end;
  	writeln('Ca(HCO3)2 contains ',cdtest^.nAtomsAll, ' atoms and ', cdtest^.nElements,' elements');
	for  i := 0 to cdtest^.nElements-1 do
	begin
		writeln('Element ', cdtest^.Elements[i], ' : ', cdtest^.massFractions[i]*100.0, ' %');
	end;
	Dispose(cdtest);


	{parser test for SiO2 (quartz)}
	cdtest := CompoundParser('SiO2');
	if (cdtest = nil) then
	begin
		Halt(1)
	end;
  	writeln('SiO2 contains ',cdtest^.nAtomsAll, ' atoms and ', cdtest^.nElements,' elements');
	for  i := 0 to cdtest^.nElements-1 do
	begin
		writeln('Element ', cdtest^.Elements[i], ' : ', cdtest^.massFractions[i]*100.0, ' %');
	end;
	Dispose(cdtest);
	writeln('Ca(HCO3)2 Rayleigh cs at 10.0 keV: ',CS_Rayl_CP('Ca(HCO3)2',10.0));

	writeln('CS2 Refractive Index at 10.0 keV : ',Refractive_Index_Re('CS2',10.0,1.261),' - ',Refractive_Index_Im('CS2', 10.0, 1.261), ' i');
	writeln('C16H14O3 Refractive Index at 1 keV : ',Refractive_Index_Re('C16H14O3', 1.0, 1.2),' - ',Refractive_Index_Im('C16H14O3', 1.0, 1.2),' i');
	writeln('SiO2 Refractive Index at 5 keV : ',Refractive_Index_Re('SiO2', 5.0, 2.65),' - ',Refractive_Index_Im('SiO2',5.0, 2.65),' i');

	writeln('Compton profile for Fe at pz = 1.1 : ',ComptonProfile(26,1.1));
	writeln('M5 Compton profile for Fe at pz = 1.1 : ',ComptonProfile_Partial(26,M5_SHELL,1.1));
	writeln('M1->M5 Coster-Kronig transition probability for Au : ',CosKronTransProb(79,FM15_TRANS));
	writeln('L1->L3 Coster-Kronig transition probability for Fe : ',CosKronTransProb(26,FL13_TRANS));
	writeln('Au Ma1 XRF production cs at 10.0 keV (Kissel): ', CS_FluorLine_Kissel(79,MA1_LINE,10.0));
	writeln('Au Mb XRF production cs at 10.0 keV (Kissel): ', CS_FluorLine_Kissel(79,MB_LINE,10.0));
	writeln('Au Mg XRF production cs at 10.0 keV (Kissel): ', CS_FluorLine_Kissel(79,MG_LINE,10.0));

	writeln('K atomic level width for Fe: ', AtomicLevelWidth(26,K_SHELL));
	writeln('Bi L2-M5M5 Auger non-radiative rate: ',AugerRate(86,L2_M5M5_AUGER));
	writeln('Bi L3 Auger yield: ', AugerYield(86, L3_SHELL));
	writeln('Symbol of element 26 is: ',AtomicNumberToSymbol(26));
	writeln('Number of element Fe is: ',SymbolToAtomicNumber('Fe'));

	writeln('Pb Malpha XRF production cs at 20.0 keV with cascade effect: ',CS_FluorLine_Kissel(82,MA1_LINE,20.0));
	writeln('Pb Malpha XRF production cs at 20.0 keV with radiative cascade effect: ',CS_FluorLine_Kissel_Radiative_Cascade(82,MA1_LINE,20.0));
	writeln('Pb Malpha XRF production cs at 20.0 keV with non-radiative cascade effect: ',CS_FluorLine_Kissel_Nonradiative_Cascade(82,MA1_LINE,20.0));
	writeln('Pb Malpha XRF production cs at 20.0 keV without cascade effect: ',CS_FluorLine_Kissel_no_Cascade(82,MA1_LINE,20.0));


	writeln('Al mass energy-absorption cs at 20.0 keV: ', CS_Energy(13, 20.0));
	writeln('Pb mass energy-absorption cs at 40.0 keV: ', CS_Energy(82, 40.0));
	mystring := 'CdTe';
	writeln('CdTe mass energy-absorption cs at 40.0 keV: ', CS_Energy_CP(mystring, 40.0));
end.
