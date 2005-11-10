# Makefile: To load data to the tables in the database.
#
# Copyright (c) 2004 Alejandro Juarez <alex@fisica.unam.mx>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFT
#                                                                             
# PURPOSE: This script was created to extract data from a file and after that 
#          insert these data to a table using some database(Pg,mysql,etc)     
#                                                                             
# USAGE: make clean && make all
#

DBNAME= salva
USER= alex
PASSWD=
SQLPATH=./sql
SCRIPT=tloader.pl
SCRIPTPATH=./perl
DATAPATH=../data/fisica

drop:
	cd ${SQLPATH}; make drop;

clean: 	drop

all: 	depend install

depend: 
	cd ${SQLPATH}; make depend install


load_tables:
	echo "Testing if ${SCRIPTPATH}/${SCRIPT} exists";
	if test -f ${SCRIPTPATH}/${SCRIPT}; then \
		if test -d ${DATAPATH}; then \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/userstatus.txt -s ':' -t userstatus -fields userstatus; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/groups.txt -s ':' -t groups -fields id,description; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/help.txt -s '__' -t help -fields id,name,description,example; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/dictionary.txt -s ':' -t dictionary -fields form,field,validation,constfunc,cgifunc,colslength,rowsmaxlength,sql,tabindex,hid; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/menu.txt -s ':' -t menu -fields label,icon,iconpath,style,gid;\
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/tree.txt -s ':' -t tree -fields mid,label,orders,level,iconopen,iconclosed,action,target,expanded;\
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/categories.txt -s ':' -t categories -fields category; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/depths.txt -s ':' -t depths -fields depth; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/countries.txt -s ':' -t countries -fields country,citizen; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/maritalstatus.txt -s ':' -t maritalstatus -fields maritalstatus; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/addresstype.txt -s ':' -t addresstype -fields type; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/conferencestype.txt -s ':' -t conferencestype -fields type; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/coursestype.txt -s ':' -t coursestype -fields type; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/prizestype.txt -s ':' -t prizestype -fields type; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/gotdegreetype.txt -s ':' -t gotdegreetype -fields type; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/sourcesfinancing.txt -s ':' -t sourcesfinancing -fields name; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/articlestype.txt -s ':' -t articlestype -fields type; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/articlesstatus.txt -s ':' -t articlesstatus -fields status; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/researcherroll.txt -s ':' -t researcherroll -fields roll; \
		${SCRIPTPATH}/${SCRIPT} -dbname ${DBNAME} -u ${USER} -file ${DATAPATH}/doctype.txt -s ':' -t doctype -fields type; \
		fi; \
	else \
		echo "*** The ${SCRIPTPATH}/${SCRIPT} script doesn't exists ***"; \
	fi 

install: depend load_tables


 
