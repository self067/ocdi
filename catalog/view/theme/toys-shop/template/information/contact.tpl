<?php echo $header; ?>
<?php echo $content_top; ?>


      <!--contact -->
      <section class="contact py-lg-4 py-md-3 py-sm-3 py-3">
         <div class="container py-lg-5 py-md-4 py-sm-4 py-3">
            <h3 class="title text-center mb-lg-5 mb-md-4 mb-sm-4 mb-3">Contact US</h3>
            <div class="contact-list-grid">

						<!-- <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data"> -->
						<form action="" method="post" enctype="multipart/form-data">
						<!-- <fieldset> -->
							<div class=" agile-wls-contact-mid">
                     <div class="form-group contact-forms">
												<input type="text" class="form-control" placeholder="Name" name="name" value="<?php echo $name; ?>" id="input-name">
													<?php if ($error_name) { ?>
													<div class="text-danger"><?php echo $error_name; ?></div>
													<?php } ?>

                     </div>
                     <div class="form-group contact-forms">
												<input type="email" class="form-control" placeholder="E-mail" name="email" value="<?php echo $email; ?>" id="input-email">
												
													<?php if ($error_email) { ?>
													<div class="text-danger"><?php echo $error_email; ?></div>
													<?php } ?>

                     </div>
                     <div class="form-group contact-forms">
												<input type="text" class="form-control" placeholder="Phone" name="tel" value="<?php echo $telephone; ?>" id="input-phone">
												
                     </div>
                     <div class="form-group contact-forms">
												<textarea class="form-control" rows="3" name="enquiry" id="input-enquiry"></textarea>
													<?php if ($error_enquiry) { ?>
													<div class="text-danger"><?php echo $error_enquiry; ?></div>
													<?php } ?>

										 </div>
										 
										 <!-- </fieldset>
									        <div class="buttons">
          									<div class="pull-right">
            									<input class="btn btn-primary" type="submit" value="<?php echo $button_submit; ?>" />
          									</div>
        									</div> -->

											<input type="hidden" name="config_email" value="<?php echo $config_email;?>">


                     <button type="submit" class="btn btn-block sent-butnn">Send</button>
                  </div>
               </form>
            </div>
         </div>
         <!--//contact-map -->
	 </section>


<script>
		$('form').submit(function (event) {
			event.preventDefault();
			$.ajax({
				type: "POST",
				url: "catalog/view/theme/toys-shop/template/information/phpmailer/mail.php",
				data: $(this).serialize()
			}).done(function () { 
				$(this).find("input").val("");
				$("form").trigger("reset");

				//  $this->response->redirect($this->url->link('information/contact/success'));
				location.href ='https://ocdi.jktu.ru/index.php?route=information/contact/success';

			});
			return false;
		});
	</script>

<?php echo $footer; ?>
