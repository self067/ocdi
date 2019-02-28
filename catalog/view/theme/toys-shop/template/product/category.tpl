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

																		<form action="#" method="post">
                                          <input type="hidden" name="cmd" value="_cart">
                                          <input type="hidden" name="add" value="1">
                                          <input type="hidden" name="toys_item" value="<?php echo $product['name']; ?>">
                                          <input type="hidden" name="amount" value="<?php echo $product['price']; ?>">

																					<button type="button" class="toys-cart ptoys-cart button-cart" onclick="cart.add('<?php echo $product['product_id']; ?>');">
                                          <i class="fas fa-cart-plus"></i>
																					<span class="hidden-xs hidden-sm hidden-md"></span></button>

                                       </form>
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


      <?php if (!$categories && !$products) { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
			<?php } ?>
			
      <?php echo $content_bottom; ?></div>
		
			
<!-- </div> -->





<script src='catalog/view/theme/toys-shop/js/jquery-2.2.3.min.js'></script>



<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});
//--></script>

<script type="text/javascript"><!--

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').val(json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>
<script type="text/javascript"><!--
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
});

//--></script>






<?php echo $footer; ?>


