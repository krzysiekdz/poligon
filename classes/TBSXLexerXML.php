<?php 

define('START_TAG', '<xyz');//znacznik czyli znaki typu <ident tzn musi pojawic sie znak "<" po czym od razu (bez spacji) typ IDENT- takie cos uznajemy jako START_TAG
define('CLOSE_START_TAG', '>'); //znacznik zamykajacy START_TAG (nie ma przypadku dla znacznika zamykajacego END_TAG - tam od razu biore calosc jako END_TAG)
define('END_TAG', '</xyz> OR />');//koncowy znacznik - moze byc w postaci </xyz> lub /> ; poprawne jest jesli </xyz A> , A-dowolna liczba znakow bialych, A-nie moze byc {IDENT}* (uproszczenie)
define('SLASH', '/');
define('IDENT', 'ident');//a-zA-Z0-9 -_: na przyklad a-b-c_ab:c34, nie moza zaczynac sie od cyfry; nie moze byc polskim znakiem
define('STRING', 'string');//wszystkie znaki ktore sa miedzy cudzyslowami "..."; cudzyslow moze byc pojedynczy lub podwojny; wyjatki: &<>
define('EQ', '=');
define('ESCAPE_CHARACTER', '&IDENT;');//np: &lt; &gt; &amp; czyli &IDENT;
define('NUMBER', 'number');//0-9, nie ma spejcalnie znaczenia ale wydzielam taki typ
define('COMMENT', 'comment');// sekwencja 4 znakow <!-- po czym dowolna tresc i 3 znaki konczace komentarz --> 
define('OTHER', 'other');//np: !@#$%^&*()+?

$esc_chars=array('amp'=>'&','lt'=>'<','gt'=>'>');

class TBSXLexerXML 
{
	private static $_init=null;
	
	private $lexems=array();
	private $pos=0;
	private $file_buff;
	private $size;
	private $lineNo=0;

	private function __construct() {
	}

	//---------------- getSomething functions

	private function getStartOrEndToken() {
		$token='<';
		$this->pos++;
		if($this->pos < $this->size) {
			$ch=$this->file_buff[$this->pos];
			if(!($this->isIdent($ch)) || !($ch=='/')) throw new Exception('<br>Błąd w lini '.$this->lineNo.'. Znacznik xml niepoprawnie napisany-złe otwarcie lub zamkniecie<br>');
		} else {
			throw new Exception('<br>Błąd w lini '.$this->lineNo.'. Znacznik xml niepoprawnie napisany-złe otwarcie lub zamkniecie<br>');
		}
		

		while($this->pos < $this->size) {
			$ch=$this->file_buff[$this->pos];
			if($this->isIdent($ch) || $ch=='/')
		}
	}


	//----------------- isSomething functions

	private function isStartTag($ch) {
		return $ch=='<';
	}

	//pierwszy znak na jaki moze rozpoczyna sie identyfikator
	private function isIdent($ch) {
		return preg_match('/^[a-zA-Z_]$/', $ch);
	}

	//znaki kolejne, jakie moze zawierac identyfikator
	private function isIdentNext($ch) {
		return preg_match('/^[a-zA-Z0-9:_-]$/', $ch);
	}

	private function isNewLine($ch) {
		return $ch=='\n';
	}

	//------------------------ public methods

	public static function init() {
		if(self::$_init != null) return self::$_init;

		self::$_init = new TBSXLexerXML;
		return self::$_init;
	}

	//analiza leksykalna, czyli sprawdzanie jakie elementy zawiera dokument i wydzielanie ich jako oddzielne typy (leksemy); zwracana jest tablica tzw. leksemów
	public function lex($file) {
		$this->lexems=array();
		$this->pos=0;
		$this->file_buff=file_get_contents($file);
		$this->size=filesize($file);
		
		// wypisywanie bajtow znakow
		// while($this->pos < $this->size) {
		// 	echo ord($this->file_buff[$this->pos]).'___';
		// 	$this->pos++;
		// }

		while($this->pos < $this->size) {
			$ch=$this->file_buff[$this->pos];

			if($this->isStartTag($ch)) {
				$this->getStartOrEndToken();
			} else if ($this->isNewLine($ch)) {
				$this->lineNo++;
			}
			else {
				$this->pos++;	
			}
		}

		// print_r($this->isIdentNext(' '));

		// var_dump(preg_match('/^[a-zA-Z_]$/', '_'));

		return $this->lexems;
	}





}

?>