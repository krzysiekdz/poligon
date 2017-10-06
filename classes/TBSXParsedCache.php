<?php 

class TBSXParsedCache
{
	private static $_init=null;
	
	private $forms=array();
	private $tables=array();
	private $categories=array();
	private $views=array();
	private $cache_xml=array();

	private $xml_dirty=false;


	private function __construct() {
	}

	private function gatherForms() {
		//przejescie po wszystkich dokuemntach xml w cache_xml i zebranie z nich formularzy
	}

	//-------------------------

	public static function init() {
		if(self::$_init != null) return self::$_init;

		self::$_init = new TBSXParsedCache;
		return self::$_init;
	}

	public function getForms() {
		if($this->xml_dirty){
			$this->gatherForms();
			$this->xml_dirty=false;
		}
		return $this->forms;
	}

	public function getCache() {
		return $this->cache_xml;
	}

	public function saveXmlDoc($doc) {
		$this->xml_dirty=true;
		$this->cache_xml[]=$doc;
	}
}

?>