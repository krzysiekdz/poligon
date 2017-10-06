<?php 

class TBSXParserXML 
{
	private static $_init=null;

	private $lexer;

	
	private function __construct() {
		$this->lexer=TBSXLexerXML::init();
	}

	//------------------------ public methods

	public static function init() {
		if(self::$_init != null) return self::$_init;

		self::$_init = new TBSXParserXML;
		return self::$_init;
	}

	//tworzy i zwraca obiekt typu TBSXDocumentXML
	public function parse($file) {
		// $this->forms['binsoft.poligon.okienko']=array('name'=>'BinSoft.Poligon.Okienko','file'=>'modules/krzysiek/forms.xml','xml'=>$xml);
		if(strpos($file, 'krzysiek/forms.xml')==false) return array();
		// echo $file.'<br>';
		$lexems=$this->lexer->lex($file);

		print_r($lexems);

		return array('xmldoc'=>'this is xml doc');
	}	

	

}

?>