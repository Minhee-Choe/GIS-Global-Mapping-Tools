gmt begin geology3

gmt set FONT_ANNOT_PRIMARY 9p

#color topo
	gmt makecpt -Clightgray -T-12000,12000 -N

	gmt grdimage @earth_relief_15s -R-144/-132/56/63 -JM6i -I

#coast line
	gmt coast -Ba2f1 -Dh -W0.25p -N1/0.25p,- -LjBL+w50+c59+o1/1 --MAP_TICK_PEN_PRIMARY=1.5p

#historical events
	gmt plot -S+ iris.event 
#fault line
	gmt plot fault_select.txt 
	gmt plot -Sf -Gblack fault_normal.txt 

#focal mech
	gmt meca doser.meca -Sa0.5+f0.05p -Gblue -h1 
	gmt meca 7mt_orgloc.meca -Sm0.5+f0.05p -Gred -C0.5p,red+s2p -h1 
	gmt meca globalcmt-doser.meca -Sm0.5+f0.05p
	gmt meca globalcmt-doser2.meca -Sz0.5+f0.05p -h1



gmt end show