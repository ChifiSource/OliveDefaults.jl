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
module DarkMode
    import Olive: build, OliveModifier
    function build(om::OliveModifier, oe::OliveExtension{:darkmode})

    end
end

module OliveMarkdown
    import Olive: build, OliveModifier
    function build(om::OliveModifier, oe::OliverExtension{:olivemarkdown})

    end
end

module Styler
    import Olive: build, OliveModifier
    function build(om::OliveModifier, oe::OliveExtension{:styler})

    end
end

end # module

{}
