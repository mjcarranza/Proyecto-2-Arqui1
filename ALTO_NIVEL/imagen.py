from PIL import Image, ImageDraw, ImageFont

altura = 250
ancho = 250
texto = ""
ruta_archivo = "./ALTO_NIVEL/archivo.txt"

with open(ruta_archivo, 'r') as archivo:
    texto = archivo.read()

ruta_imagen = "./ALTO_NIVEL/imagen.png"
imagen = Image.new('RGB', (ancho, altura), color='black')
draw = ImageDraw.Draw(imagen)

fuente = ImageFont.load_default()

left, top, right, bottom = fuente.getbbox(texto)
text_width = right - left
text_height = bottom - top

x = (ancho - text_width) / 2
y = (altura - text_height) / 2

draw.text((x, y), texto, fill='white', font=fuente)
imagen.save(ruta_imagen)
print("Se crea...........")




#CREACION DEL .MIF


imagen = Image.open("./ALTO_NIVEL/imagen.png")
datos_pixeles = imagen.convert("RGB").tobytes()



with open("./ALTO_NIVEL/imagen.mif", "w") as archivo_mif:
    archivo_mif.write("WIDTH=24;\n")
    archivo_mif.write("DEPTH={};\n".format(imagen.width * imagen.height))
    archivo_mif.write("ADDRESS_RADIX=DEC;\n")  # Cambiamos a decimal
    archivo_mif.write("DATA_RADIX=HEX;\n")
    archivo_mif.write("CONTENT BEGIN\n")

    for y in range(imagen.height):
        for x in range(imagen.width):
            pixel = imagen.getpixel((x, y))
            valor_hex = '{0:02X}{1:02X}{2:02X}'.format(*pixel)
            direccion_decimal = y * imagen.width + x  # Calculamos la dirección en decimal
            archivo_mif.write("   {:d} : {:s};\n".format(direccion_decimal, valor_hex))  # Escribimos la dirección en decimal

    archivo_mif.write("END;")