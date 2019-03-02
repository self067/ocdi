<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
     
<!-- <meta name="keywords" content="Toys Shop Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
         Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" /> -->

<meta property="og:title" content="<?php echo $title; ?>" />
<meta property="og:type" content="website" />
<meta property="og:url" content="<?php echo $og_url; ?>" />
<?php if ($og_image) { ?>
<meta property="og:image" content="<?php echo $og_image; ?>" />
<?php } else { ?>
<meta property="og:image" content="<?php echo $logo; ?>" />
<?php } ?>
<meta property="og:site_name" content="<?php echo $name; ?>" />


<script src='catalog/view/theme/toys-shop/js/jquery-2.2.3.min.js'></script>
<script src='catalog/view/theme/toys-shop/js/popper.js'></script>
<!-- ??????????? -->
<!-- <link href="catalog/view/theme/toys-shop/css/stylesheet.css" rel="stylesheet"> -->
	<!--booststrap-->
	<link href="catalog/view/theme/toys-shop/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all">
	<!--//booststrap end-->
	<!-- font-awesome icons -->
	<link href="catalog/view/theme/toys-shop/css/fontawesome-all.min.css" rel="stylesheet" type="text/css" media="all">
	<!-- //font-awesome icons -->
	<!-- For Clients slider -->
	<link rel="stylesheet" href="catalog/view/theme/toys-shop/css/flexslider.css" type="text/css" media="all" />
	<!--flexs slider-->
	<!-- <link href="catalog/view/theme/toys-shop/css/JiSlider.css" rel="stylesheet"> -->

	<link rel="stylesheet" type="text/css" href="catalog/view/theme/toys-shop/css/jquery-ui1.css">
  <link href="catalog/view/theme/toys-shop/css/easy-responsive-tabs.css" rel='stylesheet' type='text/css' />
  <link rel="stylesheet" href="catalog/view/theme/toys-shop/css/flexslider.css" type="text/css" media="screen" />



	<link href="//fonts.googleapis.com/css?family=Sunflower:500,700" rel="stylesheet">
	<link href="//fonts.googleapis.com/css?family=Open+Sans:400,600,700" rel="stylesheet">


<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script src="catalog/view/theme/toys-shop/js/common.js" type="text/javascript"></script>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
<?php echo $analytic; ?>
<?php } ?>


	<script>
			addEventListener("load", function () {
			setTimeout(hideURLbar, 0);
			}, false);
			
			function hideURLbar() {
			window.scrollTo(0, 1);
			}
	</script>
	<!--//meta tags ends here-->
	<!--Shoping cart-->
	<link rel="stylesheet" href="catalog/view/theme/toys-shop/css/shop.css" type="text/css" />
	<!--//Shoping cart-->
	<!--//Shoping cart-->
	<!--stylesheets-->
	<link href="catalog/view/theme/toys-shop/css/style.css" rel='stylesheet' type='text/css' media="all">
	<!--//stylesheets-->
	<link href="catalog/view/theme/toys-shop/css/style-di.css" rel='stylesheet' type='text/css' media="all">

</head>
<body class="<?php echo $class; ?>">

<?php 
  $path = "common/home";
  $url = $_SERVER['REQUEST_URI'];
  if ($url == "/" or strripos($url, $path) or strripos($url, "ocdi/#")){// or $url == $baseURI ) {
    $is_home = true;
  }else{
    $is_home = false;
  }            
?>

<div class="header-outs" id="home">
         <div class="header-bar">
            <div class="info-top-grid">
               <div class="info-contact-agile">
                  <ul>
                     <li>
                        <span class="fas fa-phone-volume"></span>
                        <p><?php echo $telephone; ?></p>
                     </li>
                     <li>
                        <span class="fas fa-envelope"></span>
                        <p><a href="<?php echo $email; ?>"><?php echo $email; ?></a></p>
                     </li>
                     <li>
                     </li>
                  </ul>
               </div>
						</div>
						
            <div class="container-fluid">
               <div class="hedder-up row">
                  <div class="col-lg-3 col-md-3 logo-head">
                     <h1><a class="navbar-brand" href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
                  </div>
                  <div class="col-lg-5 col-md-6 search-right">
                     <form class="form-inline my-lg-0">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search">
                        <button class="btn" type="submit">Search</button>
                     </form>
                  </div>
                  <div class="col-lg-4 col-md-3 right-side-cart">
                     <div class="cart-icons">
                        <ul>
                           <li>
                              <span class="far fa-heart"></span>
                           </li>
                           <li>
                              <button type="button" data-toggle="modal" data-target="#exampleModal"> <span class="far fa-user"></span></button>
													 </li>
													 

													 <!-- <li class="toyscart toyscart2 cart cart box_1"> -->
													 <?php echo $cart; ?>
													 <!-- </li> -->


                        </ul>
                     </div>
                  </div>
               </div>
						</div>
						
            <nav class="navbar navbar-expand-lg navbar-light">
               <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
               <span class="navbar-toggler-icon"></span>
               </button>
               <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
                  <ul class="navbar-nav ">
                     <li class="nav-item active">
                        <a class="nav-link" href="<?php echo $home; ?>">Home <span class="sr-only">(current)</span></a>
                     </li>
                     <li class="nav-item">
                        <a href="<?php echo $about; ?>" class="nav-link">About</a>
                     </li>
                     <li class="nav-item">
                        <a href="<?php echo $service;?>" class="nav-link">Service</a>
                     </li>
                     <li class="nav-item">
                        <a href="<?php echo $categories[0]['href']; ?>" class="nav-link">Shop Now</a>
                     </li>
                     <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Pages
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                           <a class="nav-link" href="icon.html">404 Page</a>
                           <a class="nav-link " href="typography.html">Typography</a>
                        </div>
                     </li>
                     <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Product
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
													<?php foreach( $categories as $cat) { ?>
														<a class="nav-link" href="<?php echo $cat['href'];?>">
															<?php echo $cat['name'];?>
														</a>
													<?php } ?>
												

                        </div>
                     </li>
                     <li class="nav-item">
                        <a href="<?php echo $contact; ?>" class="nav-link">Contact</a>
                     </li>
                  </ul>
               </div>
            </nav>
         </div>


				 <?php if (!$is_home) { ?>
      <!-- banner -->
      <div class="inner_page-banner one-img">
      </div>
      <!--//banner -->
      <!-- short -->
      <div class="using-border py-3">
         <div class="inner_breadcrumb  ml-4">
            <ul class="short_ls">
               <li>
                  <a href="index.html">Home</a>
                  <span>/ /</span>
               </li>
               <li>Products</li>
            </ul>
         </div>
      </div>
      <!-- //short-->
	
		<?php } ?>

