## Repositorio para la asignatura de "SQL avanzado, ETL y creación de DataWarehouses"  
## Repository for "Advanced SQL, ETL and DataWarehouses creation" subject  
 ---
### *Contenido del repositorio*  
 · Carpeta "Data": Contiene los 3 datasets en formato .csv necesarios para crear las tablas de datos en el DBMS, necesarias a su vez para alimentar los scripts de SQL que harán el trabajo de creación y primer filtrado del Data Warehouse.
 · Carpeta "Queries": Contiene los scripts SQL necesarios para crear el Data Warehouse y necesita tener las tablas de datos creadas usando la carpeta "Data". Ejecutar en el orden que indican sus nombres.  

### *Repository content*  
 · "Data" folder: Contains the 3 datasets in .csv format necessary to create the data tables in the DBMS, necessary in turn to feed the SQL scripts that will do the work of creating and first filtering the Data Warehouse.  
 · "Queries" folder: Contains the SQL scripts necessary to create the Data Warehouse and you need to have the data tables created using the "Data" folder. Execute in the order indicated by their names.
 ---  

### *Descripción del proyecto*
 · En este módulo hemos trabajado funciones, estructuras de queries y técnicas de resolución de problemas avanzadas para crear un Data Warehouse sobre un caso real empresarial, que podría ser usado como base en una empresa real.  
 Uno de los objetivos de este módulo era aprender el funcionamiento de un Cloud Computing para crear un Data Warehouse. · Hemos usado uno de los estándares de Proceso de Datos en la nube, Google BigQuery, perteneciente a la nube de servicios de Google Cloud.  
 · El fin de este proyecto era crear un Data Warehouse, obteniendo datos de diversos procesos distintos (archivos .csv de la carpeta "Data"), procesándolos con técnicas de ETL (Extraction-Transformation-Load), y creando una fuente maestra con los datos ya homogeneizados (usar query_1), y creando Data Marts más específicos (usar query_2). También hemos creado una demostración de uso de funciones personalizadas para modularización de código (usar query_3).  
 · En vez de usar la técnica pura ETL, hemos usado la tendencia más en alza, ELT (Extraction-Load-Transformation), alterando el orden de las fases de obtención de los datos, que asegura disponer de estos datos originales sin tratar para poder hacer cambios en el proyecto si el este cambia en el futuro, siendo esto rentable gracias al abaratamiento del almacenamiento de grandes cantidades de datos (Big Data) en servicios en Nube.  

### *Project description*
· In this module we have worked on functions, query structures and advanced problem-solving techniques to create a Data Warehouse based on a real business case, which could be used as a basis in a real company.  
One of the objectives of this module was to learn how Cloud Computing works to create a Data Warehouse.
· We have used one of the Data Processing standards in the cloud, Google BigQuery, belonging to the Google Cloud services cloud.  
· The purpose of this project was to create a Data Warehouse, obtaining data from various different processes (.csv files from the "Data" folder), processing them with ETL (Extraction-Transformation-Load) techniques, and creating a master source with the already homogenized data (use query_1), and creating more specific Data Marts (use query_2). We have also created a demo of using custom functions for code modularization (use query_3).  
· Instead of using the pure ETL technique, we have used the most rising trend, ELT (Extraction-Load-Transformation), altering the order of the data obtaining phases, which ensures having this raw original data to be able to make changes to the project if it changes in the future, this being profitable thanks to the lower cost of storing large amounts of data (Big Data) in Cloud services.  
 ---  

### *Instrucciones de uso*
  · Aunque la mayor parte del código es SQL multilenguaje, tiene instrucciones que sólo funcionan en BigQuery de Google Cloud, por lo que recomiendo usar una de las cuentas gratuitas de prueba si es que no tienes un servicio propio de BigQuery todavía. Necesitas importar los .csv que contienen los datos como tablas, dejando que se creen con el mismo nombre que tienen los archivos .csv para que pueda funcionar el código. Después ejecuta query_1 (para crear la tabla maestra del Data Warehouse), query_2 (para crear el Data Mart), y query_3 (para crear la función de demo). Después, ya puedes hacer las queries de exploración que desees.


### *Instructions for use*  
  · Although most of the code is multilanguage SQL, it has statements that only work in Google Cloud's BigQuery, so I recommend using one of the free trial accounts if you don't have your own BigQuery service yet. You need to import the .csv files that contain the data as tables, allowing them to be created with the same name as the .csv files so that the code can work. Then run query_1 (to create the Data Warehouse master table), query_2 (to create the Data Mart), and query_3 (to create the demo function). Afterwards, you can make the exploration queries you want.  
