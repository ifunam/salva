var teButtons = TextileEditor.buttons;

teButtons.push(new TextileEditorButton('ed_strong',			'bold.png',          '*',   '*',  'b', 'Bold','s'));
teButtons.push(new TextileEditorButton('ed_emphasis',		'italic.png',        '_',   '_',  'i', 'Italicize','s'));
teButtons.push(new TextileEditorButton('ed_underline',	'underline.png',     '+',   '+',  'u', 'Underline','s'));
teButtons.push(new TextileEditorButton('ed_ol',					'list_numbers.png',  ' # ', '\n', ',', 'Numbered List'));
teButtons.push(new TextileEditorButton('ed_ul',					'list_bullets.png',  ' * ', '\n', '.', 'Bulleted List'));
teButtons.push(new TextileEditorButton('ed_h1',					'h1.png',            'h1',  '\n', '1', 'Header 1'));
teButtons.push(new TextileEditorButton('ed_h2',					'h2.png',            'h2',  '\n', '2', 'Header 2'));
teButtons.push(new TextileEditorButton('ed_h3',					'h3.png',            'h3',  '\n', '3', 'Header 3'));
teButtons.push(new TextileEditorButton('ed_h4',					'h4.png',            'h4',  '\n', '4', 'Header 4'));

// teButtons.push(new TextileEditorButton('ed_code','code','@','@','c','Code'));