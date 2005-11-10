# Portions of this file are subject to the following copyright.  See
# the SALVA-SQL's COPYING file for more details and other copyrights
# that may apply:
#
# Portions Copyright © 2005 UNAM, Inc. All rights reserved.
# Use is subject to license terms specified in the COPYING file
# distributed with the SALVA-SQL package.
#

#
# Process this file with autoconf to produce a configure script.
#

AC_PREREQ(2.59)

AC_INIT(salva-sql, 1.0, alex@bsdcoders.org)
AC_REVISION([$Revision: 64 $])
AC_COPYRIGHT([Copyright 2005 Alejandro Juarez, Gunnar Wolf
This configure script may be copied, distributed and modified under the 
terms of the GNU Library General Public license; see COPYING for more details])


# Checks for PostgreSQL programs.
AC_CHECK_PROGS([CREATEDB], [createdb])
if test -z "$CREATEDB"; then
        AC_MSG_ERROR([no acceptable createdb command found in \$PATH])
fi

AC_CHECK_PROGS([CREATEUSER], [createuser])
if test -z "$CREATEUSER"; then
        AC_MSG_ERROR([no acceptable createuser command found in \$PATH])
fi

AC_CHECK_PROGS([CREATELANG], [createlang])
if test -z "$CREATELANG"; then
        AC_MSG_ERROR([no acceptable createlang command found in \$PATH])
fi

AC_CHECK_PROGS([DROPDB], [dropdb])
if test -z "$DROPDB"; then
        AC_MSG_ERROR([no acceptable dropdb command found in \$PATH])
fi

AC_CHECK_PROGS([PG_DUMP], [pg_dump])
if test -z "$PG_DUMP"; then
        AC_MSG_ERROR([no acceptable pg_dump command found in \$PATH])
fi

AC_CHECK_PROGS([PG_RESTORE], [pg_restore])
if test -z "$PG_RESTORE"; then
        AC_MSG_ERROR([no acceptable pg_restore command found in \$PATH])
fi

AC_CHECK_PROGS([PSQL], [psql])
if test -z "$PSQL"; then
        AC_MSG_ERROR([no acceptable psql command found in \$PATH])
fi

AC_PROG_EGREP

#
# Postgresql database setup
#
DB=salva
define(WITHDB,[
AC_ARG_WITH(
  [db],
  AC_HELP_STRING(
    [--with-db],
    [Use salva to createdb (default=salva)]),
  [DB=$with_db],
)dnl
AC_MSG_CHECKING([for DB in $DB])
AC_MSG_RESULT([])
AC_SUBST(DB)])dnl
WITHDB


USER=salva
define(WITHUSER,[
AC_ARG_WITH(
  [user],
  AC_HELP_STRING(
    [--with-user],
    [This user will be used for the DB database (default=salva)]),
  [USER=$with_user],
)dnl
AC_MSG_CHECKING([for USER in $USER])
AC_MSG_RESULT([])
AC_SUBST(USER)])dnl
WITHUSER

USEPASSWD=no
define(WITHPASSWD,[
AC_ARG_WITH(
  [usepassword],
  AC_HELP_STRING(
    [--with-usepasswd],
    [Use this option to use password for each command executed in the DB database (default=no)]),
  [USEPASSWD=$with_usepasswd],
)dnl
AC_MSG_CHECKING([for USEPASSWD in $USEPASSWD])
AC_MSG_RESULT([])
AC_SUBST(USEPASSWD)])dnl
WITHPASSWD

ENCODING=SQL_ASCII
define(WITHENCODING,[
AC_ARG_WITH(
  [encoding],
  AC_HELP_STRING(
    [--with-encoding],
    [This encoding will be used for the DB database  (default=SQL_ASCII)]),
  [ENCODING=$with_encoding],
)dnl
AC_MSG_CHECKING([for ENCODING in $ENCODING])
AC_MSG_RESULT([])
AC_SUBST(ENCODING)])dnl
WITHENCODING

AC_CONFIG_FILES([Makefile:Makefile.in])

AC_OUTPUT

