CKEDITOR.editorConfig = function (config) {
    config.extraPlugins = 'imgur', 'confighelper';
    config.imgurClientID = '9bbd541c8fdec24';


    config.toolbarGroups = [
        { name: 'document',    groups: [ 'mode', 'document', 'doctools' ] },
        { name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
        { name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
        { name: 'links' },
        { name: 'insert' },
        { name: 'about' },
        '/',
        { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
        { name: 'colors' },
        { name: 'styles' },
        { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align' ] }
    ];


    config.toolbar_comment = [
        [ 'Bold', 'Italic', '-', 'NumberedList', 'BulletedList', 'Outdent', 'Indent', 'Blockquote', '-' ]
    ];
};