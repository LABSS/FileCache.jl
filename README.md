# FileCache

A very small [Julia](https://julialang.org/) utility package for caching the content of files in memory, reloading them only if the file's timestamp has changed since it was last loaded.

To install, from the Julia REPL:

```julia
Pkg.clone("git@github.com:nicolaspayette/FileCache.jl.git")
```

For example, to load a CSV file into a DataFrame, you can use it like this:

```julia
using FileCache
using CSV

df = maybeload(CSV.read, "path/to/my_data.csv")
```

Or, if you want to do something more involved:

```julia
df = maybeload("path/to/my_data.csv") do file
  df = CSV.read(file)
  // ...do some preprocessing on df...
  df
end
```

If you want to force the reloading of a file, an easy way is to alter the timestamp before calling `maybeload`:

```julia
touch("path/to/my_data.csv")
```
