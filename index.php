<?php
include_once('classes/bootstrap.php');

$app=TBSXParser::init();
$app->addDirectory('modules');
// $app->addDirectory('BinSoft.Services');
// $app->addDirectory('BinSoft.Mail');
$app->parseAll();
// print_r($app->getCache()->getCache());
 
 // $form=$app->openForm('BinSoft.krzysiek.okienko');
 // echo $form->render();




 
?>

<!DOCTYPE HTML>
<html>

<head>
<!-- Basic Page Needs
  ================================================== -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>BSXForms</title>
<meta name="author" content="Binsoft">
<base href="/" />

<!-- CSS
  ================================================== -->
<link href="assets/css/bootstrap.css" rel="stylesheet" type="text/css">


</head>

<body>

<div class="jumbotron">
  <h2>hello</h2>
</div>


</body>



</html>