      <!--new Arrivals -->
      <section class="blog py-lg-4 py-md-3 py-sm-3 py-3">
         <div class="container py-lg-5 py-md-4 py-sm-4 py-3">
            <h3 class="title clr text-center mb-lg-5 mb-md-4 mb-sm-4 mb-3"><?php echo $heading_title; ?></h3>
            <div class="slid-img">
               <ul id="flexiselDemo1">

							 <?php foreach ($products as $product) { ?>
							 
									<li>
                     <div class="agileinfo_port_grid">
                        <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" class="img-fluid" />
                        <div class="banner-right-icon">
                           <h4 class="pt-3"><?php echo $product['name']; ?></h4>
                        </div>
                        <div class="outs_more-buttn">
                           <a href="<?php echo $product['href']; ?>">Shop Now</a>
                        </div>
                     </div>
                  </li>
							 <?php	} ?>
  
							</ul>
            </div>
         </div>
      </section>


<!-- ************************************************************************************************ -->


