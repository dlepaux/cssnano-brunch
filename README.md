cssnano-brunch
===============

A [Brunch][] plugin witch optimize with [CSSNano][]

Installation
-------

`npm install --save cssnano-brunch`

Exemple
-------
Before
```css
h1::before, h1:before {
    margin: 10px 20px 10px 20px;
    color: #ff0000;
    -webkit-border-radius: 16px;
    border-radius: 16px;
    font-weight: normal;
    font-weight: normal;
}
/* invalid placement */
@charset "utf-8";
```
After
```css
@charset "utf-8";h1:before{margin:10px 20px;color:red;border-radius:1pc;font-weight:400}
```

License
-------

MIT

[Brunch]: http://brunch.io
[CSSNano]: http://cssnano.co