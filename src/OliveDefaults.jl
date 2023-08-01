module OliveDefaults
using Olive
using Toolips
using ToolipsSession
using ToolipsMarkdown
import Olive: OliveExtension, build

module Styler
    using Olive
    import Olive: build, OliveModifier, OliveExtension
    using ToolipsSession
    using Toolips
    function olivesheetdark()
        st = Olive.ToolipsDefaults.sheet("olivestyle", dark = true)
        bdy = Style("body", "background-color" => "#360C1F", "transition" => ".8s")
        st[:children]["div"]["background-color"] = "#DB3080"
        st[:children]["div"]["color"] = "white"
        st[:children]["p"]["color"] = "white"
        st[:children]["h1"]["color"] = "orange"
        st[:children]["h2"]["color"] = "lightblue"
        ipc = Olive.inputcell_style()
        ipc["background-color"] = "#DABCDF"
        ipc["border-width"] = 0px
        push!(st, Olive.google_icons(),
        Olive.iconstyle(), Olive.cellnumber_style(), Olive.hdeps_style(),
        Olive.usingcell_style(), Olive.outputcell_style(), ipc, bdy, Olive.ipy_style(),
        Olive.hidden_style(), Olive.jl_style(), Olive.toml_style())
        st
    end

    function build(c::Connection, om::OliveModifier, oe::OliveExtension{:styler})
        if ~(:stylesheet in keys(om.data))
            om[:stylesheet] = olivesheetdark()
        end
        set_children!(om, "olivestyle", om[:stylesheet][:children])
    end
end # module Styler

module DocBrowser
using Olive
using Olive: getname, Project, build_tab, open_project
import Olive: build

function build(c::Connection, cm::ComponentModifier, cell::Cell{:docmodule},
    cells::Vector{Cell}, proj::Project{<:Any})
    mainbox::Component{:section} = section("cellcontainer$(cell.id)")
    n::Vector{Symbol} = names(cell.outputs, all = true)
    remove::Vector{Symbol} =  [Symbol("#eval"), Symbol("#include"), :eval, :example, :include, Symbol(string(cell.outputs))]
    filter!(x -> ~(x in remove) && ~(contains(string(x), "#")), n)
    selectorbuttons::Vector{Servable} = [begin
        docdiv = div("doc$name", text = string(name))
        on(c, docdiv, "click") do cm2::ComponentModifier
            exp = Meta.parse("""t = eval(Meta.parse("$name")); @doc(t)""")
            docs = cell.outputs.eval(exp)
            docum = tmd("docs$name", string(docs))
            append!(cm2, docdiv, docum)
        end
        docdiv
    end for name in n]
    mainbox[:children] = vcat([h("$(cell.outputs)", 2, text = string(cell.outputs))], selectorbuttons)
    mainbox
end

build(c::Connection, om::OliveModifier, oe::OliveExtension{:docbrowser}) = begin
    explorericon = topbar_icon("docico", "newspaper")
    on(c, explorericon, "click") do cm::ComponentModifier
        mods = [begin 
            if :mod in keys(p.data)
                p.data[:mod]
            else
                nothing
            end
        end for p in c[:OliveCore].open[getname(c)].projects]
        filter!(x::Any -> ~(isnothing(x)), mods)
        push!(mods, Olive, olive)
        cells = Vector{Cell}([Cell(e, "docmodule", "", mod) for (e, mod) in enumerate(mods)])
        home_direc = Directory(c[:OliveCore].data["home"])
        projdict::Dict{Symbol, Any} = Dict{Symbol, Any}(:cells => cells,
        :path => home_direc.uri, :env => home_direc.uri)
        myproj::Project{:doc} = Project{:doc}(home_direc.uri, projdict)
        push!(c[:OliveCore].open[getname(c)].projects, myproj)
        tab::Component{:div} = build_tab(c, "documentation")
        open_project(c, om, proj, tab)
    end
    insert!(om, "rightmenu", 1, explorericon)
end
end # module DocBrowser

module AutoComplete

end # module AutoComplete

end # module
