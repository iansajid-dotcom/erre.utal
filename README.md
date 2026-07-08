# Blog del curso — Ciencia de Datos en R para la Investigación

Sitio estático simple (HTML/CSS puro, sin build ni dependencias). Se abre
directo en el navegador o se publica gratis en GitHub Pages.

## Estructura

```
blog-r-curso/
├── index.html
├── syllabus.pdf         ← programa del curso, fuera de las 3 carpetas
├── css/style.css
├── clases/              ← una página HTML por clase
├── scripts/             ← archivos .R de cada clase
├── datasets/            ← planillas de datos (.csv, .txt, .xlsx)
└── slides/              ← presentaciones (.pdf / .pptx)
```

Material real ya cargado: script + 2 diapositivas de la Clase 1 (dos
sesiones), script + dataset d1.nativas en sus 3 formatos de la Clase 2. Las
diapositivas de ggplot2 (cierre de la Clase 2) todavía no existen.

Nota: revisá la fecha "Sesiones 1 y 2" en index.html y en
clases/clase-01-introduccion-a-r.html — es un placeholder.

## Cómo agregar una clase nueva

1. Copia `clases/_plantilla.html` y renombralo, ej: `clases/clase-03-ggplot2.html`.
2. Completa título, fecha, resumen y el código de ejemplo.
3. Sube el script a `scripts/`, el dataset a `datasets/` y la presentación a
   `slides/`, y actualizá los links del bloque "Material de la clase".
4. Agrega un `<article class="post-card">` nuevo en `index.html` (arriba de
   los anteriores, para que quede primero por fecha) con el link a `clases/...`.

No hace falta compilar nada — son archivos HTML planos.

## Publicar en GitHub Pages (recomendado)

Esto además les sirve para practicar Git/GitHub, algo que van a necesitar en
cualquier trabajo de investigación reproducible.

1. Creá un repositorio nuevo en tu cuenta de GitHub (iansajid-dotcom), público
   o privado con invitación a los alumnos.
2. Subí el contenido de esta carpeta al repo: "Add file → Upload files", y
   arrastrá todo lo de adentro de `blog-r-curso` (no la carpeta contenedora)
   para que `index.html` quede en la raíz del repo.
3. Settings → Pages → Source: rama `main`, carpeta `/ (root)` → Save.
4. GitHub te da una URL tipo `https://iansajid-dotcom.github.io/erre.utal/` —
   esa es la que compartís con los alumnos.
5. Cada vez que agregues una clase, subís los archivos nuevos y el sitio se
   actualiza solo, en 1-2 minutos.

### Descargar datasets directo desde R

Una vez subido el repo, cada archivo tiene una URL "raw":

```
https://raw.githubusercontent.com/iansajid-dotcom/erre.utal/main/datasets/d1.nativas.csv
```

```r
datos <- read.csv("https://raw.githubusercontent.com/iansajid-dotcom/TU-REPO/main/datasets/d1.nativas.csv")
```

Reemplazá TU-REPO por el nombre real del repositorio. Si corregís el dataset
después, el link no cambia. Para conseguir la URL raw de cualquier archivo:
abrilo en GitHub y apretá el botón "Raw".
