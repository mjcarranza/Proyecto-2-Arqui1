from PIL import Image

imagen = Image.open("./ALTO_NIVEL/logo.png")
datos = list(imagen.getdata())
ancho,alto = imagen.size
cab = f"24 {ancho} {alto}\n"
contenido_mif = cab + "\n".join(f"{r} {g} {b}" for r, g, b, _ in datos)

with open("./ALTO_NIVEL/imagen.mif", "w") as archivo:
    archivo.write(contenido_mif)