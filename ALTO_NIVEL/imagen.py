from PIL import Image

imagen = Image.open("./ALTO_NIVEL/bl.jpeg")
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



# Ejemplo de uso
#image_to_mif("./ALTO_NIVEL/negro.jpeg", "./ALTO_NIVEL/imagen.mif")