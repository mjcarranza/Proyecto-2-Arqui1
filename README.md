# **Herramientas Utilizadas**:
- [Quartus Prime](https://www.intel.la/content/www/xl/es/products/details/fpga/development-tools/quartus-prime.html)
, software utilizado para la implementación del procesador con el HDL [SystemVerilog](https://semiengineering.com/knowledge_centers/languages/systemverilog/)


- [Terasic DE1-SoC](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=205&No=836&PartNo=2#contents), FPGA utilizada para sintetizar el procesador. Además, es la herramienta que permite ver el output generado con el módulo de VGA.



# **Instrucciones de Uso**

## Procesador: 
1. Se debe comenzar por descargar el código disponible en [GitHub](https://github.com/mjcarranza/Proyecto-2-Arqui1/tree/procesador).

2. Se debe instalar [Quartus Prime](https://www.intel.la/content/www/xl/es/products/details/fpga/development-tools/quartus-prime.html).
   
3. Se debe conectar la Terasic DE1-SoC a la computadora. En caso de contar con los drivers, estos se pueden encontrar [en el sitio oficial.](https://www.terasic.com.tw/wiki/Windows_encountered_a_problem_installing_the_drivers_for_your_device).

4. Se debe conectar el VGA de la Terasic DE1-SoC a un monitor compatible.

5. Se debe abrir Quartus Prime y seleccionar el proyecto que se encuentra en la carpeta descargada del repositorio.

6. Se debe cargar el proyecto ya compilado a la FPGA.


## Compilador:

### Preparación del código y del archivo de entrada:
1. Asegúrate de tener un archivo de código Assembly en formato .marc. Este archivo debe contener el código que deseas compilar.
2. Prepara un archivo de entrada que desees usar para pruebas. Este archivo debe contener el texto que deseas procesar, como en el ejemplo proporcionado, donde el texto es "HELLO WORLD".

### Ejecución del compilador:
1. Ejecuta la función compilerController(fileName, inputText) proporcionando el nombre del archivo .marc y el texto de entrada como argumentos. Por ejemplo:
python
Copy code
fileName = "test.marc" inputText = "HELLO WORLD" compilerController(fileName, inputText) 

### Revisión de los archivos generados:
1. Una vez que el compilador haya terminado de ejecutarse, verificará el código, lo compilará y generará dos archivos .mif: uno para las instrucciones y otro para los datos.
2. Los archivos generados serán instructions.mif para las instrucciones y data.mif para los datos.

### Implementación en el hardware:
1. Los archivos .mif generados pueden ser utilizados en sistemas que acepten este formato para la programación de memorias ROM o similares.
