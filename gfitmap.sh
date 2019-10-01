#based on https://scottishsnow.wordpress.com/2016/05/14/mapping-from-gps-files/ and https://gis.stackexchange.com/a/159488/73254

rm -rf Takeout; unzip takeout*.zip
rm -rf runs; mkdir runs
rm tracks.geojson

for f in Takeout/Fit/Activities/*Running*.tcx
do 
    strip_extension=${f%.*}
    basepath=${strip_extension##*/}
    new_filename=$basepath.gpx
    gpsbabel -i gtrnctr -f $f -o gpx -F ./runs/$new_filename
    ogr2ogr -f "GeoJSON" ./tracks.geojson -append "./runs/$new_filename" tracks #-mapFieldType DateTime=String 
done
