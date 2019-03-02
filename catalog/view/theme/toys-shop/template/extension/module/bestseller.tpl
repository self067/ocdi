
<section class="about py-lg-4 py-md-3 py-sm-3 py-3" id="about">
         <div class="container py-lg-5 py-md-5 py-sm-4 py-4">
            <h3 class="title text-center mb-lg-5 mb-md-4  mb-sm-4 mb-3"><?php echo $heading_title; ?></h3>
            <div class="row banner-below-w3l">

						<?php foreach ($products as $product) { ?>



						<div class="col-lg-4 col-md-6 col-sm-6 text-center banner-agile-flowers">
                  <img src="<?php echo $product['thumb']; ?>" class="img-thumbnail" alt="">
                  <div class="banner-right-icon">
                     <h4 class="pt-3"><?php echo $product['name']; ?></h4>
                  </div>
               </div>

						 <?php } ?>


							 <div class="toys-grids-upper">
                  <div class="about-toys-off">
                     <h2>Get Up to <span>70% Off </span>On Selected Toys</h2>
                  </div>
               </div>
            </div>
         </div>
      </section>
