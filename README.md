AEEincidentsRubyAPI -> NO LONGER WORKS OR BEING MAINTAINED
================

This is a intermediate API, it connects to a Web Service that AEE has and it transforms that ugly XML into a
beautiful JSON for you to work with.
Link: https://aeeapi.herokuapp.com/api/

Requirements
=============
1. Ruby 2.6.0
2. Sinatra
3. Savon
4. or just: **bundle install**

Endpoints
===========

The API has 3 main endpoints, at the moment the app does not serve any HTML or anything like that.

1. This endpoint gives you a list of the pueblos and the number of averia they have at the moment.
	* **localhost:4567/api/lista.json**
2. This endpoint gives you the data for a specific pueblo. Just replace the **comment** for a pueblo.
	* **localhost:4567/api/pueblo_especifico.json?pueblo=HERE_GOES_A_PUEBLO**  
	* Example: **localhost:4567/api/pueblo_especifico.json?pueblo=san juan**.
	* BTW, it can read pueblos with space. Example: aguas buenas, san juan, trujillo alto etc..
3. This endpoint gives you all the pueblos with all the averias and their information. All the information, we can say.
	* **localhost:4567/api/all_averias.json**

Work in Progress
=================
* Web App

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
