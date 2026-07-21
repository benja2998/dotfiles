local lexers = vis.lexers

-- Base layout
lexers.STYLE_DEFAULT = 'fore:white'
lexers.STYLE_NOTHING = ''
lexers.STYLE_WHITESPACE = ''

-- Syntax highlighting
lexers.STYLE_CLASS = 'fore:yellow,bold'
lexers.STYLE_COMMENT = 'fore:blue,bold' 
lexers.STYLE_CONSTANT = 'fore:red'
lexers.STYLE_DEFINITION = 'fore:cyan'
lexers.STYLE_ERROR = 'fore:white,back:red'
lexers.STYLE_FUNCTION = 'fore:cyan'
lexers.STYLE_IDENTIFIER = 'fore:white'
lexers.STYLE_KEYWORD = 'fore:magenta'
lexers.STYLE_LABEL = 'fore:yellow'
lexers.STYLE_NUMBER = 'fore:red'
lexers.STYLE_OPERATOR = 'fore:red'
lexers.STYLE_PREPROCESSOR = 'fore:yellow'
lexers.STYLE_REGEX = 'fore:magenta,bold'
lexers.STYLE_STRING = 'fore:red'
lexers.STYLE_TAG = 'fore:cyan'
lexers.STYLE_TYPE = 'fore:yellow'
lexers.STYLE_VARIABLE = 'fore:white'
lexers.STYLE_EMBEDDED = 'back:black'

-- Vis UI Elements
lexers.STYLE_LINENUMBER = 'fore:red'
lexers.STYLE_CURSOR = 'fore:black,back:white'
lexers.STYLE_CURSOR_PRIMARY = 'fore:black,back:white'
lexers.STYLE_CURSOR_LINE = 'back:black'
lexers.STYLE_COLOR_COLUMN = 'back:black'
lexers.STYLE_SELECTION = 'back:blue'
lexers.STYLE_STATUS = 'fore:black,back:white'
lexers.STYLE_STATUS_FOCUSED = 'fore:whitte,back:red'
lexers.STYLE_SEPARATOR = 'fore:blue'
lexers.STYLE_INFO = 'fore:red'
lexers.STYLE_EOF = 'fore:blue'
