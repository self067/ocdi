         <!-- Slideshow 4 -->

<!-- если будет время, добавить в БД таблицу banner поле description, -->
<!-- в контроллер и модель соответстенно и здесь вывести вместо лорем -->
				 <div class="slider text-center">
            <div class="callbacks_container">
               <ul class="rslides slider4" id="slideshow<?php echo $module; ?>">

								 <?php foreach ($banners as $banner) { ?>

									 <li>
										<div class="slider-img" style="background: url(<?php echo $banner['image']; ?>)no-repeat center;">
                        <div class="container">
                           <div class="slider-info ">
                              <h5><?php echo $banner['title']; ?></h5>
                              <div class="bottom-info">
                                 <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.Aenean commodo ligula eget dolorL orem ipsum dolor sit amet eget dolor</p>
                              </div>
                              <div class="outs_more-buttn">
                                 <a href="about.html">Read More</a>
                              </div>
                           </div>
                        </div>
										 </div>

										 <!-- <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a> -->

										</li>
									<?php } ?>								

               </ul>
            </div>
            <!-- This is here just to demonstrate the callbacks -->
            <!-- <ul class="events">
               <li>Example 4 callback events</li>
               </ul>-->
            <div class="clearfix"></div>
         </div>
      <!-- </div> -->
      <!-- //banner -->

