<html>
<body>
<?php
    //Saving design code
    $code_s = str_replace("<br>","\n",htmlspecialchars_decode($_POST['c']));
    $file = fopen("code/design.v", 'w+');
    ftruncate($file, 0); //Clear the file to 0bit
    $content = $code_s ;
    fwrite($file , $content); //Now lets write it in there
    fclose($file ); //Finally close our .txt

    
    //Saving golden model code
    $code_g = str_replace("<br>","\n",htmlspecialchars_decode($_POST['g']));
    $file = fopen("code/golden.v", 'w+');
    ftruncate($file, 0); //Clear the file to 0bit
    $content = $code_g ;
    fwrite($file , $content); //Now lets write it in there
    fclose($file ); //Finally close our .txt


    //Saving testbench code
    $code_t = str_replace("<br>","\n",htmlspecialchars_decode($_POST['t']));
    $file = fopen("code/testbench.v", 'w+');
    ftruncate($file, 0); //Clear the file to 0bit
    $content = $code_t ;
    fwrite($file , $content); //Now lets write it in there
    fclose($file ); //Finally close our .txt

    #Simulación y creación de archivos
    $salida = shell_exec('cd code;iverilog -o tosim.vvp testbench.v golden.v 2>&1');
    echo "<pre>$salida</pre>";
    $salida = shell_exec('cd code ;vvp tosim.vvp 2>&1 ');
    echo "<pre>$salida</pre>";
    $salida = shell_exec('python vcd2wd.py code/example_3_4 golden 2>&1 ');
    echo "<pre>$salida</pre>";

    $salida = shell_exec('cd code;iverilog -o tosim.vvp testbench.v design.v 2>&1');
    echo "<pre>$salida</pre>";
    $salida = shell_exec('cd code ;vvp tosim.vvp 2>&1 ');
    echo "<pre>$salida</pre>";
    $salida = shell_exec('python vcd2wd.py code/example_3_4 comp 2>&1 ');
    echo "<pre>$salida</pre>";
?>
</body>
</html>
