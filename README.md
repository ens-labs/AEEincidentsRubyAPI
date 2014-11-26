AEEincidentsRubyAPI
================

This is a intermediate API, it connects to a Web Service that AEE has and it transforms that ugly XML into a 
beautiful JSON for you to work with.

Requirements
=============
1. Ruby 1.9.3
2. Sinatra
3. Savon
4. or just: **bundle install**

Endpoints
===========

The API has 3 main endpoints, at the moment the app does not serve any HTML or anything like that.

1. The first one is: **localhost:4567/api/lista.json**, this endpoints gives you a list of the pueblos with data at the moment.
2. The second one is: **localhost:4567/api/pueblo_especifico.json?pueblo=HERE_GOES_A_PUEBLO**, this endpoints gives you the data 
for a specific pueblo. Just replace the text for a pueblo. Example: **localhost:4567/api/pueblo_especifico.json?pueblo=san juan**. BTW, it can read pueblos with space. Example: aguas buenas, san juan, trujillo alto etc..
3. The Third one is: **localhost:4567/api/all_averias.json**, this endpoint gives you all the pueblos with all the averias. All the information, we can say.

Work in Progress
=================
The endpoint **localhost:4567/api/pueblo_especifico.json** needs some organization with the data, so Work in progress.


License
============
The MIT License (MIT)

Copyright (c) 2014 Daniel Del Río

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.