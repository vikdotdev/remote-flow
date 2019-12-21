//= require account/ransack-datepicker
//= require account/hide_organization_dropdown
//= require_self

CKEDITOR.editorConfig = function( config ) {
	config.toolbar_mini = [

	config.filebrowserBrowseUrl = "/ckeditor/attachment_files",
	config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files",
	config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files",
	config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures",
	config.filebrowserImageBrowseUrl = "/ckeditor/pictures",
	config.filebrowserImageUploadUrl = "/ckeditor/pictures",
	config.filebrowserUploadUrl = "/ckeditor/attachment_files",
	config.filebrowserUploadMethod = 'form',
	config.allowedContent = true,

	{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
	{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
	{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
	{ name: 'forms', groups: [ 'forms' ] },
	{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
	'/',
	{ name: 'links', groups: [ 'links' ] },
	{ name: 'insert', groups: [ 'insert' ] },
	{ name: 'styles', groups: [ 'styles' ] },
	{ name: 'colors', groups: [ 'colors' ] },
	{ name: 'tools', groups: [ 'tools' ] },
	{ name: 'others', groups: [ 'others' ] },
	{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
	];
	config.toolbar = "mini";
	config.height = 500;
};
