# FileCache

A very small [Julia](https://julialang.org/) utility package for caching the content of files in memory, reloading them only if the file's timestamp has changed since it was last loaded.

To install, from the Julia REPL:

```julia
Pkg.clone("git@github.com:LABSS/FileCache.jl.git")
```

The package provides a single function:

```julia
maybeload(f::Function, path::AbstractString)
```

If the timestamp of the file designated by `path` has changed since the last time it was called, or if `maybeload` has never been called for this file, it will return the result of `f(path)` and cache that result. If the timestamp has not changed, it will return the cached result.

For example, to load a CSV file into a DataFrame, you can use it like this:

```julia
using FileCache
using CSV

df = maybeload(CSV.read, "path/to/my_data.csv")
```

Or, if you want to do something more involved:

```julia
df = maybeload("path/to/my_data.csv") do path
  df = CSV.read(path)
  # ...do some preprocessing on df...
  df
end
```

If you want to force the reloading of a file, an easy way is to alter the timestamp before calling `maybeload`:

```julia
touch("path/to/my_data.csv")
```
