-- =====================================
-- REPORTE SQL - CHALLENGER SISTEMA VENTAS
-- =====================================

-- 1. Mostrar todos los clientes registrados
select nombre from clientes

-- 2. Mostrar todos los productos disponibles
select * from productos;

-- 3. Mostrar todas las ventas realizadas
select id_venta from ventas;
select count(*) from ventas; -- si se refiere a cantidad de ventas

-- 4. Mostrar solo nombre y email de clientes
select nombre, email from clientes;

-- 5. Mostrar solo nombre y precio de productos
select nombre, precio from productos;

-- 6. Productos con precio mayor a 50000
select nombre, precio from productos
where precio > 50000;

-- 7. Ventas realizadas el 2026-04-02
select * from ventas
where fecha > '2026-04-01';

-- 8. Productos ordenados de mayor a menor precio
select nombre, precio from productos 
order by precio desc; --insane

-- 9. Clientes ordenados por nombre
select nombre from clientes 
order by nombre asc; aplicable desc o asc para lo alfabetico, insano.

-- 10. Detalles de venta con cantidad >= 2
select * from detalle_venta
where cantidad >= 2;

-- 11. Total de clientes
select count(*) from clientes;

-- 12. Total de productos
select count(*) from productos;

-- 13. Total de ventas
select count(*) from ventas;

-- 14. Precio promedio de productos
select ROUND(avg(precio)) as promedio_precios from productos; --DEMACIADOS DECIMALES, intenté round doesnt work, UPDATE: ahora si, round va antes de avg no inside

-- 15. Suma total de precios de productos
select sum(precio) from productos; --first try :D

-- 16. Mostrar venta + nombre del cliente + fecha
select ventas.id_venta, clientes.nombre from ventas 
join clientes on clientes.id_cliente = ventas.id_cliente; --no funciono

SELECT clientes.nombre, ventas.id_venta, ventas.fecha 
FROM clientes
INNER JOIN ventas
  ON clientes.id_cliente = ventas.id_cliente;--no entiendo -.- funcionó tho

-- 17. Mostrar detalle de ventas con id_venta + nombre producto + cantidad
select detalle_venta.id_venta, productos.nombre, detalle_venta.cantidad
from detalle_venta
inner join productos
on detalle_venta.id_producto = productos.id_producto; --FAIL

-- 18. Mostrar nombre del cliente + id de venta + fecha
select clientes.nombre, ventas.id_venta, ventas.fecha
from clientes
inner join ventas
on clientes.id_cliente = ventas.id_venta; --entendi!

-- 19. Mostrar nombre del producto + cantidad vendida + id de venta
select productos.nombre, detalle_venta.cantidad, detalle_venta.id_venta
from detalle_venta
inner join productos
on detalle_venta.id_producto = productos.id_producto;

-- 20. Mostrar cuántas ventas ha realizado cada cliente
--select clientes.nombre, ventas.id_venta from clientes inner join ventas on clientes.id_cliente = ventas.id_cliente
select id_cliente, count(id_venta) from ventas
group by id_cliente; --YES

-- 21. Mostrar solo los clientes con más de una venta
select id_cliente from ventas 
group by id_cliente
having count(id_venta) > 1;

-- 22. Mostrar cuántas veces aparece cada producto en detalle_venta
select count(id_producto), id_producto from detalle_venta
group by id_producto;

-- 23. Mostrar solo los productos que aparecen más de una vez
select id_producto from detalle_venta
group by id_producto
having count(id_producto) > 1;

-- 24. Mostrar las ventas que tienen más de un producto asociado
select id_venta, count(id_producto) as cantidad_productos from detalle_venta
group by id_venta
having count(id_producto) > 1;

-- 25. Mostrar clientes cuya suma total de unidades compradas sea mayor a 2
select ventas.id_cliente, sum(detalle_venta.cantidad) as total_productos from detalle_venta
inner join ventas
on  detalle_venta.id_venta = ventas.id_venta
group by ventas.id_cliente
having sum(detalle_venta.cantidad) > 2;

-- 26. Consulta trampa que no devuelva resultados
-- Explicar por qué el resultado vacío es correcto