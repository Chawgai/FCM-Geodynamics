# GMT 6 code to plot study area along with fault lines.
# Correspondence Author: Mohammad Salam, Email Address: salamphysicist@hotmail.com
gmt begin ../InPut/FM jpg
	gmt gmtset  FONT_TITLE = 14p,Helvetica,black 
	gmt basemap -R59.8/66.2/24/30.2 -JM6i #-Bxa1f0.5+l"Longitude" -Bya1f0.5+l"Latitude" -BWESN
	gmt makecpt -Cgeo -T-10000/12000/50 -Z
	gmt grdimage  -R59.8/66.2/24/30.2 -JM6i D:/Working/Mapping/Data/earth_relief_15s.grd -I -C                                                                        
	gmt coast -R59.8/66.2/24/30.2 -JM6i -W0.25p -Vewd -Scornflowerblue #-Na -Ir/1p,blue 
	gmt plot -JM6i ../InPut/gem_active_faults.gmt -R59.8/66.2/24/30.2 -i0,1 -Wthinner,red -Df #-Sl
	gmt text  ../InPut/Regions.txt -R60/66/24/30 -JM6i -F+f+a+j  #-D-0.07/-0.05
gmt end show