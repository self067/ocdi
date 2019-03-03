<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button id="button-save" type="submit" form="form-credit-multiedit" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if (!empty($success)) { ?>
      <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?></div>
    <?php } ?>

    <div class="panel panel-default">
      <div class="panel-heading">
        <h2 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h2>
      </div>
      <div class="panel-body">

        <!-- Customized.Begin -->

        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-seo-url-generator" class="form-horizontal">

          <!-- status -->
					<div class="form-group" style="padding-top: 5px; padding-bottom: 5px;">
						<label class="col-sm-2 control-label" for="input-status-mod"><?php echo $entry_status; ?>:</label>
						<div class="col-sm-2">
							<select name="seo_url_generator_status" id="input-status-mod" class="form-control">
								<?php if ($seo_url_generator_status) { ?>
									<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
									<option value="0"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
									<option value="1"><?php echo $text_enabled; ?></option>
									<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select>
						</div>
					</div>

					<!-- code_for_translit -->
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input_code_for_translit"><?=$entry_code_for_translit?>:</label>
            <div class="col-sm-2">
              <select name="seo_url_generator_code_for_translit" id="input_code_for_translit" class="form-control">
                <?php foreach ($a_codes_for_translit as $key => $code) { ?>
                <option value="<?=$key?>"<?=$seo_url_generator_code_for_translit == $key ? ' selected="selected"' : ''?>><?=$code?></option>
                <?php } ?>
              </select>
            </div>
          </div>

          <!-- formula_product -->
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input_formula_product"><?=$entry_formula_product?></label>
            <div class="col-sm-10">
              <input type="text" name="seo_url_generator_formula_product" value="<?=$seo_url_generator_formula_product?>" placeholder="<?=$entry_formula_product?>" id="input_formula_product" class="form-control" />
              <?=$text_formula_product_vars?>
              <?php if (isset($errors['formula_product'])) { ?>
              <div class="text-danger"><?=$errors['formula_product']?></div>
              <?php } ?>
            </div>
          </div>

        </form>
        <br>
        <div class="copywrite" style="padding: 10px 10px 0 10px; border: 1px dashed #ccc;">
          <p>
            &copy; <?=$text_author?>: <a href="//sergetkach.com/" target="_blank"><?=$text_author_name?></a>
            <br/>
            <?=$text_author_support?>: <a href="mailto:sergheitkach@gmail.com">sergheitkach@gmail.com</a>
          </p>
        </div>
      </div><!-- /Panel-Body-->
      <!-- Customized.End-->
    </div>
  </div>
</div><!-- /content-->
<?php echo $footer; ?>