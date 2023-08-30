function mpc = case39
%CASE39 Power flow data for 39 bus New England system.
%   Please see CASEFORMAT for details on the case file format.
%
%   Data taken from [1] with the following modifications/additions:
%
%       - renumbered gen buses consecutively (as in [2] and [4])
%       - added Pmin = 0 for all gens
%       - added Qmin, Qmax for gens at 31 & 39 (copied from gen at 35)
%       - added Vg based on V in bus data (missing for bus 39)
%       - added Vg, Pg, Pd, Qd at bus 39 from [2] (same in [4])
%       - added Pmax at bus 39: Pmax = Pg + 100
%       - added line flow limits and area data from [4]
%       - added voltage limits, Vmax = 1.06, Vmin = 0.94
%       - added identical quadratic generator costs
%       - increased Pmax for gen at bus 34 from 308 to 508
%         (assumed typo in [1], makes initial solved case feasible)
%       - re-solved power flow
% 
%   Notes:
%       - Bus 39, its generator and 2 connecting lines were added
%         (by authors of [1]) to represent the interconnection with
%         the rest of the eastern interconnect, and did not include
%         Vg, Pg, Qg, Pd, Qd, Pmin, Pmax, Qmin or Qmax.
%       - As the swing bus, bus 31 did not include and Q limits.
%       - The voltages, etc in [1] appear to be quite close to the
%         power flow solution of the case before adding bus 39 with
%         it's generator and connecting branches, though the solution
%         is not exact.
%       - Explicit voltage setpoints for gen buses are not given, so
%         they are taken from the bus data, however this results in two
%         binding Q limits at buses 34 & 37, so the corresponding
%         voltages have probably deviated from their original setpoints.
%       - The generator locations and types are as follows:
%           1   30      hydro
%           2   31      nuke01
%           3   32      nuke02
%           4   33      fossil02
%           5   34      fossil01
%           6   35      nuke03
%           7   36      fossil04
%           8   37      nuke04
%           9   38      nuke05
%           10  39      interconnection to rest of US/Canada
%
%   This is a solved power flow case, but it includes the following
%   violations:
%       - Pmax violated at bus 31: Pg = 677.87, Pmax = 646
%       - Qmin violated at bus 37: Qg = -1.37,  Qmin = 0
%
%   References:
%   [1] G. W. Bills, et.al., "On-Line Stability Analysis Study"
%       RP90-1 Report for the Edison Electric Institute, October 12, 1970,
%       pp. 1-20 - 1-35.
%       prepared by E. M. Gulachenski - New England Electric System
%                   J. M. Undrill     - General Electric Co.
%       "generally representative of the New England 345 KV system, but is
%        not an exact or complete model of any past, present or projected
%        configuration of the actual New England 345 KV system.
%   [2] M. A. Pai, Energy Function Analysis for Power System Stability,
%       Kluwer Academic Publishers, Boston, 1989.
%       (references [3] as source of data)
%   [3] Athay, T.; Podmore, R.; Virmani, S., "A Practical Method for the
%       Direct Analysis of Transient Stability," IEEE Transactions on Power
%       Apparatus and Systems , vol.PAS-98, no.2, pp.573-584, March 1979.
%       URL: https://doi.org/10.1109/TPAS.1979.319407
%       (references [1] as source of data)
%   [4] Data included with TC Calculator at http://www.pserc.cornell.edu/tcc/
%       for 39-bus system.

%   MATPOWER

%% MATPOWER Case Format : Version 2


%%%%%%%%%%%%%%%-------------------------------------------- Updates / Modifications performed by Pedro Barbeiro(INESC TEC)- pnpb@inesctec.pt---------------------------------------------------------------------%%%%%%%%%%%%%%%
%Main Modifications Introduced to the Orginal Grid (data presented above):
% - All units are thermal /fossil 
%- Orignal units of buses 34 (Unit Nr. 5), 37 (Unit Nr.8) and 38 (Unit Nr.9) have been decommissioned and replaced/upgraded to a Synchronous Condensers
% Wind Parks with same nominal power have been connected in buses 34 (800 MW), 37 (700 MW  and 38 (1000 MW) --> Total of 2500 MW
%%%%%%%%%%%%%%%--------------------------------------------------------------------------------------------------------------------------------------------------------%%%%%%%%%%%%%%%

mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
	1	1	0	0	0	0	2	1.039	-1.04	345	1	1.06	0.94;
	2	1	0	0	0	0	2	1.0298	2.86	345	1	1.06	0.94;
	3	1	176.3212	1.3142	0	0	2	1.0353	-0.63	345	1	1.06	0.94;
	4	1	273.7907	100.755	0	0	1	1.041	-3.75	345	1	1.06	0.94;
	5	1	0	0	0	0	1	1.0436	-4.07	345	1	1.06	0.94;
	6	1	0	0	0	0	1	1.04	-3.89	345	1	1.06	0.94;
	7	1	128.0245	45.9968	0	0	1	1.0364	-4.85	345	1	1.06	0.94;
	8	1	285.8375	96.3743	0	0	1	1.0365	-5.02	345	1	1.06	0.94;
	9	1	0	0	0	0	1	1.0449	-4.06	345	1	1.06	0.94;
	10	1	0	0	0	0	1	1.0397	-3.68	345	1	1.06	0.94;
	11	1	0	0	0	0	1	1.0395	-3.75	345	1	1.06	0.94;
	12	1	4.1069	48.1872	0	0	1	1.0355	-3.71	138	1	1.06	0.94;
	13	1	0	0	0	0	1	1.0397	-3.61	345	1	1.06	0.94;
	14	1	0	0	0	0	1	1.0406	-3.42	345	1	1.06	0.94;
	15	1	175.226	83.7799	0	0	3	1.0347	-2.42	345	1	1.06	0.94;
	16	1	180.3733	17.6869	0	0	3	1.0391	-1.13	345	1	1.06	0.94;
	17	1	0	0	0	0	2	1.0394	0.05	345	1	1.06	0.94;
	18	1	86.5178	16.4274	0	0	2	1.0376	-0.44	345	1	1.06	0.94;
	19	1	0	0	0	0	3	1.0532	5.63	345	1	1.06	0.94;
	20	1	343.8811	56.4009	0	0	3	0.9945	9.01	230	1	1.06	0.94;
	21	1	150.0373	62.9719	0	0	3	1.0347	-2.68	345	1	1.06	0.94;
	22	1	0	0	0	0	3	1.0365	-3.17	345	1	1.06	0.94;
	23	1	150.3111	46.3254	0	0	3	1.0356	-3.51	345	1	1.06	0.94;
	24	1	168.9836	-50.487	0	0	3	1.0417	-1.94	345	1	1.06	0.94;
	25	1	122.6582	25.8458	0	0	2	1.0595	6.12	345	1	1.06	0.94;
	26	1	76.1138	9.3089	0	0	2	1.0499	7.43	345	1	1.06	0.94;
	27	1	153.8704	41.3424	0	0	2	1.0404	3.42	345	1	1.06	0.94;
	28	1	112.8018	15.1133	0	0	3	1.047	15.61	345	1	1.06	0.94;
	29	1	155.2393	14.7299	0	0	3	1.0472	19.13	345	1	1.06	0.94;
	30	2	0	0	0	0	2	1.0047	2.86	22	1	1.06	0.94;
	31	3	5.0377	2.5189	0	0	1	0.982	0	22	1	1.06	0.94;
	32	2	0	0	0	0	1	0.9717	-3.68	22	1	1.06	0.94;
	33	2	0	0	0	0	3	0.997	7.65	22	1	1.06	0.94;
	34	2	0	0	0	0	3	0.9856	9.01	22	1	1.06	0.94;
	35	2	0	0	0	0	3	1.0113	-3.17	22	1	1.06	0.94;
	36	2	0	0	0	0	3	1.0356	-3.51	22	1	1.06	0.94;
	37	2	0	0	0	0	2	1.0337	6.12	22	1	1.06	0.94;
	38	2	0	0	0	0	3	1.0216	19.13	22	1	1.06	0.94;
	39	2	621.6598	136.8953	0	0	1	1.03	-3.35	345	1	1.06	0.94;
	40	2	0	0	0	0	3	1.012	16.91	22	1	1.06	0.94;
	41	2	0	0	0	0	3	1.028	14.58	22	1	1.06	0.94;
	42	2	0	0	0	0	3	1.027	27.34	22	1	1.06	0.94;
	
];


%PNPB - AInda nao entedi porque mas nao funcina - Testar sera por ter 2 maquinas no mesmo bus??
%% generator data
%	bus		Pg				Qg			Qmax		  Qmin		 Vg		mBase	  status	Pmax		   Pmin		Pc1	   Pc2		Qc1min	Qc1max	Qc2min	  Qc2max	 ramp_agc	r amp_10	ramp_30	 ramp_q		apf
mpc.gen = [
	30	0	0	538	-184.136	1.048	1000	0	843.9999	309	0	0	0	0	0	0	0	0	0	0	0;							%Thermal conventional Synchronous Generator (same data as in the original IEEE 39 Buses system)
	31	290.3409	-105.5776	377	-128.895	0.982	700	1	591	216	0	0	0	0	0	0	0	0	0	0	0;						%Thermal conventional Synchronous Generator (same data as in the original IEEE 39 Buses system) 
	32	0	0	431	-147.309	0.983	800	0	675	247	0	0	0	0	0	0	0	0	0	0	0;										%Thermal conventional Synchronous Generator (same data as in the original IEEE 39 Buses system)
	33	247	80.9621	431	-147.309	0.997	800	1	675	247	0	0	0	0	0	0	0	0	0	0	0;									%Thermal conventional Synchronous Generator (same data as in the original IEEE 39 Buses system)
	34	0	0	431	-147	1.012	800	0	675	247	0	0	0	0	0	0	0	0	0	0	0;											%Synchronous Condenser (Original sync. unit replaced/upgraded to a sync. condenser with same nominal power)
	35	0	0	431	-147.309	1.049	800	0	800	247	0	0	0	0	0	0	0	0	0	0	0;										%Thermal conventional Synchronous Generator (same data as in the original IEEE 39 Buses system)
	36	0	0	377	-128.895	1.064	700	0	675	216	0	0	0	0	0	0	0	0	0	0	0;										%Thermal conventional Synchronous Generator (same data as in the original IEEE 39 Buses system)
	37	0	0	377	-128.895	1.028	700	0	591	216	0	0	0	0	0	0	0	0	0	0	0;										%Synchronous Condenser (Original sync. unit replaced/upgraded to a sync. condenser with same nominal power) 
	38	0	0	538	-184.136	1.027	1000	0	591	309	0	0	0	0	0	0	0	0	0	0	0;									%Synchronous Condenser (Original sync. unit replaced/upgraded to a sync. condenser with same nominal power) 
	39	500	-56.6158	5382	-1841.36	1.03	10000	1	700	3088	0	0	0	0	0	0	0	0	0	0	0;					%Thermal conventional Synchronous Generator (same data as in the original IEEE 39 Buses system) 
	40	770.4957	162.5474	304.5194	-304.5194	1.012	800	1	843.9999	0	0	0	0	0	0	0	0	0	0	0	0;		%Wind farm of 800 MW (One new Wind power plant added with the same nominal power of the sync. machine presented in the orginal IEEE 39 Buses system network)
	41	674.1837	7.3742	266.4545	-266.4545	1.028	700	1	1000	0	0	0	0	0	0	0	0	0	0	0	0;				%Wind farm of 700 MW (One new Wind power plant added with the same nominal power of the sync. machine presented in the orginal IEEE 39 Buses system network)
	42	963.1196	54.9737	380.6492	-380.6492	1.027	1000	1	8442	0	0	0	0	0	0	0	0	0	0	0	0;			%Wind farm of 1000 MW (One new Wind power plant added with the same nominal power of the sync. machine presented in the orginal IEEE 39 Buses system network)

];



%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
	1	2	0.0035	0.0411	0.6987	600	600	600	0	0	1	-360	360;
	1	39	0.001	0.025	0.75	1000	1000	1000	0	0	1	-360	360;
	2	3	0.0013	0.0151	0.2572	500	500	500	0	0	1	-360	360;
	2	25	0.007	0.0086	0.146	500	500	500	0	0	1	-360	360;
	2	30	0	0.0181	0	900	900	2500	1.025	0	1	-360	360;
	3	4	0.0013	0.0213	0.2214	500	500	500	0	0	1	-360	360;
	3	18	0.0011	0.0133	0.2138	500	500	500	0	0	1	-360	360;
	4	5	0.0008	0.0128	0.1342	600	600	600	0	0	1	-360	360;
	4	14	0.0008	0.0129	0.1382	500	500	500	0	0	1	-360	360;
	5	6	0.0002	0.0026	0.0434	1200	1200	1200	0	0	1	-360	360;
	5	8	0.0008	0.0112	0.1476	900	900	900	0	0	1	-360	360;
	6	7	0.0006	0.0092	0.113	900	900	900	0	0	1	-360	360;
	6	11	0.0007	0.0082	0.1389	480	480	480	0	0	1	-360	360;
	6	31	0	0.025	0	1800	1800	1800	0.9714	0	1	-360	360;
	7	8	0.0004	0.0046	0.078	900	900	900	0	0	1	-360	360;
	8	9	0.0023	0.0363	0.3804	900	900	900	0	0	1	-360	360;
	9	39	0.001	0.025	1.2	900	900	900	0	0	1	-360	360;
	10	11	0.0004	0.0043	0.0729	600	600	600	0	0	1	-360	360;
	10	13	0.0004	0.0043	0.0729	600	600	600	0	0	1	-360	360;
	10	32	0	0.02	0	900	900	2500	1.07	0	1	-360	360;
	12	11	0.0016	0.0435	0	500	500	500	1.006	0	1	-360	360;
	12	13	0.0016	0.0435	0	500	500	500	1.006	0	1	-360	360;
	13	14	0.0009	0.0101	0.1723	600	600	600	0	0	1	-360	360;
	14	15	0.0018	0.0217	0.366	600	600	600	0	0	1	-360	360;
	15	16	0.0009	0.0094	0.171	600	600	600	0	0	1	-360	360;
	16	17	0.0007	0.0089	0.1342	600	600	600	0	0	1	-360	360;
	16	19	0.0016	0.0195	0.304	600	600	2500	0	0	1	-360	360;
	16	21	0.0008	0.0135	0.2548	600	600	600	0	0	1	-360	360;
	16	24	0.0003	0.0059	0.068	600	600	600	0	0	1	-360	360;
	17	18	0.0007	0.0082	0.1319	600	600	600	0	0	1	-360	360;
	17	27	0.0013	0.0173	0.3216	600	600	600	0	0	1	-360	360;
	19	20	0.0007	0.0138	0	900	900	2500	1.06	0	1	-360	360;
	19	33	0.0007	0.0142	0	900	900	2500	1.07	0	1	-360	360;
	20	34	0.0009	0.018	0	900	900	2500	1.009	0	1	-360	360;
	21	22	0.0008	0.014	0.2565	900	900	900	0	0	1	-360	360;
	22	23	0.0006	0.0096	0.1846	600	600	600	0	0	1	-360	360;
	22	35	0	0.0143	0	900	900	2500	1.025	0	1	-360	360;
	23	24	0.0022	0.035	0.361	600	600	600	0	0	1	-360	360;
	23	36	0.0005	0.0272	0	900	900	2500	1	0	1	-360	360;
	25	26	0.0032	0.0323	0.513	600	600	600	0	0	1	-360	360;
	25	37	0.0006	0.0232	0	900	900	2500	1.025	0	1	-360	360;
	26	27	0.0014	0.0147	0.2396	600	600	600	0	0	1	-360	360;
	26	28	0.0043	0.0474	0.7802	600	600	600	0	0	1	-360	360;
	26	29	0.0057	0.0625	1.029	600	600	600	0	0	1	-360	360;
	28	29	0.0014	0.0151	0.249	600	600	600	0	0	1	-360	360;
	29	38	0.0008	0.0156	0	1200	1200	2500	1.025	0	1	-360	360;
	20	40	0.0009	0.018	0	900	900	2500	1.009	0	1	-360	360;
	25	41	0.0006	0.0232	0	900	900	2500	1.025	0	1	-360	360;
	29	42	0.0008	0.0156	0	1200	1200	2500	1.025	0	1	-360	360;

];

%%-----  OPF Data  -----%%  (Orignal data from IEEE 39 buses New England Sytsem). Use it only if needed to be integrated in OPF (in the scope of Tool's integration/interaction)
%Costs assumed for thermal units present in the system are merely illustrative - don't assume it as realistic
% Must be defined by ICENT and/or LIST in accordance with the following merit order adotoped by INESC TEC for this Network  --> Merir order assumed for Generation/Machine Buses:[39, 31, 33, 36, 30, 35, 32]
%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
%mpc.gencost = [
%	2	0	0	3	0.01	0.3	0.2;
%	2	0	0	3	0.01	0.3	0.2;
%	2	0	0	3	0.01	0.3	0.2;
%	2	0	0	3	0.01	0.3	0.2;
%	2	0	0	3	0.01	0.3	0.2;
%	2	0	0	3	0.01	0.3	0.2;
%	2	0	0	3	0.01	0.3	0.2;
%	2	0	0	3	0.01	0.3	0.2;
%	2	0	0	3	0.01	0.3	0.2;
%	2	0	0	3	0.01	0.3	0.2;
%];
