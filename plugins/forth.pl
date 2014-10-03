#####
#
# LANGUAGE: FORTH
#

$LANGUAGE{'forth'} = {
    'filename'   => '\\.fs$',
    'regex'      => '',
    'patterns'   => [
        {
            'name'       => 'single line comment',
            'regex'      => '\\\.*?$',
            'style'      => 'comment',
            'childregex' => []
        },
        {
            'name'       => 'comment',
            'regex'      => '\( .*?\)',
            'style'      => 'doc comment',
            'childregex' => []
        },
        {
            'name'       => 'keywords',
            'regex'      => '\\b(?i)(cr|spaces|space|emit|\.|u\.r|page|swap|over|dup|rot|drop|2swap|2dup|2over|2drop|\?dup|and|or|abort|use|list|load|update|empty-buffers|block|include|marker|leave|exit|quit|constant|variable|create|\!|\@|\?|\+\!|allot|\,|fill|base|2variable|2constant|dump|erase|c\,|2\,|\'|execute|evaluate|type|trailing|move|cmove|key|accept|word|\>number|count|compare|blank|does\>|immediate|postpone|literal)\\b',
            'style'      => 'reserved word',
            'childregex' => []
        },
        {
            'name'       => 'predefined types',
            'regex'      => '\\b(?i)(:|;|\+|-|\*|\/|mod|\/mod|1\+|1-|2\*|2\/|2-|2\+|\>r|r\>|i|r@|j|\*/|\*/mod|hex|octal|decimal)\\b',
            'style'      => 'predefined type',
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
            'regex'      => '\\b(?i)(:|;|if|else|then|do|loop|\+loop|begin|while|until|repeat)\\b',
            'style'      => 'braces',
            'childregex' => []
        },
        {
            'name'       => 'symbols',
            'regex'      => '\\b(?i)(=|<|>|<=|>=|0=|<>|0<|0>|0<>|abs|negate|min|max)\\b',
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
