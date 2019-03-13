<?php echo $header; ?>

      <!--/shop-->
      <section class="banner-bottom py-lg-5 py-3">
         <div class="container">
            <div class="inner-sec-shop pt-lg-4 pt-3">
               <div class="row">
                  <div class="col-lg-4 single-right-left ">
                     <div class="grid images_3_of_2">
                        <div class="flexslider1">
                          <ul class="slides">
														
														<li data-thumb="<?php echo $thumb; ?>">
                                 <div class="thumb-image"> <img src="<?php echo $thumb; ?>" data-imagezoom="true" class="img-fluid" alt=" "> </div>
														</li>

														<?php foreach ($images as $image) { ?>
                              <li data-thumb="<?php echo $image['thumb']; ?>">
                                 <div class="thumb-image"> <img src="<?php echo $image['thumb']; ?>" data-imagezoom="true" class="img-fluid" alt=" "> </div>
															</li>
														<?php } ?>

                          </ul>
                          <div class="clearfix"></div>
                        </div>
                     </div>
                  </div>
                  <div class="col-lg-8 single-right-left simpleCart_shelfItem">
                     <h3><?php echo $heading_title; ?></h3>

										 <?php if (!$special) { ?>
											<p><span class="item_price"><?php echo $price; ?></span>
                        <!-- <del>$1,199</del> -->
	                    </p>
										<?php } else { ?>
											<p><span class="item_price"><?php echo $special; ?></span>
                        <del><?php echo  $price;?></del>
                     	</p>
										<?php } ?>



                     <div class="rating">
										 <!-- <label class="control-label"><?php echo $entry_rating; ?></label> -->
										 <?php if ($review_status) { ?>

                        <ul class="stars">
												<?php for ($i = 1; $i <= 5; $i++) { ?>
													<?php if ($rating < $i) { ?>
														<li><a href="#"><i class="fa fa-star-o" aria-hidden="true"></i></a></li>
													<?php } else { ?>
													 <li><a href="#"><i class="fa fa-star-half-o" aria-hidden="true"></i></a></li>
                           <li><a href="#"><i class="fa fa-star-o" aria-hidden="true"></i></a></li>
													<?php } ?>
													<?php } ?>
                        </ul>
												<?php } ?>
                     </div>


                     <div class="description">
                        <h5>Check delivery, payment options and charges at your location</h5>
                        <form action="#" method="post">
                           <input class="form-control" type="text" name="Email" placeholder="Please enter..." required="">
                           <input type="submit" value="Check">
                        </form>
                     </div>
                     <div class="color-quality">
                        <div class="color-quality-right">
                           <h5>Size :</h5>
                           <select id="country1" onchange="change_country(this.value)" class="frm-field required sect">
                              <option value="null">2 Feet</option>
                              <option value="null">3 Feet</option>
                              <option value="null">4 Feet</option>
                              <option value="null">5 Feet</option>
                           </select>
                        </div>
                     </div>
                     <div class="occasional">
                        <h5>Types :</h5>
                        <div class="colr ert">
                           <label class="radio"><input type="radio" name="radio" checked=""><i></i> Soft Teddy Bear (Black)</label>
                        </div>
                        <div class="colr">
                           <label class="radio"><input type="radio" name="radio"><i></i>Soft Teddy Bear (Brown)</label>
                        </div>
                        <div class="colr">
                           <label class="radio"><input type="radio" name="radio"><i></i>Pink Teddy Bear (Pink)</label>
                        </div>
                        <div class="clearfix"> </div>
                     </div>
                     <div class="occasion-cart">
                        <div class="toys single-item singlepage" id="product">

													<div class="form-group">
														<input type="hidden" name="quantity" value="1"  id="input-quantity"  />
														<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
														<div class="button-group">
														<button type="button" class="toys-cart ptoys-cart add" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" ><span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
														</div>
													</div>

<!-- /////////????????????? -->
											 

                        </div>
                     </div>

                  </div>
                  <div class="clearfix"> </div>
                  <!--/tabs-->
                  <div class="responsive_tabs">
                     <div id="horizontalTab">
                        <ul class="resp-tabs-list">
                           <li>Description</li>
                           <li>Reviews</li>
                           <li>Information</li>
                        </ul>
                        <div class="resp-tabs-container">
                           <!--/tab_one-->
                           <div class="tab1">
                              <div class="single_page">
                                 <h6>Lorem ipsum dolor sit amet</h6>
                                 <p>Lorem ipsum dolor sit amet, consectetur adipisicing elPellentesque vehicula augue eget nisl ullamcorper, molestie
                                    blandit ipsum auctor. Mauris volutpat augue dolor.Consectetur adipisicing elit, sed do eiusmod tempor incididunt
                                    ut lab ore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco. labore et dolore
                                    magna aliqua.
                                 </p>
                                 <p class="para">Lorem ipsum dolor sit amet, consectetur adipisicing elPellentesque vehicula augue eget nisl ullamcorper, molestie
                                    blandit ipsum auctor. Mauris volutpat augue dolor.Consectetur adipisicing elit, sed do eiusmod tempor incididunt
                                    ut lab ore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco. labore et dolore
                                    magna aliqua.
                                 </p>
                              </div>
                           </div>
                           <!--//tab_one-->
                           <div class="tab2">
                              <div class="single_page">
                                 <div class="bootstrap-tab-text-grids">
                                    <div class="bootstrap-tab-text-grid">
                                       <div class="bootstrap-tab-text-grid-left">
                                          <img src="catalog/view/theme/toys-shop/images/team1.jpg" alt=" " class="img-fluid">
                                       </div>
                                       <div class="bootstrap-tab-text-grid-right">
                                          <ul>
                                             <li><a href="#">Admin</a></li>
                                             <li><a href="#"><i class="fa fa-reply-all" aria-hidden="true"></i> Reply</a></li>
                                          </ul>
                                          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elPellentesque vehicula augue eget.Ut enim ad minima veniam,
                                             quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis
                                             autem vel eum iure reprehenderit.
                                          </p>
                                       </div>
                                       <div class="clearfix"> </div>
                                    </div>




																		<?php if ($review_status) { ?>
																		<div class="tab-pane add-review" id="tab-review">


																			<form class="form-horizontal" id="form-review" method="post" action="#">
																				<div id="review"></div>
																				<h4>add a review</h4>
																				<?php if ($review_guest) { ?>

																				<div class="form-group required">
																					<div class="col-sm-12">
																						<label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
																						<input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-name" class="form-control" />
																					</div>
																				</div>


																				<div class="form-group required">
																					<div class="col-sm-12">
																						<label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
																						<textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
																						<div class="help-block"><?php echo $text_note; ?></div>
																					</div>
																				</div>


																				<div class="form-group required">
																					<div class="col-sm-12">
																						<label class="control-label"><?php echo $entry_rating; ?></label>
																						&nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
																						<input type="radio" name="rating" value="1" />
																						&nbsp;
																						<input type="radio" name="rating" value="2" />
																						&nbsp;
																						<input type="radio" name="rating" value="3" />
																						&nbsp;
																						<input type="radio" name="rating" value="4" />
																						&nbsp;
																						<input type="radio" name="rating" value="5" />
																						&nbsp;<?php echo $entry_good; ?></div>
																				</div>

																				<?php echo $captcha; ?>
																				<div class="buttons clearfix">
																					<div class="pull-right">
																						<button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary">SEND</button>

																					</div>
																				</div>

																				<?php } else { ?>
																				<?php echo $text_login; ?>
																				<?php } ?>
																			</form>
																		</div>
																		<?php } ?>



                                 </div>
                              </div>
                           </div>
                           <div class="tab3">
                              <div class="single_page">
                                 <h6>Teddy Bear(Blue)</h6>
                                 <p>Lorem ipsum dolor sit amet, consectetur adipisicing elPellentesque vehicula augue eget nisl ullamcorper, molestie
                                    blandit ipsum auctor. Mauris volutpat augue dolor.Consectetur adipisicing elit, sed do eiusmod tempor incididunt
                                    ut lab ore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco. labore et dolore
                                    magna aliqua.
                                 </p>
                                 <p class="para">Lorem ipsum dolor sit amet, consectetur adipisicing elPellentesque vehicula augue eget nisl ullamcorper, molestie
                                    blandit ipsum auctor. Mauris volutpat augue dolor.Consectetur adipisicing elit, sed do eiusmod tempor incididunt
                                    ut lab ore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco. labore et dolore
                                    magna aliqua.
                                 </p>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <!--//tabs-->
               </div>
            </div>
         </div>
      </section>








			<script type="text/javascript">
$('#review').delegate('.pagination a', 'click', function(e) {
    e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: $("#form-review").serialize(),
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
			$('#button-review').button('reset');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();

			if (json['error']) {
				$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}

			if (json['success']) {
				$('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').prop('checked', false);
			}
		}
	});
    grecaptcha.reset();
});                                


</script>












<?php echo $footer; ?>

