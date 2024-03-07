# GMT 6 code to plot study area along with fault lines, and focal mechnism solutions
# Correspondence Author: Mohammad Salam, Email Address: salamphysicist@hotmail.com
gmt begin ../OutPut/Figure1
	gmt subplot begin 1x2 -Fs6i,2i/6i,6i 
		gmt subplot set 
			gmt gmtset FONT_TITLE = 14p,Helvetica,black 
			gmt basemap -R60/66/24/30 -JM6i -Bxa1f0.5+l"Longitude" -Bya1f0.5+l"Latitude" -BWeSN
			gmt makecpt -Cgeo -T-10000/12000/50 -Z
			gmt grdimage  -R60/66/24/30 -JM6i @earth_relief_15s.grd -I -C                                                                        
			gmt coast -R60/66/24/30 -JM6i -W0.25p -Vewd -Na -Ir/1p,blue -Scornflowerblue
			gmt plot -JM6i ../InPut/gem_active_faults.gmt -R60/66/24/30 -i0,1 -Wthinner,red -Df #-Sl
			gmt meca  -V  ../InPut/fmn1.txt -R60/66/24/30 -JM6i -Sc0.5 -Gblue
			gmt meca  -V  ../InPut/fmn2.txt -R60/66/24/30 -JM6i -Sc0.5 -Ggreen
			gmt meca  -V  ../InPut/fmn3.txt -R60/66/24/30 -JM6i -Sc0.5 -Gred
			gmt makecpt -Cglobe -T0/12000/50 -Z    #-T0/8500/50 -Z
			gmt colorbar -Dx4c/1c+w5c/0.5c+o0/0c+jBC+h -C -Bxaf -By+l"Topo (m)"   # -Bxaf+l"Elevation"
			gmt text  ../Input/Regions.txt -R60/66/24/30 -JM6i -F+f+a+j  #-D-0.07/-0.05 
		gmt subplot set 
			gmt psxy -R0/160/24/30 ../InPut/fmn1.txt -i2,1 -Sc8p -W0.25p -h1 -JX2i/6.7i -Gblue -Bxa50f5g20+l"Events Depth (Km)" -Bya1f0.5+l"Latitude" -BwSnE
			gmt psxy -R0/160/24/30 ../InPut/fmn2.txt -i2,1 -St10p -W0.25p -JX2i/6.7i -Ggreen
			gmt psxy -R0/160/24/30 ../InPut/fmn3.txt -i2,1 -Sa10p -W0.25p -JX2i/6.7i -Gred
	gmt subplot end
gmt end show