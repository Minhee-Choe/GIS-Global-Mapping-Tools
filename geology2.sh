gmt begin geology2

gmt set FONT_ANNOT_PRIMARY 9p
#color topo
	gmt makecpt -Clightgray -T-12000,12000 -N

	gmt grdimage @earth_relief_01s -R-137.2/-136.2/59.5/60 -JM6i -I
	
# color terranes
	gmt makecpt -Ccategorical -T0/255/1 -N
	gmt plot Terranes.gmt -L -C -t65
#coast line
	gmt coast -Bxa0.5 -Bya0.25 -Dh -W0.25p -N1/0.25p,- -LjBL+w10+c59+o1/1 --MAP_TICK_PEN_PRIMARY=1.5p
#fault line
	gmt plot fault_normal.txt -Sf -Gblack

#aftershock relocation
	gmt plot cluster.afs -Ctest.cpt -Sc -h1 
	#gmt plot default.loc -Sc -Gblack@40 -W0.025,darkgray@40 -t20
	# gmt plot afs.reloc -Sc -Gred -W0.25
# psxy relocation-psmeca locationinmap
# 	gmt plot -W0.5 << END
# >
# -136.664111 59.78666
# -136.5 59.85
# >
# -136.731152 59.750509
# -136.9 59.75
# END
#focal mech
	gmt meca 7mt_reloc_mainavg.meca -Sm1.2+f0.05p -C0.5p+s2p -h1 
	gmt meca -Sm1.2+f0.05p -C0.5p,red+s2p -Gred << END
-136.664111 59.78666 8.71 1.30075	-0.7803	-0.72575	0.162875	-1.239175	1.681 25 -136.5 59.85 main1_reloc_average
-136.731152 59.750509 5.934 0.66825	0.678025	-0.8364	-0.6404	-0.779175	2.61775 25 -136.9 59.75 main2_reloc_average
-136.656559 59.768306 8	0.9379648	-1.348473	-0.9502259	-0.3094314	-0.0346241	0.8616861	22	-136.45	59.7	afs30_reloc
END
	# gmt meca globalcmt_loc.meca -Sm0.3c

#inset
	gmt inset begin -DjTR+w1.5i/1.2i
		gmt makecpt -Clightgray -T-12000,12000 -N
		gmt grdimage @earth_relief_15s -R-147/-127/56/64 -JM1.5i -I 
		gmt coast -Dl -B0 -Wthinnest -N1 -N2 -A1000  --MAP_FRAME_TYPE=inside
		gmt plot -St0.15 -Gblue station.csv
		gmt plot -W1 -Sr+s << END
-137.2 59.5 -136.2 60
END
	gmt inset end

gmt end show