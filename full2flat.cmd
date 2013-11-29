:: Copyright © 2013 George Anastassakis (anastas@unipi.gr)
::
:: This file is part of cvxmltools.
::
:: cvxmltools is free software: you can redistribute it and/or modify it under the
:: terms of the GNU General Public License as published by the Free Software
:: Foundation, either version 3 of the License, or (at your option) any later
:: version.
::
:: cvxmltools is distributed in the hope that it will be useful, but WITHOUT ANY
:: WARRANTY:: without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
:: PARTICULAR PURPOSE. See the GNU General Public License for more details.
::
:: You should have received a copy of the GNU General Public License along with
:: cvxmltools. If not, see http://www.gnu.org/licenses/.

@echo off

if "%1"=="" goto badargs
if "%2"=="" goto badargs
if "%3"=="" goto badargs

set XALAN_HOME=lib/xalan-j_2_7_1
set XALAN_CP=%XALAN_HOME%/xalan.jar;%XALAN_HOME%/serializer.jar;%XALAN_HOME%/xml-apis.jar;%XALAN_HOME%/xercesImpl.jar

java -cp "%XALAN_CP%" org.apache.xalan.xslt.Process -IN %1 -XSL full2flat.xsl -OUT %1.%2.%3.xml -PARAM version %2 -PARAM lang %3

goto done

:badargs

echo ERROR: Bad arguments!
echo Syntax: full2flat ^<IN^> ^<VERSION^> ^<LANG^>
goto done

:done
