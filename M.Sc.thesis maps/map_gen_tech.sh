#!/bin/bash

# output=thesismap5.ps
# TOPO=topo_all.grd

gmtdefaults -D > .gmtdefaults

gmtset MEASURE_UNIT cm
gmtset PAPER_MEDIA A4
# gmtset ANOT_FONT_SIZE 12p
# gmtset LABEL_FONT_SIZE 11p
gmtset DEGREE_SYMBOL degree
gmtset PLOT_DEGREE_FORMAT D

# makecpt -Cglobe > tmp.cpt

# grdgradient $TOPO -Giberica2.int -A0 -Nt -M

# grdimage $TOPO -R-140/-135/58.5/60.5 -Iiberica2.int -JM450 -B0.5 -Ctmp.cpt -P -K > $output

# pscoast -R-140/-135/58.5/60.5 -JM450 -Df -W1/0 -O >> $output

# img2grd /home/msd-server05/Downloads/topo_19.1.img -T1 -S1 -V -R-160/-130/50/70 -m1 -D -Gtopo_all.grd

# PALETTE=/home/msd-server05/Downloads/topo.cpt
PALETTE=/usr/share/gmt/cpt/etopo1.cpt
TOPO=topo_all.grd
output=thesismap5.ps

gmtset ANNOT_FONT_PRIMARY 2
gmtset ANNOT_FONT_SIZE_PRIMARY 12
gmtset	LABEL_FONT 2
gmtset	LABEL_FONT_SIZE 11

F="-R-140/-135/58.5/61.6 -JM16 -V -K"
# F="-R-155/-130/55.5/64 -JM16 -V -K"

grdgradient $TOPO -Giberica2.int -A0 -Nt -M

# plot color
grdimage  $TOPO -P -C$PALETTE $F -Iiberica2.int -Y5 > $output
# plot coastline
pscoast -R -O -Dh -W -Ba2f1/a1f1 -N1 -N2 $F >> $output
# plot fault
psxy $F -O -M -W5,red,** alaskafault.dat >> $output
psxy $F -O -M -W7,black,** plateboundary.dat >> $output

# plot earthquakes
psxy $F -O -Sc -Gred afs.reloc -W0.25 >> $output


#plot vector size:arrowwidth/headlength/headwidth
psxy $F -O -Sv0.08/0.1/0.1 -G124/157/189 vector.txt >> $output

# plot sta
psxy $F -O -St0.3 -G0/0/255 station.csv >> $output
pstext  $F -O station.csv --ANNOT_FONT_SIZE_PRIMARY=9 >> $output

# plot colorbar
makecpt -C$PALETTE -T-2000/4000/1 -D > temp1.cpt
psscale -Ctemp1.cpt -O -K -D5i/-0.5i/2i/0.1ih -I -B1000f1000/a500f500:"(m)": --ANNOT_FONT_SIZE_PRIMARY=9 >> $output #elevation in map 2


#basemap
psbasemap $F -O -Lf-139.65/58.3/50/50 --ANNOT_FONT_SIZE_PRIMARY=11 >> $output


# Mt.Mckinley, study area
psxy $F -O -St0.7 -G51/255/51 << END >> $output
-137.5413 58.9109 
END
psxy $F -O -St1.0 -G51/255/51  << END >> $output
-137.44 58.9109
END

# psxy relocation-psmeca locationinmap
psxy $F -O -m -W0.5 << END		>> $output
>
-136.664111 59.78666
-136.5 60.25
>
-136.731152 59.750509
-136.8 59.25 
END

psmeca focal_main.average $F -Sm1.2 -H1 -O >>$output

# #compression
# psxy $F -O -Sv1.0/0.9/1.0 -Gyellow << END >> $output
# -136.15 60.08 235.45 1.5
# -137.1 59.4 55.45 1.5
# END

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

pstext	$Fa -N --ANNOT_FONT_SIZE_PRIMARY=9	<< END		>> $output	
2.95 3.15 10 0 2 2 km
12.9 3.9 10 0 2 2 Elevation
END

# pstext	$Fa -Gmagenta  << END >> $output
# 8 9 10 -42 1 0 DF
# END

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


psxy $Fa -Sv0.08/0.1/0.1 -G124/157/189 << END >> $output
7.5 3.5 0 1
END

pstext	$Fa	-N --ANNOT_FONT_SIZE_PRIMARY=9 << END		>> $output
8 3 10 0 2 2 10mm/yr
8 3.7 10 0 2 2 GNSS
# 12.8 3.9 10 0 2 2 Time
# 15 3 10 0 2 2 2017-05-01
# 10 3 10 0 2 2 1899-07-14
END
