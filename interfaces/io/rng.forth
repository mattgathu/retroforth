~~~
{{
  :random:byte 
    '/dev/urandom file:R file:open
    &file:read sip file:close ;
---reveal---
  :n:random
    random:byte   #-8 shift
    random:byte + #-8 shift
    random:byte + #8 shift
    random:byte + ;
}}
~~~
