#!/usr/bin/env retro

This program generates an HTML index and exports (using the
`export-as-html.forth` example) the samples to HTML. The files
are stored in `/home/crc/public/examples`.

# Configuration

~~~
'/home/crc/public/examples/ 'FILE-PATH s:const
~~~

# Variables

~~~
'FID var
~~~

# Support

This word takes a string and provides a flag of `TRUE` if it
ends in `/`, or `FALSE` otherwise. It leaves the string pointer
on the stack.

~~~
:dir? (s-sf)
  dup s:length over + n:dec fetch $/ eq? ;
~~~

# Words To Create The Index

~~~
:s:put [ @FID file:write ] s:for-each ;
:css   '<style>*{background:#111;color:#fff;font-family:monospace;}</style>
       s:put ;
:dtd   '<!DOCTYPE_html> s:put ;
:title '<title>RETRO_Examples</title> s:put ;
:head  '<head> s:put title css '</head> s:put ;
:li    '<li> s:put call '</li><br>\n s:format s:put ;
:link  dup '<a_href="/examples/%s.html">%s</a>_ s:format s:put ;
:link2 '<a_href="/examples/%s.glossary"><br>&rarr;_glossary</a> s:format s:put
       $. c:put ;
:links [ dup link link2 ] li ;
:body  '<body> s:put call '</body> s:put ;
:make  dtd head body ;
~~~

# Generate index.html

~~~
FILE-PATH 'index.html s:append file:W file:open !FID
[ '<h1>Examples</h1><br><ul> s:put
  [ dir? &drop &links choose ] unix:for-each-file
  '</ul> s:put nl ] make
@FID file:close
~~~

# Generate HTML Files

~~~
:export FILE-PATH over
        './export-as-html.forth_%s_>%s%s.html s:format unix:system $. c:put ;

[ dir? &drop [ export ] choose ] unix:for-each-file nl
~~~

# Generate a Glossary File For Each

~~~
:glossary FILE-PATH over
  'retro-document_%s_>%s%s.glossary s:format unix:system $. c:put ;

[ dir? &drop &glossary choose ] unix:for-each-file
~~~
