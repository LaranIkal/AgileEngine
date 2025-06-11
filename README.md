# Repository for Perl scripts used in data migration from Infor BaaN IV to BaaN V

# Infor BaaN IV and BaaN V utilities to export and import data:

## Export table:

${BSE}/bin/bdbpre6.1 -t"|" -N timcs016 -C 000 

creates timcs016000.S in the current
directory. This sequential file is an ASCII dump of table timcs016000, in which
case the fields are separated by | 


## To import data to tables:
${BSE}/bin/bdbpost6.1 -t"|" -R -D./seqdir

-R tells baan to update or insert the records.
-A instead of -R appends records to table.

These commands are still available on Infor LN


