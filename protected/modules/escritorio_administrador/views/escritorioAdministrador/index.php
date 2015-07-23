<?php $dataArray = $dataProvider->getData();?>
<div class="tile-group double">
    <span class="tile-group-title">Other</span>
    <div class="tile-container ">
        <?php foreach ($dataArray as $data):?>
        <a href="<?php echo 'http://localhost/testrekoadministracion/'.$data->name;?>" >
            <div class="tile-wide bg-red fg-white" data-role="tile">   
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
        
        <?php endforeach;?>
    </div>
</div>


                  