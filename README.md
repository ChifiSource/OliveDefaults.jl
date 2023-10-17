<div align="center">
  <img src="https://github.com/ChifiSource/image_dump/blob/main/olive/olive2defaults.png" width="250">
</div>

###### Some default extensions for the [Olive](https://github.com/ChifiSource/Olive.jl) notebook editor.
---
This package contains a number of default extensions. In order to load a given extension, simply use `using` on the module.
```julia
using OliveDefaults: Styler
```
Add the code above to your `olive.jl` home file after adding `OliveDefaults`, for more information checkout [installing extensions](https://github.com/ChifiSource/Olive.jl#installing-extensions).

---
###### styler
The styler extension allows the end-user to create and load their own stylesheets! This allows for an easy way to customize the way Olive looks, especially when it comes to color.
```julia
using OliveDefaults: Styler
```
###### docbrowser
The docbrowser creates pages of module documentation for every name defined within the current notebook. What this means is that we can browse docstrings in Markdown based on what package they are from.
```julia
using OliveDefaults: DocBrowser
```
###### autocomplete
The autocomplete module does exactly what one might expect -- this package adds autocomplete with spacebar presses.
```julia
using OliveDefaults: AutoComplete
```
