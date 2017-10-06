<?php


class TBSXParser {
	private static $_init=null;

	private $directories=array();
	private $files=array();
	private $parserXml;
	private $parsedCache;
	
	private function __construct() {
		$this->parserXml=TBSXParserXML::init();
		$this->parsedCache=TBSXParsedCache::init();
	}

	//parsowanie pliku
	private  function parseFile($file, $path) {
		// echo 'file: '.$path.'/'.$file.'<br>';
		$file = $path.'/'.$file;
		$ext=$this->addFileToList($file, array('xml'));
		//parsujemy-plik xml
		if($ext=='xml') $this->parsedCache->saveXmlDoc($this->parserXml->parse($file));
	}

	//funkcja dodaje do $this->files pliki o okreslonym typie, domyslnie dodaje kazdy; zwraca typ dodanego pliku w przypadku gdy wymagano typu
	private function addFileToList($file, $types=array()) {
		if(count($types)==0 || $types[0]=='') {
			$this->files[]=$file;
			return '';
		}
		else {
			$ext=pathinfo($file, PATHINFO_EXTENSION);
			if(in_array($ext, $types)) $this->files[]=$file;
			return $ext;
		}
	}
	
	private function parseDirectory($dir, $prev_path) {
		$actual_path=$prev_path.'/'.$dir;
		$elements=scandir($prev_path.'/'.$dir);
		foreach($elements as $el) {
			if($el=='.' || $el=='..') continue;
			if(is_file($actual_path.'/'.$el)) {
				$this->parseFile($el, $actual_path);
			} else if (is_dir($actual_path.'/'.$el)) {
				// echo 'dir: '.$el.'<br>';
				$this->parseDirectory($el, $actual_path);
			}
		}
	}
	
	//========================================================================
	
	public static function init() {
		if(self::$_init != null) return self::$_init;

		self::$_init = new TBSXParser;
		return self::$_init;
	}

	public function parseAll() {
		foreach ($this->directories as $dir)
		  $this->parseDirectory($dir, APPPATH);
	}
	
	public function openForm($form) {
		// if (!isset($this->forms[strtolower($form)])) 
		// {
		// 	//szukanie zaawansowane
		// 	foreach ($this->forms as $name=>$value)
		// 	    if (strpos($form,'.'.$name)!==FALSE) return $this->openForm($name);
		// 	return false;
		// }
		// $f=$this->forms[strtolower($form)];
	}

	public function addDirectory($dirname) {
		$this->directories[]=$dirname;
	}

	public function getFiles() {
		return $this->files;
	}

	public function getCache(){
		return $this->parsedCache;
	}
	
}

?>