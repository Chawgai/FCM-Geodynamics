#!/bin/bash
gmt begin ../OutPut/Figure1
	gmt subplot begin 1x2 -Fs6i,2i/6i,6i 
		gmt subplot set 
			gmt gmtset FONT_TITLE = 14p,Helvetica,black 
			gmt basemap -R60/66/24/30 -JM6i -Bxa1f0.5+S"Longitude" -Bya1f0.5+S"Latitude" -BWeSN
			gmt makecpt -Cgeo -T-10000/12000/50 -Z
			gmt grdimage  -R60/66/24/30 -JM6i D:/Working/Mapping/Data/earth_relief_15s.grd -I -C
			gmt coast -R60/66/24/30 -JM6i -W0.25p -Vewd -Na -Ir/1p,blue -Scornflowerblue
			gmt plot -JM6i ../Input/gem_active_faults.gmt -R60/66/24/30 -i0,1 -Wthinner,red -Df #-Sl
			gmt meca  -V  ../Input/fmn1.txt -R60/66/24/30 -JM6i -Sc0.5 -Gblue
			gmt meca  -V  ../Input/fmn2.txt -R60/66/24/30 -JM6i -Sc0.5 -Ggreen
			gmt meca  -V  ../Input/fmn3.txt -R60/66/24/30 -JM6i -Sc0.5 -Gred
			gmt makecpt -Cglobe -T0/12000/50 -Z    #-T0/8500/50 -Z
			gmt colorbar -Dx5.5c/1c+w5c/0.5c+o0/0c+jBC+h -C -Bxaf -By+l"Topo (m)"   # -Bxaf+l"Elevation"
			gmt text  ../Input/Regions.txt -R60/66/24/30 -JM6i -F+f+a+j  #-D-0.07/-0.05 
			gmt basemap -TdjTL+w1.5c+l+o0c/0c   # North symble
			################################ Legends ###################################
			echo 65.1 24.55 0.0 4.40 2.6 | gmt plot -R60/66/24/30 -JM6i -Sj -Wthin,black -Ggray # Plot rectangle
			echo 64.5 24.85 0.0 45 90 180 135 90 0 4.7 0 0 0 | gmt meca -R60/66/24/30 -JM6i -Sc0.5 -Ggreen
			echo 64.5 24.55 0.0 0 55 -100 180 55 -73 6.0 0 0 0 |gmt meca -R60/66/24/30 -JM6i -Sc0.5 -Gblue
			echo 64.5 24.25 0.0 90 45 90 270 45 90 8.1 0 0 0 | gmt meca -R60/66/24/30 -JM6i -Sc0.5 -Gred
			echo 64.7 24.80 Strike-Slip Falt, Mw 4.7 | gmt text -R60/66/24/30 -JM6i -F+f8,Helvetica-Bold,black+jL
			echo 64.7 24.51 Normal Falt, Mw 6.0 | gmt text -R60/66/24/30 -JM6i -F+f8,Helvetica-Bold,black+jL
			echo 64.7 24.20 Thrust Falt, Mw 8.1 | gmt text -R60/66/24/30 -JM6i -F+f8,Helvetica-Bold,black+jL
			######################## Inset #########################
			gmt inset begin -D40/80/10/50 -DjBL+w1.0i/1.0i+o0.2/0.2 -N #-F+p3p,blue 
				gmt coast -Rg -JA50/30/30/1.0i -Bg -Dc -A100000 -Gnavy -Sgray  #-JAlon0/lat0[/horizon]/width
				gmt plot ../Input/Regplot.txt -Rg -JA50/30/30/1.0i -i0,1 -Wthicker,red,solid 	
			gmt inset end
			########################### Right side subplot #######################
		gmt subplot set 
			#gmt makecpt -Cred,green,blue,slateblue1 -T0,20,30,70,100 -N
			gmt psxy -R0/160/24/30 ../Input/fmn1.txt -i2,1 -Sc8p -W0.25p -h1 -JX2i/6.7i -Gblue -Bxa50f5g20+l"Events Depth (Km)" -Bya1f0.5+l"Latitude" -BwSnE
			gmt psxy -R0/160/24/30 ../Input/fmn2.txt -i2,1 -St10p -W0.25p -JX2i/6.7i -Ggreen
			gmt psxy -R0/160/24/30 ../Input/fmn3.txt -i2,1 -Sa10p -W0.25p -JX2i/6.7i -Gred
	gmt subplot end
gmt end show
###################################################################################################
#
#			# fmn2.txt	, Strike-Slip Falt, Mw 4.7
#			gmt meca -R60/66/24/30 -JM6i -Sc0.5 -Ggreen << END
#			# lon lat depth str dip slip st dip slip mant exp plon plat
#			64.5 25 0.0 45 90 180 135 90 0 4.7 0 0 0
#END
#		
#			# fmn1.txt, Normal Falt, Mw 6.0
#			gmt meca -R60/66/24/30 -JM6i -Sc0.5 -Gblue << END
#			# lon lat depth str dip slip st dip slip mant exp plon plat
#			64.5 24.7 0.0 0 55 -100 180 55 -73 6.0 0 0 0
#END
#			# fmn3.txt, Thrust Falt, Mw 8.1
#			gmt meca -R60/66/24/30 -JM6i -Sc0.5 -Gred << END
#			# lon lat depth str dip slip st dip slip mant exp plon plat
#			64.5 24.4 0.0 90 45 90 270 45 90 8.1 0 0 0
#END
##################### Inset #####
		#gmt grdview D:/Working/Mapping/Data/earth_relief_05m.grd -R40/80/10/50/-1000/4000 -JM1.0i -Ctopo -I+d -N-1000+ggray -Qi500 -Wthinnest -Ba20 -BwEsN
		#gmt grdimage -Rg -JE73.27/33.65/25/1.0i D:/Working/Mapping/Data/earth_relief_05m.grd -W -C
		#gmt coast -Rg -JG30/60/1.0i -Bag -Dc -A5000 -Gnavy -Scornflowerblue
		###########################################################################
		#gmt coast -Rg -JF70/30/35/1.0i -B -Dc -A10000 -Gtan -Scyan -Wthinnest
		#gmt plot ../Input/Regplot.txt -Rg -JF70/30/35/1.0i -i0,1 -Wthicker,red,solid -Gblue
		#############################################################################
		#gmt coast -Rg -JF40/60/60/1.0i -Dc -A10 -Gnavy -Scyan -Wthinnest
		#gmt coast -R45/100/-30/60 -Jj1:400000000 -Bx45g45 -By30g30 -Dc -A10000 -Gkhaki -Wthinnest -Sazure
		#gmt coast -R40/80/10/50 -JM1.0i -W0.25p -Df -Vewd -Na -Scornflowerblue 
		#gmt plot ../Input/kashmir.xy -R${reg} -JM2.0i -i1,0 -Wthin  # in gmt row number start from 0
		#gmt plot -JM1.0i ../Input/World-Faults.xyz -R40/80/10/50 -i0,1 -Wthinnest,red,- -Df
		#gmt plot ../Input/Regplot.txt -R40/80/10/50 -JM1.0i -i0,1 -Wthicker,blue,solid
		#gmt basemap -R40/80/10/50 -JM1.0i -Ba20 -BwEsN #-F+p3p
		####### Legends #########
		#echo 64.0 24.35 90 0.7i | gmt plot -R60/66/24/30 -JM6i -Sv0.3i+bt+et -Gred -W1p,red
		#echo 64.0 24.35 Magnitude | gmt text -R60/66/24/30 -JM6i -F+a90+f8,Helvetica-Bold,blue
		#echo 64.28 24.35 270 0.10i | gmt plot -R60/66/24/30 -JM6i -Sv0.18i+ea -Gred -W8p,black
		#gmt plot Mag.txt -R60/66/24/30 -JM6i -W5p,black -SqD40k:+o+gwhite+LDk+f5p,Helvetica-Bold,red+l"Magnitude"
