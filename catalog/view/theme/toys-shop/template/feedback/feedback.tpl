<?php echo $header; ?>
<?php	echo $content_top; ?>
<div class="container">
  <div class="row">
    <div id="content" class="col-sm-12">
			<form class="form-feed" action="">
				<input name="name" type="text" placeholder="name">
				<input name="tel" type="text" placeholder="tel">
				<input name="email" type="text" placeholder="email">
				<textarea name="comment" cols="25" rows="5" placeholder="comment"></textarea>
				<input type="hidden" name="config_email" value="<?php echo $config_email;?>">
				<button>Отправить</button>
			</form>

		</div>
	</div>
</div>

<script>
		$('form').submit(function (event) {
			event.preventDefault();
			$.ajax({
				type: "POST",
				url: "catalog/view/theme/ocdi/template/feedback/phpmailer/mail.php",
				data: $(this).serialize()
			}).done(function () { 
				$(this).find("input").val("");
				$("form").trigger("reset");
			});
			return false;
		});
	</script>

<?php echo $footer; ?>
 