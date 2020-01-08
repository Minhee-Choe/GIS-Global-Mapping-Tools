#!/bin/bash

PALETTE=/usr/share/gmt/cpt/etopo1.cpt
TOPO=topo_all2.grd
output=sta2.ps

gmtset ANNOT_FONT_PRIMARY 2
gmtset ANNOT_FONT_SIZE_PRIMARY 10
gmtset	LABEL_FONT 2
gmtset	LABEL_FONT_SIZE 11

F="-R-145/-127.5/56/64 -JM16 -V -K"

#gradient
grdgradient $TOPO -Giberica2.int -A0 -Nt -M

# plot color
grdimage  $TOPO -P -C$PALETTE $F -Iiberica2.int -Y5 > $output
# plot coastline
pscoast -R -O -Dh -W -Ba5f2.5/a2f1 -N1 -N2 $F >> $output
#basemap
psbasemap $F -O -Lf-144/55.2/50/200 --ANNOT_FONT_SIZE_PRIMARY=10 >> $output 
# plot fault
psxy $F -O -M -W5,red,** alaskafault.dat >> $output
psxy $F -O -M -W7,black,** plateboundary.dat >> $output

# plot earthquakes
psxy $F -O -Sc -Gred afs.reloc -W0.25 >> $output

# plot sta
psxy $F -O -St0.3 -G0/0/255 station.csv >> $output
pstext  $F -O station.csv --ANNOT_FONT_SIZE_PRIMARY=9 >> $output

# plot colorbar
makecpt -C$PALETTE -T-2000/4000/1 -D > temp1.cpt
psscale -Ctemp1.cpt -O -K -D5i/-0.5i/2i/0.1ih -I -B1000f1000/a500f500:"(m)": --ANNOT_FONT_SIZE_PRIMARY=9 >> $output #elevation in map 2



#legend
Fa="-R0/20/0/20 -Jx1 -V -K -O"

pstext	$Fa -Y-5 -N	--ANNOT_FONT_SIZE_PRIMARY=9	<< END		>> $output	
4.8 3.8  10 0 2 2 Magnitude
4.25 3.0 9 0 2 2 1
4.37 3.0 9 0 2 2 2
4.55 3.0 9 0 2 2 3
4.75 3.0  9 0  2 2 4
4.95 3.0  9 0  2 2 5
5.25 3.0  9 0  2 2 6
# 4.2 2.8  9 0  2 2 7
# 4.6 2.8  9 0  2 2 8
END

psxy $Fa -L -Gred -Sc -W0.25 	<< END		>> $output
4.25 3.5 0.05
4.37 3.5 0.10
4.55 3.5 0.15
4.75 3.5 0.20
4.95 3.5 0.25
5.25 3.5 0.30
# 4.2 3.3 0.35
# 4.6 3.3 0.40
END


pstext	$Fa -N --ANNOT_FONT_SIZE_PRIMARY=9	<< END		>> $output	
2.95 3.15 10 0 2 2 km
12.9 3.9 10 0 2 2 Elevation
END