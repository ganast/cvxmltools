:: Copyright © 2013-2015 George Anastassakis (anastas@unipi.gr)
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

if "%1"=="" goto syntax

if not exist "%1.xml" (
	echo ERROR: %1.xml not found!
	goto syntax
)

set XALAN_HOME=lib/xalan-j_2_7_1
set XALAN_CP=%XALAN_HOME%/xalan.jar;%XALAN_HOME%/serializer.jar;%XALAN_HOME%/xml-apis.jar;%XALAN_HOME%/xercesImpl.jar

java -cp "%XALAN_CP%" org.apache.xalan.xslt.Process -IN %1.xml -XSL flat2tex.xsl -OUT %1.tex

goto done

:syntax

echo Syntax: flat2tex ^<IN^>
echo Please supply a filename without an extension, as .XML will be assumed by default.
goto done

:done
