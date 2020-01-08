gmt begin geology1
#rotate 
	gmt set MAP_ANNOT_OBLIQUE 30
	gmt set FONT_ANNOT_PRIMARY 9p
	gmt set MAP_VECTOR_SHAPE=2
#distacne from tickmark to annotation
	gmt set MAP_ANNOT_OFFSET_PRIMARY 0.1
#color topo
	gmt makecpt -Clightgray -T-12000,12000 -N
	# gmt grdimage @earth_relief_15s -R-155/55/-130/65r -JS-141/60/18c -I
	gmt grdimage topo_all.grd -R-155/55/-130/65r -JS-141/60/18c -Iiberica2.int
# color terranes
	gmt makecpt -Ccategorical -T0/255/1 -N -A65 >> terrane.cpt
	gmt plot Terranes.gmt -L -Cterrane.cpt 
	gmt set FONT_ANNOT_PRIMARY 9p
#coast line
	gmt coast -R-155/55/-130/65r -JS-141/60/18c -Bxa10f5 -Bya5 -Dl -A250 -W1/0.25p,gray40 -W3/0.001p -N1/0.25p,gray40,- -N2/0.25p,gray40,- --MAP_TICK_PEN_PRIMARY=1.5p
	# for scale add : -LjBL+w100+c59+o0.5/1
#fault line
	gmt plot -Sf -Gblack fault_normal.txt 
	gmt plot fault_select.txt 
	# gmt plot ~/Downloads/Major_faults.gmt -Wthicker
	# gmt plot ~/Downloads/quaternary.gmt -Wthicker
#plate motion vectors
	gmt plot -Sv0.35+eA+a70+p2p -W4p,black  << EOF
-140 59 113 1.1
-142 56 104.6 1.1
EOF

#inset
	gmt inset begin -DjTR+w2i/1.2i+o0/-0.1
		gmt coast -R-175/-110/52/72 -JB-142.5/60/55/65/2i  -W3/0.001p -Dl -Gbisque -Swhite -B0 -W1/0.25p,gray40 -N1/0.25p,gray40 -N2/0.25p,gray40 -A1000 --MAP_FRAME_TYPE=inside
		# reference of map
		gmt plot -W0.7p -Sj << END
-144.5 60.5 -2 1.55 1.32
END
# 		gmt plot -W1 -Sr+s << END
# -155 55 -130 65
# END

	gmt inset end

# # reference of study area
# 	gmt plot -W0.7 -Sr+s << END
# -137.2 59.5 -136.2 60
# END

#Denali mountain
	gmt plot -St0.4 -W2 -Gwhite << END
-151.04 63.145 
END
	gmt text -F+f9p,Helvetica << END
-151.04  63.5  Denali Mt.
# Wrangell Mtns
# St. Elias Mtns
END

#Denali earthquake
#mag7.9
	gmt plot -Sa0.79 -Gmagenta << END
-147.444 63.517
END
#mag6.7
	gmt plot -Sa0.67 -Gmagenta << END
-147.912 63.514
END

# Doublet
	gmt plot -Sa0.63 -Gyellow  << END 
-136.695101	59.807682
END


#focal mech
	# gmt meca focal.recent -Sm0.5 -h1 
	# gmt meca globalcmt.gmt -Sm0.3c

#cities, faults, regions labels
	gmt plot -Sc0.2 -Gblack  << END
-135.055 60.72
-149.9 61.208
-134.417 58.303
END
	gmt text -F+f8,Helvetica-Oblique << END
-133.92 60.72 Whitehorse
-148.8 61.2 Anchorage
-133.7 58.303 Juneau
END
	gmt text -F+f+a << END
-140 58.8 8p 0 50.3mm/yr
-141 56.2 8p 0 50.9mm/yr
# -142.5 62 8p,1 -63 Totshunda Fault
# -139 60.8 8p,1 -30 Duke River Fault
# -138.9 59.4 8p,1 -56 Fairweather Fault
# Denali Fault
# Aleutian Megathrust
# Transition Fault
# Tintina Fault
# Chatham Strait Fault
END
	# gmt text -Gwhite@40 -F+f12,Times-Roman << END
# -144 64.8 Alaska
# -139 64.8 Yukon
# -145 56.2 Pacific
# END
# 	gmt text -M -Gwhite@40 -F+f12p,Times-Roman << END
# >-133.5 59.5 12p 0.4i c  
# British

# Columbia
# END

#Terranes legend
	gmt set FONT_ANNOT_PRIMARY 6.5p
	gmt legend -DJBL+o0/0i+w2i+jBL -F+pthinner+gwhite@30 << EOF
H 8p,Helvetica-Bold Terranes
A terrane
L 7p,Helvetica-Bold L Outboard
G 0.1i
N 2
S 0.1i s 0.25i z=0 0.25p 0.3i Yakutat
S 0.1i s 0.25i z=2 0.25p 0.3i Chugach -
S 0.1i s 0.0001i z=0 0.25p 
S 0.1i s 0.0001i z=2 0.25p 0.3i Prince William 
G 0.1i
N 2
S 0.1i s 0.25i z=5 0.25p 0.3i Koyakuk
S 0.1i s 0.25i z=12 0.25p 0.3i Angayucham
G 0.1i
N 1
L 7p,Helvetica-Bold L Insular
G 0.1i
N 2
S 0.1i s 0.25i z=6 0.25p 0.3i Peninsula
S 0.1i s 0.25i z=7 0.25p 0.3i Wrangellia
G 0.1i
N 2
S 0.1i s 0.25i z=8 0.25p 0.3i Alexander
S 0.1i s 0.25i z=9 0.25p 0.3i Kluane, Windy, 
S 0.1i s 0.0001i z=8 0.25p 
S 0.1i s 0.0001i z=9 0.25p 0.3i Coast 
G 0.1i
N 1
L 7p,Helvetica-Bold L Intermontane
G 0.1i
N 2
S 0.1i s 0.25i z=10 0.25p 0.3i Taku
S 0.1i s 0.25i z=17 0.25p 0.3i Cache Creek
G 0.1i
N 2
S 0.1i s 0.25i z=23 0.25p 0.3i Stikinia
S 0.1i s 0.25i z=24 0.25p 0.3i Quesnellia
G 0.1i
N 2
S 0.1i s 0.25i z=25 0.25p 0.3i Yukon-Tanana
S 0.1i s 0.25i z=26 0.25p 0.3i Slide Mountain
G 0.1i
N 1
S 0.1i s 0.25i z=27 0.25p 0.3i Cassiar
G 0.1i
L 7p,Helvetica-Bold L Northern Alaska
G 0.1i
N 2
S 0.1i s 0.25i z=13 0.25p 0.3i Farewell
S 0.1i s 0.25i z=15 0.25p 0.3i Ruby
G 0.1i
N 1
L 7p,Helvetica-Bold L Ancestral North America
G 0.1i
N 2
V 0 0.001p
S 0.1i s 0.25i z=28 0.25p 0.3i North America 
S 0.1i s 0.25i z=29 0.25p 0.3i North America 
S 0.1i s 0.0001i z=28 0.25p 0.3i basinal
S 0.1i s 0.0001i z=29 0.25p 0.3i platform
G 0.1i
N 1
M - 55.1 100+u+ab
EOF

gmt end show
