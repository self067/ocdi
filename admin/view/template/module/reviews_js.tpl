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
<script type="text/javascript">

/* Generic functions */

$(".<?php echo $extension; ?>").on("click", ".top-buttons", function()
{
	if (!$(this).attr("href")) {
		id = $(this).attr("id").split("-");
		task = id[1];

		if ((task != "save") && (task != "apply")) {
			$(".<?php echo $extension; ?> input[name='<?php echo $fieldbase; ?>_task']").attr("value", task);
		}
		
		if (task != "save") {
			$(".<?php echo $extension; ?> input[name='apply']").attr("value", "1");
		}
		
		$(".<?php echo $extension; ?> #form-<?php echo $extension_id; ?>").submit();
		
		return false;
	}
});

</script>