port module Pastor.Ports exposing (..)

-- port for sending strings out to JavaScript
-- in this case the content asciidoc text to asciidoctor.js
port adoc_in : String -> Cmd msg


-- port for listening for suggestions from JavaScript
-- after asciidoctor.js finishes, this port awaits the compiled html
port adoc_out : (String -> msg) -> Sub msg
