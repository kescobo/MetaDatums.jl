abstract type AbstractMetaDatum{T<:Any} end

struct MetaDatum{T<:Any} <: AbstractMetaDatum{T}
    id::Symbol
    kind::Symbol
    value::T
end

abstract type AbstractMetaData{T} end

struct MetaDict{T} <: AbstractMetaData{T}
    kind::Symbol
    values::Dict{Symbol,MetaDatum{T}}
    links::Set{Symbol}
end

struct MetaDatums{T} <: AbstractMetaData{T}
    metadicts::Dict{Symbol, MetaDict}
    links::Dict{Symbol,Set{Symbol}}}
end

kind(md::AbstractMetaDatum) = md.kind
value(md::AbstractMetaDatum) = md.value
identifier(md::AbstractMetaDatum) = md.id

kind(md::AbstractMetaData) = md.kind
links(md::AbstractMetaData) = md.links

values(md::MetaDict) = values(md.values)
identifiers(md::MetaDict) = keys(md.ids)

values(md::MetaDatums) = Set([values(d.values)... for d in md.metadicts])
identifiers(md::MetaDatums) = Set([keys(d.values)... for d in md.metadicts])
