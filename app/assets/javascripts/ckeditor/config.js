CKEDITOR.editorConfig = function( config )
{
	config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
	config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";
	config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";
	config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
	config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
	config.filebrowserImageUploadUrl = "/ckeditor/pictures?";
	config.filebrowserUploadUrl = "/ckeditor/attachment_files";
	config.allowedContent = true;
	config.filebrowserUploadMethod = 'form';
	config.height = 500;
	config.extraPlugins = '';


	config.toolbar = 'my'

	config.toolbarGroups = [
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
		{ name: 'links', groups: [ 'links' ] },
		{ name: 'insert', groups: [ 'insert' ] },
		'/',
		{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
		{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
		{ name: 'editing', groups: [ 'selection', 'spellchecker', 'find', 'editing' ] },
		{ name: 'forms', groups: [ 'forms' ] },
		{ name: 'styles', groups: [ 'styles' ] },
		{ name: 'colors', groups: [ 'colors' ] },
		{ name: 'tools', groups: [ 'tools' ] },
		{ name: 'others', groups: [ 'others' ] },
	];

	config.removeButtons = 'About,Maximize,ShowBlocks,Print,Form,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,Checkbox,Scayt,Smiley,Flash,Table,HorizontalRule,PageBreak,Iframe,Language,BidiLtr,BidiRtl';
};
