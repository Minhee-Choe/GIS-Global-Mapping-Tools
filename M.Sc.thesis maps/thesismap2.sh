#!/bin/bash

PALETTE=/usr/share/gmt/cpt/etopo1.cpt
TOPO=topo_all.grd
output=thesismap2.ps

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

#plot vector size:arrowwidth/headlength/headwidth
psxy $F -O -Sv0.05/0.08/0.08 -G124/157/189 vector.txt >> $output


# plot colorbar
# psscale -D6.5i/2i/1.5i/0.1i -Ctemp.cpt -E -B1d/:"Day": -K -O >> $output #time proto
# psscale -Ctemp.cpt -O -K -D5i/-0.5i/2i/0.1ih -I -B0 -K -O --ANNOT_FONT_SIZE_PRIMARY=9 >> $output #time in map3
# makecpt -C$PALETTE -T-6000/6000/1 -D > temp1.cpt
psscale -C$PALETTE -O -K -D5i/-0.5i/2i/0.1ih -I -B5000f1000/:"(m)": --ANNOT_FONT_SIZE_PRIMARY=9 >> $output #elevation in map 2


#basemap
psbasemap $F -O -Lf-153/54/50/200 --ANNOT_FONT_SIZE_PRIMARY=10 >> $output #thesis map2,3


# Mt.Mckinley, study area
psxy $F -O -St0.3 -G0/102/0  << END >> $output
-151.04 63.145
END
psxy $F -O -Sa0.4 -Gyellow  << END >> $output
-136.695101	59.807682
END
psxy $F -O -Sc0.2 -Gblack  << END >> $output
-135.055 60.72
-149.9 61.208
-134.417 58.303
END
# psxy $F -O -L -W1.25,black << END >> $output
# -140 58.5
# -140 61.8
# -135 61.8
# -135 58.5
# END

#legend
Fa="-R0/20/0/20 -Jx1 -V -K -O"

pstext	$Fa -Y-5 -N --ANNOT_FONT_SIZE_PRIMARY=9	<< END		>> $output	
12.9 3.9 10 0 2 2 Elevation
2.55 3.25 10 0 2 2 km
END

psxy $Fa -Sv0.05/0.08/0.08 -G124/157/189 << END >> $output
7.5 3.5 0 1
END

pstext	$Fa	-N --ANNOT_FONT_SIZE_PRIMARY=9 << END		>> $output
8 3 10 0 2 2 10mm/yr
8 3.7 10 0 2 2 GNSS
END

# ps2pdf $output 
