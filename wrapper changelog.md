# MES Colour Wrapper Changelog

v1.3:
* Code cleanup
* Added new function; term.isColor() now returns true and should make 100% of games at least *boot*

v1.2:
* Added support for term.getBackgroundColour and term.getTextColour, adding backwards compatibility with 1.74 games, assuming there's no other issues [eg mouse or bugs]

v1.1:
* Added setVisible() support, increasing compatibility - setVisible() is often used in games to reduce or eliminate flicker

v1.0:
* Original release, converts colours to black and white
