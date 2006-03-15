set terminal postscript eps monochrome
set output "articles_imp.eps" 
set style line 1 lt 1 lw 50
set xrange[2002:2006]
set yrange[0:300]

set ylabel "No. de artículos publicados con arbitraje"
set xlabel "Periodo"

set xtics ( "2003" 2003, "2004" 2004, "2005" 2005)

set mytics
set grid
plot "articles.dat" u 1:2 title "" w imp ls 1 


