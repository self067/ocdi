<?php echo $header; ?>

      <!--show Now-->  
      <section class="contact py-lg-4 py-md-3 py-sm-3 py-3">
         <div class="container-fluid py-lg-5 py-md-4 py-sm-4 py-3">
            <h3 class="title text-center mb-lg-5 mb-md-4 mb-sm-4 mb-3"><?php echo $heading_title; ?></h3>
            <div class="row">
              <div class="left-ads-display col-lg-12">
								<?php if ($products) { ?>
									<div class="row">
      							<?php foreach ($products as $product) { ?>



                     <div class="col-lg-4 col-md-6 col-sm-6 product-men women_two">
                        <div class="product-toys-info">
                           <div class="men-pro-item">
                              <div class="men-thumb-item">
                                 <img src="<?php echo $product['thumb']; ?>" class="img-thumbnail img-fluid" alt="<?php echo $product['name']; ?>">
                                 <div class="men-cart-pro">
                                    <div class="inner-men-cart-pro">
                                       <a href="<?php echo $product['href']; ?>" class="link-product-add-cart">Quick View</a>
                                    </div>
                                 </div>
                                 <span class="product-new-top">New</span>
<!-- //??? -->
																<!-- <?php if ($product['special']) { ?>
																	<div class="flag-sale_wrap">
																		<span class="flag-sale"><?php echo "SALE";?></span>
																	</div>
																<?php } ?> -->

                              </div>
                              <div class="item-info-product">
                                 <div class="info-product-price">
                                    <div class="grid_meta">
                                       <div class="product_price">
                                          <h4>
                                             <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                          </h4>
                                          <div class="grid-price mt-2">
                                             <span class="money "><?php echo $product['price']; ?></span>
                                          </div>
																			 </div>
																			 

																				<?php if ($product['rating']) { ?>
																				<ul class="stars">

																				<?php for ($i = 1; $i <= 5; $i++) { ?>
																					<?php if ($product['rating'] < $i) { ?>
																						<li><a href="#"><i class="fas fa-star"></i></a>
                                          </li>
																					<?php } else { ?>
																						<li><a href="#"><i class="far fa-star-half-o"></i></a>
                                          </li>
																							<!-- <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> -->
																					<?php } ?>
																					<?php } ?>
																					</ul>
																				<?php } ?>
                                       
                                    </div>
                                    <div class="toys single-item hvr-outline-out">

<!-- //!!! -->
																					<button type="button" class="toys-cart ptoys-cart button-cart" onclick="cart.add('<?php echo $product['product_id']; ?>');">
                                          <i class="fas fa-cart-plus"></i>
																					<span class="hidden-xs hidden-sm hidden-md"></span></button>

                                       <!-- </form> -->
                                    </div>
                                 </div>
                                 <div class="clearfix"></div>
                              </div>
                           </div>
                        </div>
										 </div>
										 <?php } ?>

										 
									</div>
									<?php } ?>
									
               </div>
            </div>
         </div>
      </section>
      <!-- //show Now-->

<!-- //????? -->
      <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
      </div>


      <?php if (!$categories && !$products) { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
			<?php } ?>
			
      <?php echo $content_bottom; ?></div>
		
			
<!-- </div> -->


<?php echo $footer; ?>
