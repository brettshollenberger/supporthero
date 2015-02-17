ERIS FRAMEWORK
==============


##About
Eris Framework is meant to be a mobile first, ultra-lightweight CSS framework. The personal reason for creating another CSS Framework is that I was unhappy at naming, bloat, and the cheap look brought on by typically used frameworks. I wanted to create something style agnostic and small. The technical goal of the project is to create something that fits within the first few packets of a TLS connection on a mobile device - 14kb or so. This is so the client can have something that has at least structure as the rest of the styles are loaded in and packet size increases.

Eris is broken up into two parts - Eris Core and Eris Angular. Include
the packages you'd like to use in your dependancy compiler and it should
be good to go. You can add Eris Angular to your project by including the
module Eris.Framework.

##Grid

As with many other framework Eris works of a 12 column grid layout. Grids can be created using the `col-lg-*` or `col-sm-*` classes. The syntax is pretty similar to Bootstrap as it is succinct and
meaningful. 

For instance you can create columns in ways similar to this:

    .col-sm-12
    .col-sm-4
    .col-lg-12
    .col-lg-4
    .col-lg-12.col-sm-4

The small breakpoint starts at 640px and can be adjusted by
changing the `$small-breakpoint` variable. I've opted not to use
floating in Eris as this creates a lot of randon pseudo elements and
clearfixing - which would cause pages to insert items in to the
nodelist. Instead I've chosen to use a font with no character widths and
a font-size of 0 on row elements as a backup. I'm still trying out how
this works in the wild but will see.

##Buttons

Buttons can be created using the `.btn-*-*` class - where * could be one of the following identifiers:
    
    warning
    success
    error

Sizes can be controlled using the following class additions:

    full
    large
    small

For example you can create a button in any of these fashions:

    .btn
    .btn-large
    .btn-success-large
    .btn-success-small
    .btn-warning
    .btn-full
    .btn-warning-full

##Typography
Typography is an important part of any site. In Eris it is set up as
percentages based on the parent element - the margins underneath follow
this rule as well. 

##Forms
Forms received the same minimal styling as buttons and the typography.
The main things that were adjusted were sizes of input so they match
their counterparts. So for instance `.btn-small` would technically be the same size as `input[type=text].small`

## Future Plans

Need to implement a CSS debugger to detect bad style.
- Detect Rows within rows
- Detect columns adding to more than twelve
- Detect Unclosed divs?
