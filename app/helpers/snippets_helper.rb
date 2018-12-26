module SnippetsHelper
    def translate_extention_to_mime_type(extension)
        if extension == 'php'
            "text/x-php"
        elsif extension == 'js'
            "text/javascript"
        elsif extension == 'rb'
            "text/x-ruby"
        elsif extension == 'erb'
            'application/x-erb'
        else 
            "text/plain"
        end        
    end
end
