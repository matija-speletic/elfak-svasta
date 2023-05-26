<?php
 if (isset($_GET['registrovan'])) {
 $kolicina=$_GET['kolicina'];
 $factor=1;
 if($kolicina<10)
	 $factor=2;
 $price=rand(10,50);
 $price=$price*$factor;
 echo $price;
 }else{
	echo "Korisnik nije registrovan";	
 }
?>
