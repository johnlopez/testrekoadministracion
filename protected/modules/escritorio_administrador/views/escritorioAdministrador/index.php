   
<?php $dataArray = $dataProvider->getData();?>

    <span class="tile-group-title">Other</span>
    <div class="tile-container">

        <?php foreach ($dataArray as $data):?>

        <a href="<?php echo 'http://localhost/testrekoadministracion/'.$data->name;?>" >
            <div class="tile bg-red fg-white" data-role="tile">   
                <div class="tile-content iconic" >                
                    <span class="icon mif-skype"></span>
                </div>
                <span class="tile-label list-group-item">                
                    <?php 
                        $pizza  = CHtml::encode($data->name);
                        $porciones = explode("_", $pizza);
                        foreach ($porciones as $p)
                        echo $p." "; // porción

                    ?>
                </span>
            </div>
        </a>
        <div class="tile bg-darkBlue fg-white" data-role="tile">
            <div class="tile-content iconic">
                <span class="icon mif-cloud"></span>
            </div>
            <span class="tile-label">OneDrive</span>
        </div>
        <div class="tile" data-role="tile" data-role="tile" data-effect="slideUpDown">
            <div class="tile-content">
                <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/me.jpg" data-role="fitImage" data-format="fill"></div>
                <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/spface.jpg" data-role="fitImage" data-format="fill"></div>
                <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jeki_chan.jpg"></div>
            </div>
            <div class="tile-label">Photos</div>
        </div>
        
        <?php endforeach;?>


    </div>


                  