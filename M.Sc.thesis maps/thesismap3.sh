#!/bin/bash

PALETTE=/usr/share/gmt/cpt/etopo1.cpt
TOPO=topo_all.grd
output=thesismap3.ps

gmtset ANNOT_FONT_PRIMARY 2
gmtset ANNOT_FONT_SIZE_PRIMARY 10
gmtset	LABEL_FONT 2
gmtset	LABEL_FONT_SIZE 11


F="-R-155/-130/55.5/64 -Jl-142.5/59.75/55.5/64/1:10000000 -V -K" #proto

#gradient
grdgradient $TOPO -Giberica2.int -A0 -Nt -M

# plot color
grdimage  $TOPO -P -C$PALETTE $F -Iiberica2.int -Y5 > $output
# plot coastline
pscoast -R -O -Dh -W -Ba5f2.5/a2f1 -N1 -N2 $F >> $output #thesis map 2,3

# plot fault
psxy $F -O -M -W5,red,** alaskafault.dat >> $output
psxy $F -O -M -W7,black,** plateboundary.dat >> $output


#make palette of events depending on time
makecpt -Chot -T0/10/0.01 -D > temp.cpt

# plot earthquakes
psxy $F -O -Sc -W0.1 -Ctemp.cpt overmag6_2.csv >> $output

# plot colorbar
psscale -Ctemp.cpt -O -K -D5i/-0.5i/2i/0.1ih -I -B0 -K -O --ANNOT_FONT_SIZE_PRIMARY=9 >> $output #time in map3

#basemap
psbasemap $F -O -Lf-153/54/50/200 --ANNOT_FONT_SIZE_PRIMARY=10 >> $output #thesis map2,3


# reference of fig earthquakehistory and tectonicmodel
psxy $F -O -L -W3,0/51/102,-- << END >> $output
-140 58.5
-140 61.8
-135 61.8
-135 58.5
END
psxy $F -O -L -W3,0/51/102,-- << END >> $output
-145 56
-145 64
-127.5 64
-127.5 56
END

#reference of cities, study area and mt.mckinley
# psxy $F -O -Ss0.2 -Gblue  << END >> $output
# -135.055 60.72
# -149.9 61.208
# -134.417 58.303
# END
psxy $F -O -St0.3 -G0/102/0  << END >> $output
-151.04 63.145
END
# psxy $F -O -Sa0.2 -Gpurple  << END >> $output
# -136.695101	59.807682
# END

#legend
Fa="-R0/20/0/20 -Jx1 -V -K -O"

pstext	$Fa -Y-5 -N --ANNOT_FONT_SIZE_PRIMARY=9	<< END		>> $output	
12.8 3.9 10 0 2 2 Time
15 3 10 0 2 2 2017-05-01
10 3 10 0 2 2 1899-07-14
2.55 3.25 10 0 2 2 km
4.65 3.9  10 0 2 2 Magnitude
4.15 3.1  9 0  2 2 6
4.5 3.1  9 0  2 2 7
4.9 3.1  9 0  2 2 8
END

psxy -R0/20/0/20 -Jx1 -V -O -L -Gyellow -Sc -W0.25 	<< END		>> $output
4.15 3.6 0.27
4.5 3.6 0.32
4.9 3.6 0.37
END

# ps2pdf $output 
