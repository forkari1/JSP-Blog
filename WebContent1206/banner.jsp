<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="mainlayout.css" />
	<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
			var slideIndex = 1;
	        
	        $(document).ready( function(){
	            showDivs(slideIndex);
	        });
	        
	        function plusDivs(n) 
	        {
	            showDivs(slideIndex += n);
	        }
	
	        function showDivs(n) 
	        {
	            var i;
	            var x = document.getElementsByClassName("mySlides");
	            if (n > x.length) {slideIndex = 1} 
	            if (n < 1) {slideIndex = x.length} ;
	            for (i = 0; i < x.length; i++) {
	                x[i].style.display = "none";
	                
	            }
	            x[slideIndex-1].style.display = "block";
	            x[slideIndex-1].style.animation = "opac 0.8s"; 
	        }		
      </script>
</head>
	<body>
		<section>
			<div class="main_img_wrap">
				<div class="display_container">
					<a href="#"><img class="mySlides" src="images/header-image-bg.jpg"></a>
				</div>
			</div>
		</section>
	</body>
</html>