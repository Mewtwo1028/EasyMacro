script_name = "Seleccionar Líneas en Mayúsculas"
script_description = "Selecciona todas las líneas que contienen solo letras mayúsculas, incluyendo tildes y alfabeto español"
script_author = "Codeboy1028"
script_version = "1.0"

include("karaskel.lua")

function seleccionar_mayusculas(subs, sel)
    aegisub.progress.task("Seleccionando líneas en mayúsculas...")
    local nuevas_selecciones = {}
    
    for i = 1, #subs do
        local l = subs[i]
        if l.class == "dialogue" then
            -- Comprobamos si el texto contiene solo mayúsculas y caracteres permitidos. 
            --Explicación de las regex:https://cyberzhg.github.io/toolbox/nfa2dfa?regex=XlteYS16w6HDqcOtw7PDusO8w7FdKiQ=     and      https://cyberzhg.github.io/toolbox/nfa2dfa?regex=W0EtWsOBw4nDjcOTw5rDnMORXQ==
            if string.match(l.text, "^[^a-záéíóúüñ]*$") and string.match(l.text, "[A-ZÁÉÍÓÚÜÑ]") then
                table.insert(nuevas_selecciones, i)
            end
        end
    end
    
    if #nuevas_selecciones > 0 then
        aegisub.set_undo_point(script_name)
        return nuevas_selecciones
    else
        aegisub.debug.out("No se encontraron líneas que contengan solo letras mayúsculas.\n")
    end
end

aegisub.register_macro(script_name, script_description, seleccionar_mayusculas)
