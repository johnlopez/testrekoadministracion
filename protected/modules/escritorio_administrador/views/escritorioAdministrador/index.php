   
<h2>Aplicaciones</h2>
<?php $dataArray = $dataProvider->getData();?>
<?php foreach ($dataArray as $data):?>
    <!-- panorama sections --><!-- panorama sections --><!-- panorama sections --><!-- panorama sections -->           
        <a class="tile wide imagetext bg-color-blue" href="<?php echo 'http://localhost/testrekoadministracion/'.$data->name;?>">
           <div class="image-wrapper">
              <span class="icon icon-happy"></span>
           </div>
           <div class="column-text">
              <div class="text">Administracion</div>
           </div>
           <span class="app-label"><?php echo CHtml::encode($data->name)?></span>
        </a>
    <!-- panorama sections --><!-- panorama sections --><!-- panorama sections --><!-- panorama sections -->
<?php endforeach;?>



                  