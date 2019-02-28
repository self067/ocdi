<div id="cart" class="btn-group btn-block">
  <button type="button" data-toggle="modal" data-target="#modalCart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-inverse btn-block btn-lg dropdown-toggle"><i class="fa fa-shopping-cart"></i> </button>

<!-- Modal -->
<div class="modal fade" id="modalCart" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel"><?php echo $text_title; ?></h4>
      </div>
      <div class="modal-body">

				<?php if ($products || $vouchers) { ?>
					<ul class="modal-list">
						<li>
						<table class="table table-striped">
							<?php foreach ($products as $product) { ?>
							<tr>
								<td class="text-center"><?php if ($product['thumb']) { ?>
									<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
									<?php } ?></td>
								<td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
									<?php if ($product['option']) { ?>
									<?php foreach ($product['option'] as $option) { ?>
									<br />
									- <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
									<?php } ?>
									<?php } ?>
									<?php if ($product['recurring']) { ?>
									<br />
									- <small><?php echo $text_recurring; ?> <?php echo $product['recurring']; ?></small>
									<?php } ?></td>
								<td class="text-right">x <?php echo $product['quantity']; ?></td>
								<td class="text-right"><?php echo $product['total']; ?></td>
								<td class="text-center"><button type="button" onclick="cart.remove('<?php echo $product['cart_id']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></button></td>
							</tr>
							<?php } ?>
						</table>
						</li>
						<li>
							<div>
								<table class="table table-bordered">
									<?php foreach ($totals as $total) { ?>
									<tr>
										<td class="text-right"><strong><?php echo $total['title']; ?></strong></td>
										<td class="text-right"><?php echo $total['text']; ?></td>
									</tr>
									<?php } ?>
								</table>
								<p class="text-right"><a href="<?php echo $cart; ?>"><strong><i class="fa fa-shopping-cart"></i> <?php echo $text_cart; ?></strong></a>&nbsp;&nbsp;&nbsp;<a href="<?php echo $checkout; ?>"><strong><i class="fa fa-share"></i> <?php echo $text_checkout; ?></strong></a></p>
							</div>
						</li>
						<?php } else { ?>
						<li>
							<p class="text-center"><?php echo $text_empty; ?></p>
						</li>
					</ul>
				<?php } ?>



      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $text_close;?></button>
        <a href="<?php echo $cart;?>" class="btn btn-primary"><?php echo $text_cart;?></a>
      </div>
    </div>
  </div>
</div>


</div>

<span id="cart-total"><?php echo $text_items; ?></span>



<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->


<div id="staplesbmincart">
		<form method="post" class="" action="checkout.html" target="">
			<button type="button" class="sbmincart-closer">×</button>
			<ul>
				<li class="sbmincart-item">
					<div class="sbmincart-details-name"> <a class="sbmincart-name"
							href="http://localhost/diplom/single.html">Farenheit</a>
						<ul class="sbmincart-attributes"> </ul>
					</div>
					<div class="sbmincart-details-quantity"> <input class="sbmincart-quantity" data-sbmincart-idx="0"
							name="quantity_1" type="text" pattern="[0-9]*" value="9" autocomplete="off"> </div>
					<div class="sbmincart-details-remove"> <button type="button" class="sbmincart-remove"
							data-sbmincart-idx="0">×</button> </div>
					<div class="sbmincart-details-price"> <span class="sbmincart-price">$5175.00</span> </div> <input type="hidden"
						name="toys_item_1" value="Farenheit"> <input type="hidden" name="amount_1" value="575"> <input type="hidden"
						name="shipping_1" value="undefined"> <input type="hidden" name="shipping2_1" value="undefined">
				</li>
				<li class="sbmincart-item">
					<div class="sbmincart-details-name"> <a class="sbmincart-name"
							href="http://localhost/diplom/shop.html#">toy(todos)</a>
						<ul class="sbmincart-attributes"> </ul>
					</div>
					<div class="sbmincart-details-quantity"> <input class="sbmincart-quantity" data-sbmincart-idx="1"
							name="quantity_2" type="text" pattern="[0-9]*" value="2" autocomplete="off"> </div>
					<div class="sbmincart-details-remove"> <button type="button" class="sbmincart-remove"
							data-sbmincart-idx="1">×</button> </div>
					<div class="sbmincart-details-price"> <span class="sbmincart-price">$960.00</span> </div> <input type="hidden"
						name="toys_item_2" value="toy(todos)"> <input type="hidden" name="amount_2" value="480"> <input type="hidden"
						name="shipping_2" value="undefined"> <input type="hidden" name="shipping2_2" value="undefined">
				</li>
				<li class="sbmincart-item">
					<div class="sbmincart-details-name"> <a class="sbmincart-name"
							href="http://localhost/ocdi/index.php?route=product/category&amp;path=25">Doll Sindy</a>
						<ul class="sbmincart-attributes"> </ul>
					</div>
					<div class="sbmincart-details-quantity"> <input class="sbmincart-quantity" data-sbmincart-idx="2"
							name="quantity_3" type="text" pattern="[0-9]*" value="1" autocomplete="off"> </div>
					<div class="sbmincart-details-remove"> <button type="button" class="sbmincart-remove"
							data-sbmincart-idx="2">×</button> </div>
					<div class="sbmincart-details-price">
						<span class="sbmincart-price">$480.00</span> </div>
					<input type="hidden" name="toys_item_3" value="Doll Sindy"> <input type="hidden" name="amount_3" value="480">
					<input type="hidden" name="shipping_3" value="undefined">
					<input type="hidden" name="shipping2_3" value="undefined">
				</li>
				<li class="sbmincart-item">
					<div class="sbmincart-details-name">
						<a class="sbmincart-name" href="http://localhost/diplom/shop.html">toys(blue)</a>
						<ul class="sbmincart-attributes">
						</ul>
					</div>
					<div class="sbmincart-details-quantity">
						<input class="sbmincart-quantity" data-sbmincart-idx="3" name="quantity_4" type="text" pattern="[0-9]*"
							value="1" autocomplete="off"> </div>
					<div class="sbmincart-details-remove">
						<button type="button" class="sbmincart-remove" data-sbmincart-idx="3">×</button>
					</div>
					<div class="sbmincart-details-price">
						<span class="sbmincart-price">$340.00</span> </div>
					<input type="hidden" name="toys_item_4" value="toys(blue)">
					<input type="hidden" name="amount_4" value="340">
					<input type="hidden" name="shipping_4" value="undefined">
					<input type="hidden" name="shipping2_4" value="undefined">
				</li>
			</ul>
			<div class="sbmincart-footer">
				<div class="sbmincart-subtotal"> Subtotal: $6955.00 USD </div>
				<button class="sbmincart-submit" type="submit" data-sbmincart-alt="undefined">Check Out</button>
			</div>
			<input type="hidden" name="cmd" value="_cart">
			<input type="hidden" name="upload" value="1">
			<input type="hidden" name="bn" value="sbmincart_AddToCart_WPS_US">
		</form>
	</div>
	