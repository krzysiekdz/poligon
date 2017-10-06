<?php 

class TBSXElementXML
{
	private $tag_name; //nazwa znacznika 
	private $attrs=array(); //atrybuty-tablica asocjacyjna
	private $children=array(); //tablica elementów typu TBSX_XMLElement
	private $text_value=null;//jesli ustawione jest text_value to jest to wezel tekstowy
}

?>