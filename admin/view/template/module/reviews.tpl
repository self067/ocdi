<?php
/*------------------------------------------------------------------------
# Customer Reviews
# ------------------------------------------------------------------------
# The Krotek
# Copyright (C) 2011-2019 The Krotek. All Rights Reserved.
# @license - http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
# Website: https://thekrotek.com
# Support: support@thekrotek.com
-------------------------------------------------------------------------*/
?>
<?php echo $header;?>
<?php $extension_id = str_replace('_', '-', $extension); ?>
<link rel="stylesheet" type="text/css" href="view/stylesheet/<?php echo $stylesheet; ?>.css" />

<?php echo $column_left; ?>

<div id="content" class="<?php echo $extension_id; ?>">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">        				
				<?php if (!empty($buttons)) { ?>
					<?php foreach ($buttons as $button) { ?>
						<a id="button-<?php echo $button['id']; ?>"<?php echo (!empty($button['href']) ? ' href="'.$button['href'].'"' : ''); ?> data-toggle="tooltip" title="<?php echo $button['title']; ?>" class="btn top-buttons <?php echo $button['class']; ?>"<?php echo (!empty($button['target']) ? ' target="'.$button['target'].'"' : ''); ?>><i class="fa fa-<?php echo $button['icon']; ?>"></i></a>
					<?php } ?>
				<?php } ?>
    		</div>
      		<h1><?php echo $heading_title; ?></h1>
      		<ul class="breadcrumb">
        		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
        			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        		<?php } ?>
      		</ul>
    	</div>
  	</div>
	<div class="container-fluid">
		<?php if ($errors) { ?>
			<?php foreach ($errors as $error) { ?>
				<div class="alert alert-danger">
    				<i class="fa fa-exclamation-circle"></i> <?php echo $error; ?>
      				<button type="button" class="close" data-dismiss="alert">&times;</button>
				</div>
			<?php } ?>
		<?php } elseif ($success) { ?>
			<div class="alert alert-success">
				<i class="fa fa-check-circle"></i> <?php echo $success; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>
		
		<?php if ($warning) { ?>
			<div class="alert alert-warning">
				<i class="fa fa-exclamation-circle"></i> <?php echo $warning; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>
				
		<?php if ($information) { ?>
			<div class="alert alert-warning">
				<i class="fa fa-exclamation-circle"></i> <?php echo $information; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>				
		<?php } ?>
						
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
				<div class="pull-right"><?php echo $version; ?></div>
			</div>
			<div class="panel-body">
        		<form action="<?php echo $mainaction; ?>" method="post" enctype="multipart/form-data" id="form-<?php echo $extension_id; ?>" class="form-horizontal">
        			<input type="hidden" name="apply" id="apply" value="0">
        	
      				<?php if (count(array_keys($settings)) > 1) { ?>
      					<ul class="nav nav-tabs main-tabs">
      						<?php $tabkey = 0; ?>
	      					<?php foreach ($settings as $tab => $options) { ?>
            					<li class="nav-tab<?php echo ($tabkey == 0 ? ' active' : ''); ?>"><a href="#tab-<?php echo str_replace('_', '-', $tab); ?>" data-toggle="tab"<?php echo ($tab == 'new' ? " title='".$button_add_tab."'" : ''); ?>><?php echo ${'tab_'.$tab}; ?></a></li>
            					<?php $tabkey ++; ?>
            				<?php } ?>
          				</ul>
          	        <?php } ?>
          	        
          	        <div class="tab-content">
          	        	<?php $tabkey = 0; ?>
          	        	<?php $tabskey = 0; ?>
          	        	<?php foreach ($settings as $tab => $options) { ?>
      						<div class="tab-pane<?php echo ($tabkey == 0 ? ' active' : ''); ?>" id="tab-<?php echo str_replace('_', '-', $tab); ?>">
      							<?php if (!empty(${'help_'.$tab}) && (${'help_'.$tab} != 'help_'.$tab)) { ?>
      								<span class="notice"><?php echo ${'help_'.$tab}; ?></span>
      							<?php } ?>
								<?php foreach ($options as $field => $fieldtype) {
									if ($field == 'tabs') continue;
									
									if (is_array($fieldtype)) {
										$field_id = str_replace('_', '-', $tab).'-'.str_replace('_', '-', $field); ?>
											
        								<ul class="nav nav-tabs language-tabs multifield" id="<?php echo $extension; ?>-<?php echo $field_id; ?>-languages">
        									<?php foreach ($languages as $language) { ?>
        										<li><a href="#<?php echo $extension; ?>-<?php echo $field_id; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="<?php echo $language['flag']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
        									<?php } ?>
			      						</ul>
      									<div class="tab-content multifield">
											<?php foreach ($languages as $language) { ?>
												<div class="tab-pane" id="<?php echo $extension; ?>-<?php echo $field_id; ?>-<?php echo $language['language_id']; ?>">
													<?php foreach ($fieldtype as $child => $childtype) {
														
														$data = array(
															'tab' => $tab,
															'tabkey' => $tabkey,
															'field' => (!empty($options['tabs']) ? $options['tabs'].'['.($tabskey).']['.$child.']' : $child),
															'fieldkey' => $child,
															'fieldtype' => $childtype,
															'value' => (!empty($options['tabs']) && isset(${$options['tabs']}[($tabskey)][$child]) ? ${$options['tabs']}[($tabskey)][$child] : NULL),
															'language' => $language);

														if (!empty($options['tabs'])) { 
															if (($childtype == 'select') || ($childtype == 'checkbox')) {
																$data['field'] = ${$child};
															}
														}

														ob_start();
														getFieldHTML($values, $data);
														$html = ob_get_contents();
														ob_end_clean();
											
														echo $html;
													} ?>
								
												</div>	
											<?php } ?>
										</div>										
									
									<?php } else {
										if (!empty($options['tabs'])) { 
											if (($fieldtype == 'select') || ($fieldtype == 'checkbox')) {
												$data['field'] = ${$field};
											}
										}
														
										$data = array(
											'tab' => $tab,
											'tabkey' => $tabkey,
											'field' => (!empty($options['tabs']) ? $options['tabs'].'['.($tabskey).']['.$field.']' : $field),
											'fieldkey' => $field,
											'fieldtype' => $fieldtype,
											'value' => (!empty($options['tabs']) && isset(${$options['tabs']}[($tabskey)][$field]) ? ${$options['tabs']}[($tabskey)][$field] : NULL));
																									
										ob_start();
										getFieldHTML($values, $data);
										$html = ob_get_contents();
										ob_end_clean();
							
										echo $html;
									} ?>

								<?php } ?>
							</div>
							<?php $tabkey ++; ?>
							<?php if (!empty($options['tabs'])) $tabskey++; ?>
						<?php } ?>
					</div>
					
            	</form>
				<div class="copyright">Get more OpenCart extensions from The Krotek for lower price on <a href="https://thekrotek.com" title="Visit The Krotek site">The Krotek site</a>!</div>
          	</div>
      	</div>
    </div>		
</div>
<?php echo $footer; ?>
<?php if (file_exists(__DIR__."/".$extension."_js.tpl")) include($extension."_js.tpl"); ?>
<?php
	
function getFieldHTML($values, $data)
{
	extract($values);

	$field_id = str_replace('_', '-', $data['tab']).'-'.str_replace('_', '-', $data['fieldkey']);
	$extension_id = str_replace('_', '-', $extension);
	
	$id = "input-".$field_id;
	$name = $fieldbase.'_'.$data['field'];
	
	if (!is_null($data['value'])) $value = $data['value'];
	elseif (isset(${$fieldbase.'_'.$data['fieldkey']})) $value = ${$fieldbase.'_'.$data['fieldkey']};
	else $value = '';
	
	if (!in_array($data['fieldtype'], array('hidden', 'table'))) {
		$entry = (isset(${'entry_'.$data['fieldkey']}) ? ${'entry_'.$data['fieldkey']} : '');
		$help = (isset(${'help_'.$data['fieldkey']}) ? ${'help_'.$data['fieldkey']} : '');
	}
	
	if ($data['fieldtype'] == 'title') { ?>
		<h2><?php echo $entry; ?></h2>
		<?php if (!empty($help) && ($help != 'help_'.$data['fieldkey'])) { ?>
			<span class="note"><?php echo $help; ?></span>
		<?php } ?>
	<?php } elseif ($data['fieldtype'] == 'notice') { ?>
		<span class="notice"><?php echo $entry; ?></span>							
	<?php } elseif ($data['fieldtype'] == 'hidden') { ?>
		<input type="hidden" name="<?php echo $name; ?>" value="<?php echo $value; ?>" />
	<?php } elseif ($data['fieldtype'] == 'table') { ?>
		<?php echo $value; ?>			
	<?php } else { ?>
		<div class="form-group <?php echo $extension_id.'-'.$field_id; ?>">
			<label class="col-sm-2 control-label" for="<?php echo $id; ?>">
				<?php if ($help && ($help != 'help_'.$data['fieldkey'])) { ?>
					<span data-toggle="tooltip" title="<?php echo $help; ?>"><?php echo $entry; ?></span>
				<?php } else {?>
					<?php echo $entry; ?>
				<?php } ?>
			</label>
			<div class="col-sm-10">
				<?php if ($data['fieldtype'] == 'html') { ?>
					<?php echo $value; ?>
				<?php } elseif ($data['fieldtype'] == 'plaintext') { ?>
					<span id="<?php echo $id; ?>" class="input-text">
						<?php echo $value; ?>
					</span>
				<?php } elseif ($data['fieldtype'] == 'date') { ?>
					<div class="input-group date">
						<input type="text" name="<?php echo $name; ?>" value="<?php echo $value; ?>" placeholder="<?php echo $entry; ?>" id="<?php echo $id; ?>" data-date-format="YYYY-MM-DD" class="form-control" />
						<span class="input-group-btn">
							<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
						</span>
					</div>
				<?php } elseif ($data['fieldtype'] == 'button') { ?>
					<button id="button-<?php echo $field_id; ?>" class="btn btn-success input-button"><?php echo $value; ?></button>
				<?php } elseif (($data['fieldtype'] == 'text') || ($data['fieldtype'] == 'multitext')) { ?>
					<?php if ($data['fieldtype'] == 'multitext') { ?>
						<?php foreach ($languages as $language) { ?>
							<div class="input-group">
								<span class="input-group-addon"><img src="<?php echo $language['flag']; ?>" title="<?php echo $language['name']; ?>" /></span>
								<input type="text" name="<?php echo $name; ?>[<?php echo $language['language_id']; ?>]" value="<?php echo (isset($value[$language['language_id']]) ? $value[$language['language_id']] : ''); ?>" placeholder="<?php echo $entry; ?>" id="<?php echo $id; ?>" class="form-control" />
							</div>
						<?php } ?>
					<?php } else { ?>
						<?php if (isset($data['language'])) {
							$name .= '['.$data['language']['language_id'].']';
							$id .= '-'.$data['language']['language_id'];			
							$value = (is_array($value) ? (!empty($value[$data['language']['language_id']]) ? $value[$data['language']['language_id']] : '') : $value);
						} ?>					
						
						<input type="text" name="<?php echo $name; ?>" id="<?php echo $id; ?>" class="form-control" value="<?php echo $value; ?>" placeholder="<?php echo $entry; ?>" />
					<?php } ?>
				<?php } elseif (($data['fieldtype'] == 'textarea') || ($data['fieldtype'] == 'multitextarea') || ($data['fieldtype'] == 'editor') || ($data['fieldtype'] == 'multieditor')) { ?>
					<?php if (($data['fieldtype'] == 'multitextarea') || ($data['fieldtype'] == 'multieditor')) { ?>
        				<ul class="nav nav-tabs language-tabs" id="<?php echo $extension; ?>-<?php echo $field_id; ?>-languages">
        					<?php foreach ($languages as $language) { ?>
        						<li><a href="#<?php echo $extension; ?>-<?php echo $field_id; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="<?php echo $language['flag']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
        					<?php } ?>
			      		</ul>
      					<div class="tab-content">
							<?php foreach ($languages as $language) { ?>
								<div class="tab-pane" id="<?php echo $extension; ?>-<?php echo $field_id; ?>-<?php echo $language['language_id']; ?>">
									<textarea name="<?php echo $fieldbase; ?>_<?php echo $data['field']; ?>[<?php echo $language['language_id']; ?>]" placeholder="<?php echo $entry; ?>" id="<?php echo $id; ?>-<?php echo $language['language_id']; ?>" class="form-control<?php echo ($data['fieldtype'] == 'multieditor' ? ' summernote' : ''); ?>"><?php echo (isset($value[$language['language_id']]) ? $value[$language['language_id']] : ''); ?></textarea>
								</div>
							<?php } ?>
						</div>
					<?php } else { ?>
						<?php if (isset($data['language'])) {
							$name .= '['.$data['language']['language_id'].']';
							$id .= '-'.$data['language']['language_id'];						
							$value = (is_array($value) ? (!empty($value[$data['language']['language_id']]) ? $value[$data['language']['language_id']] : '') : $value);
						} ?>
													
						<textarea name="<?php echo $name; ?>" placeholder="<?php echo $entry; ?>" id="<?php echo $id; ?>" class="form-control<?php echo ($data['fieldtype'] == 'editor' ? ' summernote' : ''); ?>"><?php echo $value; ?></textarea>
					<?php } ?>			
				<?php } elseif ($data['fieldtype'] == 'select') { ?>
					<select name="<?php echo $name; ?>" id="<?php echo $id; ?>" class="form-control">
						<?php $items = (isset(${$data['fieldkey']}[$data['tab']]) ? ${$data['fieldkey']}[$data['tab']] : ${$data['fieldkey']}); ?>						
						<?php foreach ($items as $item) { ?>
						 	<?php if (is_array($item[0])) { ?>
						 		<optgroup label="<?php echo $item[1]; ?>">
									<?php foreach ($item[0] as $group_item) { ?>
										<option value="<?php echo $group_item[0]; ?>"<?php echo ($group_item[0] == $value ? ' selected="selected"' : ''); ?>><?php echo $group_item[1]; ?></option>
									<?php } ?>
						 		</optgroup>
						 	<?php } else { ?>
								<option value="<?php echo $item[0]; ?>"<?php echo ($item[0] == $value ? ' selected="selected"' : ''); ?>><?php echo $item[1]; ?></option>
							<?php } ?>
						<?php } ?>
					</select>
				<?php } elseif ($data['fieldtype'] == 'checkbox') { ?>
					<div class="well well-sm" style="height: 100px; overflow: auto;">
						<?php $items = (isset(${$data['fieldkey']}[$data['tab']]) ? ${$data['fieldkey']}[$data['tab']] : ${$data['fieldkey']}); ?>
						<?php foreach ($items as $item) { ?>
							<div class="checkbox">
								<label>
									<input type="checkbox" name="<?php echo $name; ?>[]" value="<?php echo $item[0]; ?>"<?php echo (is_array($value) && in_array($item[0], $value) ? ' checked="checked"' : ''); ?> /> <?php echo $item[1]; ?>
								</label>
							</div>
						<?php } ?>
					</div>
					<div class="checkbox-select">
						<a onclick="$(this).parent().parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all;?></a>
					</div>
				<?php } elseif (($data['fieldtype'] == 'autocomplete') || ($data['fieldtype'] == 'multiautocomplete')) { ?>
					<?php if ($data['fieldtype'] == 'multiautocomplete') { ?>
						<input type="text" name="autocomplete_<?php echo $data['field']; ?>" value="" placeholder="<?php echo $entry; ?>" id="<?php echo $id; ?>" class="form-control multiautocomplete" />
						<div id="<?php echo $extension_id.'-'.$field_id; ?>" class="well well-sm autocomplete-results" style="height: 150px; overflow: auto;">
							<?php foreach (${$data['fieldkey']} as $item) { ?>
								<div id="<?php echo $extension_id.'-'.$field_id.'-'.$item[0]; ?>">
									<i class="fa fa-minus-circle"></i> <?php echo $item[1]; ?>
									<input type="hidden" name="<?php echo $name; ?>[]" value="<?php echo $item[0]; ?>" />
								</div>
							<?php } ?>
						</div>
                		<div class="checkbox-select">
							<a onclick="$('#<?php echo $extension_id.'-'.$field_id; ?> div').remove();"><?php echo $text_remove_all; ?></a>
						</div>
					<?php } else { ?>
						<input type="text" name="autocomplete_<?php echo $data['field']; ?>" value="<?php echo ${'autocomplete_'.$data['field']}; ?>" placeholder="<?php echo $entry; ?>" id="<?php echo $id; ?>" class="form-control autocomplete" />
						<input type="hidden" name="<?php echo $name; ?>" value="<?php echo $value; ?>" />
					<?php } ?>
				<?php } elseif ($data['fieldtype'] == 'radio') { ?>
					<label class="radio-inline">
						<input type="radio" name="<?php echo $name; ?>" value="1"<?php echo ($value ? ' checked="checked"' : ''); ?> /><?php echo $text_yes; ?>
					</label>
					<label class="radio-inline">
						<input type="radio" name="<?php echo $name; ?>" value="0"<?php echo (!$value ? ' checked="checked"' : ''); ?> /><?php echo $text_no; ?>
					</label>
				<?php } ?>
			</div>
		</div>
	<?php }
}

?>