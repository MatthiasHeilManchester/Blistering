#! /bin/bash

if [ $# -ne 1 ]; then
 echo "Please specify name of pdf file"
 exit 1
fi


stem=`basename $1 .pdf`

pdf_file=$stem.pdf
if [ -e $pdf_file ]; then
    echo " "
    echo "WARNING: "
    echo " "
    echo "      "$pdf_file
    echo " " 
    echo "already exists locally. Continue i.e. overwrite (y/n)?"
    read OPT
    if [ $OPT == "Y" -o $OPT == "y" ]; then
        echo "...overwriting"
    else
        echo "...bailing out"
        exit
    fi
fi
cp $1 $pdf_file


gs -q -o $stem.png -dFirstPage=1 -dLastPage=1 -r72 -sDEVICE=pngalpha $1
echo "<html>"
echo "<head>"
echo "<title>Blistering papers</title>"
echo "</head>"
echo "<body>"
echo "<table border=\"1\">"
echo "<!-- ==================ADD THIS BIT TO index.html==================== -->"
echo "<!-- ========START $stem ============================================ -->"  > new_entry.txt
echo "<tr>" >> new_entry.txt
echo "<td>" >> new_entry.txt
echo "<img src=\""$stem".png\">" >> new_entry.txt
echo "</td>" >> new_entry.txt
echo "<td>" >> new_entry.txt
echo "<a href=\""$stem".pdf\">"$stem"</a>" >> new_entry.txt
echo "</td>" >> new_entry.txt
echo "<td>" >> new_entry.txt
echo "<b>Notes:</b> " >> new_entry.txt
echo "<ul>" >> new_entry.txt
echo "<li> bla" >> new_entry.txt
echo "<li> bla" >> new_entry.txt
echo "</ul>" >> new_entry.txt
echo "<!--     ........UNCOMMENT THIS TO ADD SCANNED NOTES......... -->"  >> new_entry.txt
echo "<!-- " >> new_entry.txt
echo "<b>Scanned Notes:</b> <a href=\""$stem"_notes.pdf\">"$stem"_notes.pdf</a>" >> new_entry.txt
echo "-->" >> new_entry.txt
echo "<!--     ........END UNCOMMENT THIS TO ADD SCANNED NOTES..... -->"  >> new_entry.txt
echo "</td>" >> new_entry.txt
echo "</tr>" >> new_entry.txt
echo "<!-- ========END $stem ============================================ -->"  >> new_entry.txt
cat new_entry.txt
echo "<!-- ==================END ADD THIS BIT TO index.html================ -->"
echo "</table>"
echo "</body>"
echo "</html>"
echo " " 
echo "New entry is in new_entry.txt" 
echo " " 
exit
