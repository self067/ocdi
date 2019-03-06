
<li class="toyscart toyscart2 cart cart box_1">
	<!-- <form action="#" method="post" class="last"> -->
	<!-- </form> -->

<!-- <div id="cart" class="btn-group btn-block"> -->
  <!-- <button type="button" data-toggle="modal" data-target="#modalCart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-inverse btn-block btn-lg dropdown-toggle"><i class="fa fa-shopping-cart"></i> </button> -->
	<button class="top_toys_cart" type="button" name="submit" data-toggle="modal" data-target="#staplesbmincart" value=""><span class="fas fa-cart-arrow-down"></span></button>
<!-- Modal -->
<div class="modal fade" id="staplesbmincart" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
				<button type="button" class="sbmincart-closer close btn btn-default" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>

      <div class="modal-body">

				<?php if ($products || $vouchers) { ?>
					
					<ul class="modal-list">
						<!-- <li> -->
						<!-- <table class="table table-striped"> -->
							<?php foreach ($products as $product) { ?>

								<div class="sbmincart-item">

									<div class="sbmincart-details-name"><a class="sbmincart-name"
										href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
										<!-- <ul class="sbmincart-attributes"> </ul> -->
									</div>

									<div class="sbmincart-details-quantity"> <input class="sbmincart-quantity" data-sbmincart-idx="0"
										name="quantity_1" type="text" pattern="[0-9]*" value="<?php echo $product['quantity']; ?>" autocomplete="off"> </div>

									<div class="sbmincart-details-remove"> <button type="button" class="sbmincart-remove"
									onclick="cart.remove('<?php echo $product['cart_id']; ?>');">&times</button> </div>

										<!-- <button type="button" onclick="cart.remove('<?php echo $product['cart_id']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></button></td> -->
									<div class="sbmincart-details-price"> 
										<span class="sbmincart-price">
										<?php echo $product['total']; ?>
										</span> 
									</div> 

								</div>

							<?php } ?>

						<!-- </table> -->
						<!-- </li> -->

						<!-- <li> -->


						<div class="sbmincart-footer">
								<div class="sbmincart-subtotal"> Subtotal: <?php echo $totals[0]['text'];?> </div>
									<button  class="sbmincart-submit" type="submit" data-sbmincart-alt="undefined"><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></button>
									<!-- <p><a href="<?php echo $checkout; ?>"> <?php echo $text_checkout; ?></a></p>	 -->
								</div>

								<!-- <p class="text-right"><a href="<?php echo $cart; ?>"><strong><i class="fa fa-shopping-cart"></i> <?php echo $text_cart; ?></strong></a>&nbsp;&nbsp;&nbsp;<a href="<?php echo $checkout; ?>"><strong><i class="fa fa-share"></i> <?php echo $text_checkout; ?></strong></a></p> -->
						<!-- </li> -->





						<?php } else { ?>
						<li>
							<p class="text-center"><?php echo $text_empty; ?></p>
						</li>
					</ul>
				<?php } ?>

					

			</div>
			
      <div class="modal-footer">


			</div>

    </div>
  </div>
</div>


<!-- </div> -->
</li>

<!-- <span id="cart-total"><?php echo $text_items; ?></span> -->
