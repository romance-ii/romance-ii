/** @license
 * Copyright © 2010 Marcus Westin
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
var store=function () {
    var b= {
    }, e=window, g=e.document, c;
    b.set=function () {
    };
    b.get=function () {
    };
    b.remove=function () {
    };
    b.clear=function () {
    };
    b.transact=function (a, d) {
        var f=b.get (a);
        if (typeof f=="undefined")f= {
        };
        d (f);
        b.set (a, f)};
    b.serialize=function (a) {
        return JSON.stringify (a)};
    b.deserialize=function (a) {
        if (typeof a=="string")return JSON.parse (a)};
    var h;
    try {
        h="localStorage"in e&&e.localStorage}catch (k) {
            h=false}if (h) {
                c=e.localStorage;
                b.set=function (a, d) {
                    c.setItem (a, b.serialize (d))};
                b.get=function (a) {
                    return b.deserialize (c.getItem (a))};

                b.remove=function (a) {
                    c.removeItem (a)};
                b.clear=function () {
                    c.clear ()}}else {
                        var i;
                        try {
                            i="globalStorage"in e&&e.globalStorage&&e.globalStorage[e.location.hostname]}catch (l) {
                                i=false}if (i) {
                                    c=e.globalStorage[e.location.hostname];
                                    b.set=function (a, d) {
                                        c[a]=b.serialize (d)};
                                    b.get=function (a) {
                                        return b.deserialize (c[a]&&c[a].value)};
                                    b.remove=function (a) {
                                        delete c[a]};
                                    b.clear=function () {
                                        for (var a in c)delete c[a]}}else if (g.documentElement.addBehavior) {
                                            c=g.createElement ("div");
                                            e=function (a) {
                                                return function () {
                                                    var d=
                                                        Array.prototype.slice.call (arguments, 0);
                                                    d.unshift (c);
                                                    g.body.appendChild (c);
                                                    c.addBehavior ("#default#userData");
                                                    c.load ("localStorage");
                                                    d=a.apply (b, d);
                                                    g.body.removeChild (c);
                                                    return d}};
                                            b.set=e (function (a, d, f) {
                                                a.setAttribute (d, b.serialize (f));
                                                a.save ("localStorage")});
                                            b.get=e (function (a, d) {
                                                return b.deserialize (a.getAttribute (d))});
                                            b.remove=e (function (a, d) {
                                                a.removeAttribute (d);
                                                a.save ("localStorage")});
                                            b.clear=e (function (a) {
                                                var d=a.XMLDocument.documentElement.attributes;
                                                a.load ("localStorage");
                                                for (var f=0,
                                                     j;
                                                     j=d[f];
                                                     f++)a.removeAttribute (j.name);
                                                a.save ("localStorage")})}}return b} ();