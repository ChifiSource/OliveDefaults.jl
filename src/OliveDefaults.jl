module OliveDefaults
using Olive
using Toolips
using ToolipsSession
using ToolipsMarkdown
import Olive: OliveExtension, build
#==
function dark_mode(c::Connection)
    darkicon::Component{:span} = topbar_icon("darkico", "dark_mode")
    on(c, darkicon, "click") do cm::ComponentModifier
        if cm["olivestyle"]["dark"] == "false"
            set_text!(cm, darkicon, "light_mode")
            set_children!(cm, "olivestyle", olivesheetdark()[:children])
            cm["olivestyle"] = "dark" => "true"
        else
            set_text!(cm, darkicon, "dark_mode")
            set_children!(cm, "olivestyle", olivesheet()[:children])
            cm["olivestyle"] = "dark" => "false"
        end
    end
    OliveExtension{:topbar}([darkicon])
end
==#

module OliveMarkdown
    import Olive: build, OliveModifier
end

module Styler
    using Olive
    import Olive: build, OliveModifier
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

    function build(om::OliveModifier, oe::OliveExtension{:styler})
        if ~(:stylesheet in keys(om.data))
            om[:stylesheet] = olivesheetdark()
        end
        set_children!(om, "olivestyle", om[:stylesheet][:children])
    end
end

end # module
