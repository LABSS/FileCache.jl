module FileCache

  export maybeload

  type CachedFile
    mtime::Float64
    content::Any
  end

  const cache = Dict{String, Any}()

  function maybeload(f::Function, path::AbstractString)
    p = realpath(path)
    if !(haskey(cache, p) && mtime(p) == cache[p].mtime)
      cache[p] = CachedFile(mtime(p), f(p))
    end
    cache[p].content
  end

end # module
