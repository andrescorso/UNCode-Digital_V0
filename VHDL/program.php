<html>
<body>
<?php

    //Saving design code
    $code_s = str_replace("<br>","\n",htmlspecialchars_decode($_POST['c']));
    $file = fopen("code/design.vhd", 'w+');
    ftruncate($file, 0); //Clear the file to 0bit
    $content = $code_s ;
    fwrite($file , $content); //Now lets write it in there
    fclose($file ); //Finally close our .txt

    
    //Saving golden model code
    $code_g = str_replace("<br>","\n",htmlspecialchars_decode($_POST['g']));
    $file = fopen("code/golden.vhd", 'w+');
    ftruncate($file, 0); //Clear the file to 0bit
    $content = $code_g ;
    fwrite($file , $content); //Now lets write it in there
    fclose($file ); //Finally close our .txt


    //Saving testbench code
    $code_t = str_replace("<br>","\n",htmlspecialchars_decode($_POST['t']));
    $file = fopen("code/testbench.vhd", 'w+');
    ftruncate($file, 0); //Clear the file to 0bit
    $content = $code_t ;
    fwrite($file , $content); //Now lets write it in there
    fclose($file ); //Finally close our .txt

    
    $salida = shell_exec('cd code ; ghdl -c golden.vhd testbench.vhd -r testbench --vcd=example_3_4.vcd');
    echo "<pre>$salida</pre>";
    $salida = shell_exec('python vcd2wd.py code/example_3_4 golden 2>&1 ');
    echo "<pre>$salida</pre>";

    $salida = shell_exec('cd code ; ghdl -c design.vhd testbench.vhd -r testbench --vcd=example_3_4.vcd');
    echo "<pre>$salida</pre>";
    $salida = shell_exec('python vcd2wd.py code/example_3_4 comp 2>&1 ');
    echo "<pre>$salida</pre>";
?>
</body>
</html>
