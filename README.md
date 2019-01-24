## MovieApp

La aplicación MovieApp fue desarrollada en Swift 4.2, Xcode 10. De acuerdo a los requerimientos de la prueba técnica remitida por Rappi para el puesto Desarrollador iOS. 

### Capas de la Aplicación

MovieApp se encuentra en el marco de la arquitectura MVC, en donde cabe destacar:

* [Persistencia de datos:]) - Se maneja con CoreData desde el componente Controller, haciendo énfasis en las necesidades propias de la App, sus clases asociadas son:
    - SeriesController.swift
    - PeliculasController.swift
    - ViewControllew.swift

* [Vistas:]) - Se maneja desde el componente View, donde se identifica el detalle a nivel de UI y sus clases asociadas son:
    - Main.storyboard
    - CeldaSerie.swift
    - PlayerView.xib
    - Exension.swift

* [Negocio:]) - Se maneja desde el componente Model, destacando las características de la lógica del negocio y sus clases asociadas son:
    - PlayerView.swift
    - Movies.swift
    - Movie.swift
    - FabricaMovie.swift
    - Video.swift
    - FabricaVideos.swift

* [Red:]) - Se maneja desde el componente Model, haciendo uso de la libreria Alamofire de acuerdo a las necesidades de la App, sus clases asociadas son:
    - FabricaMovie.swift
    - FabricaVideos.swift
    - Connectivity.swift

### Responsabilidades de las clases

* [Controller:]) 
    - SeriesController.swift: Encargado de controlar los componentes del view asignado a Series, dependiendo si el dispositivo cuenta con conexión a internet o no se carga la información de las series por cada categoria, en línea o desde CoreData respectivamente, se captura el evento cuando el usuario selecciona una serie y se remite el detalle al controlador encargado "DetalleController", de igual manera se configura la interaccion con la barra de busqueda para las series por categoria en estado OFFLINE.
    - PeliculasController.swift: Encargado de controlar los componentes del view asignado a Películas, dependiendo si el dispositivo cuenta con conexión a internet o no se carga la información de las películas por cada categoria, en línea o desde CoreData respectivamente, se captura el evento cuando el usuario selecciona una película y se remite el detalle al controlador encargado "DetalleController", de igual manera se configura la interaccion con la barra de busqueda para las películas por categoria en estado OFFLINE.
    - DetalleControllew.swift: Se encarga de controlar los componentes del view asignado al detalle de una serie o película que seleccione el usuario para visualizar mas información de la misma, donde permite la reproduccion del trailer correspondiente.
    - ViewController.swift: Asignado a la vista inicial de la aplicación, y en él se realiza la depuración de la data almacenada en CoreData dependiendo si el dispositivo cuenta con conexión a internet o no. 
    
* [View:])
    - PlayerView.xib: Contiene el diseño del View donde se reproduce el video.
    - Extension.swift: Corresponde a una extensión del componente UIImageVIew donde se configura la descarga de una imagen dada la URL.
    - Main.storyboard: Diseño gráfico general de la aplicación
    - CeldaSerie.swift: Definición de los componentes gráficos que se encuentran en cada una de las celdas donde se visualizan las películas o series. 
 
 * [Model:])
    - PlayerView.swift: Se definen los métodos que controlan las interacciones entre el usuario y la reproducción del video.
    - FabricaMovie.swift: Se realizan las peticiones de la información de las series y películas a la API correspondiente, y así mismo se realiza la carga de lainformación en la memoria del dispositivo.
    - Movies.swift: Definición de la estructura general de una película o serie
    - Movie.swift: Definición de la estructura detallada de una serie o película.
    - FabricaVideos.swift: Se realizan las peticiones  a la API de la información de los videos correspondientes a una serie o película seleccionada, de igual manera se carga dicha información en memoria.
    - Video.swift: Se define la estructrua general y detallada de los videos.
    

### Principio de responsabilidad única

Consiste en que cada clase debe estar enfocada a cumplir los objetivos de una sola parte de la funcionalidad, y toda la responsabilidad de ésta funcionalidad debe estar contenidad en dicha clase. Así mismo cada componente de la clase debe estar asociado a la misma responsabilidad de la clase en general. 

Su propósito es mantener la segregación de responsabilidades y así crear código más facil de leer, testear y mantener.


### Características de código limpio

- Simplificación de procesos con utilización de funciones propias del lenguaje
- Reutilización de código concentrado en funciones y/o clases
- Clases enfocadas a cumplimiento de una responsabilidad
- Declaración y/o asignaciones de nombres a variables, métodos, funciones entre otros, asociadas con el contexto del desarrollo y con la responsabilidad de la clase. 
- No inclusión de bloques de código comentado y/o que no se encuentre en funcionamiento 
