#####
#
# LANGUAGE: CORBA IDL
#

$LANGUAGE{'idl'} = {
    'filename'   => '\\.idl$',
    'regex'      => '',
    'patterns'   => [
        {
            'name'       => 'doc comment',
            'regex'      => '/\\*\\*.*?\\*/',
            'style'      => 'doc comment',
            'childregex' => []
        },
        {
            'name'       => 'comment',
            'regex'      => '/\\*.*?\\*/',
            'style'      => 'comment',
            'childregex' => []
        },
        {
            'name'       => 'cplus comment',
            'regex'      => '//.*?$',
            'style'      => 'comment',
            'childregex' => []
        },
        {
            'name'       => 'preprocessor line',
            'regex'      => '^[ \\t]*#.*?$',
            'style'      => 'preprocessor',
            'childregex' => [
                {
                    'name'       => 'string',
                    'regex'      => '""|".*?([^\\\\](\\\\\\\\)*)"|"\\\\\\\\"',
                    'style'      => 'string',
                    'childregex' => [
                        {
                            'name'       => 'esc character',
                            'regex'      => '\\\\.',
                            'style'      => 'esc character',
                            'childregex' => [] }
                        ] },
                {
                    'name'       => '<files>',
                    'regex'      => '<.*?>',
                    'style'      => 'string',
                    'childregex' => []
                },
                {
                    'name'       => 'comment',
                    'regex'      => '[^/]/\\*.*?\\*/',
                    'style'      => 'comment',
                    'childregex' => []
                } ]
        },
        {
            'name'       => 'keywords',
            'regex'      => '\\b(?i)(module|interface|exception|raises|const|enum|struct|union|switch|case|default|oneway|readonly|attribute|typedef|in|out|inout|sequence|context)\\b',
            'style'      => 'reserved word',
            'childregex' => []
        },
        {
            'name'       => 'predefined types',
            'regex'      => '\\b(?i)(any|void|boolean|char|wchar|float|double|long|unsigned|short|octet|string|fixed)\\b',
            'style'      => 'predefined type',
            'childregex' => []
        },        
        {
            'name'       => 'predefined identifiers',
            'regex'      => '\\b(?i)(CORBA::NamedValue|CORBA::Principal|CORBA::TypeCode)\\b',
            'style'      => 'predefined identifier',
            'childregex' => []
        },        
        {
            'name'       => 'numeric constant',
            'regex'      => '\\b((0(x|X)[0-9a-fA-F]*)|(([0-9]+\\.?[0-9]*)|(\\.[0-9]+))((e|E)(\\+|-)?[0-9]+)?)(L|l|UL|ul|u|U|F|f)?\\b',
            'style'      => 'numeric',
            'childregex' => []
        },
        {
            'name'       => 'braces',
            'regex'      => '[\\{\\}]',
            'style'      => 'braces',
            'childregex' => []
        },
        {
            'name'       => 'symbols',
            'regex'      => '([\\*\\-\\+=:;%&\\|<>\\(\\)\\[\\]!])',
            'style'      => 'symbol',
            'childregex' => []
        },
        { 
            'name'       => 'identifiers',
            'regex'      => '([a-zA-Z_][a-zA-Z_0-9]*)',
            'style'      => 'identifier',
            'childregex' => []
        } ]
};
