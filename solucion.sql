use [DSL]

-- 1. ¿Cuál es el primer proveedor con el que se negoció?
select top 1
t.nombre
from compraventa.OrdenDeCompra as oc
	join compraventa.Tercero as t
		on oc.terceroId = t.id
order by fecha asc;

-- 2. ¿Cuál es la orden de compra más grande?
select top 1
codigo,
total
from compraventa.OrdenDeCompra
order by total desc;

-- 3. ¿A qué proveedor se le compró la primera orden de compra del 2024? 
-- Adicionalmente, ¿en qué centro de costos se cargó esa OC?

select 
top 1
t.nombre,
cc.codigo
from compraventa.OrdenDeCompra as oc
	join compraventa.Tercero as t
		on oc.terceroId = t.id
	join compraventa.CentroDeCostos as cc
		on oc.centroDeCostosId = cc.id
where year(oc.fecha) = 2024
order by oc.fecha asc;

-- 4. ¿Cuál es el proveedor al que se le ha pagado la orden de compra más cara 
-- en el centro de costos CC-1001? 
-- ¿Cuál fue el valor de esa OC y en qué fecha se dio?
select 
top 1
t.nombre,
oc.total,
oc.fecha
from compraventa.OrdenDeCompra as oc
	join compraventa.CentroDeCostos as cc
		on oc.centroDeCostosId = cc.id
	join compraventa.Tercero as t
		on oc.terceroId = t.id
where cc.codigo = 'CC-1001'
order by total desc;

-- 5. ¿Cuál es el total de compras realizadas en el centro de costos CC-1002?
select 
cc.codigo,
sum(oc.total)
from compraventa.OrdenDeCompra as oc
	join compraventa.CentroDeCostos as cc
		on oc.centroDeCostosId = cc.id
where cc.codigo = 'CC-1002'
group by cc.codigo	

--6. Calcular el total de compras realizadas en cada centro de costos 
-- en el 2024.
select 
cc.codigo,
sum(oc.total)
from compraventa.OrdenDeCompra as oc
	join compraventa.CentroDeCostos as cc
		on oc.centroDeCostosId = cc.id
where year(oc.fecha) = 2024
group by cc.codigo	
order by sum(oc.total) desc

-- 7. Calcular el total de compras 
-- realizadas por cada proveedor en el centro de costos CC-1003 en el año 2024.
select
t.nombre,
t.nit,
sum(oc.total)
from compraventa.OrdenDeCompra as oc
	join compraventa.CentroDeCostos as cc
		on oc.centroDeCostosId = cc.id
	join compraventa.Tercero as t
		on oc.terceroId = t.id
where 
year(oc.fecha) = 2024
and cc.codigo = 'CC-1003'
group by t.nombre, t.nit;

-- 8. Calcular el total de compras realizadas por cada centro de costos 
-- para el proveedor Almacén RopaViva en el 2023.
select
cc.codigo,
sum(oc.total)
from compraventa.OrdenDeCompra as oc
	join compraventa.Tercero as t
		on oc.terceroId = t.id
	join compraventa.CentroDeCostos as cc
		on oc.centroDeCostosId = cc.id
where year(fecha) = 2023 and t.nombre = 'Almacén RopaViva'
group by cc.codigo

-- 9. Calcular el mes del 2023 con más compras.
select 
top 1
month(oc.fecha),
sum(oc.total)
from compraventa.OrdenDeCompra as oc
where year(oc.fecha) = 2023
group by month(oc.fecha)
order by sum(oc.total) desc

-- 10. Calcular el top 3 de proveedores a los que más se les ha comprado en el 2024.
select 
top 3
t.nombre,
sum(oc.total)
from compraventa.OrdenDeCompra as oc
	join compraventa.Tercero as t
		on oc.terceroId = t.id
where year(fecha) = 2024
group by t.nombre
order by sum(oc.total) desc;

-- 11. Calcular el valor de la orden de compra más cara para cada proveedor.
select 
t.nombre,
max(oc.total)
from compraventa.OrdenDeCompra as oc
	join compraventa.Tercero as t
		on oc.terceroId = t.id
group by t.nombre

-- 12. Calcular los 3 de centros de costos que menos se usaron durante el 2021.
select 
top 3
cc.codigo,
sum(oc.total)
from compraventa.OrdenDeCompra as oc
	join compraventa.CentroDeCostos as cc
		on oc.centroDeCostosId = cc.id
where year(oc.fecha) = 2021
group by cc.codigo
order by sum(oc.total) asc

-- 13. ¿Cuáles son los 5 centros de costos con compras, en promedio, más altas?
select 
top 5
cc.codigo,
avg(total)
from compraventa.OrdenDeCompra as oc
	join compraventa.CentroDeCostos as cc
		on oc.centroDeCostosId = cc.id
group by cc.codigo
order by avg(total) desc

-- 14. ¿Cuáles son los 5 proveedores más baratos en promedio del 2023?
select
top 5
t.nombre,
avg(oc.total)
from compraventa.OrdenDeCompra as oc
	join compraventa.Tercero as t
		on oc.terceroId = t.id
where year(oc.fecha) = 2023
group by t.nombre
order by avg(oc.total) asc

-- 15 ¿Cuáles son los 3 proveedores a los que más se les compró en enero del 2024?
select 
top 3
t.nombre,
sum(oc.total)
from compraventa.OrdenDeCompra as oc
	join compraventa.Tercero as t
		on oc.terceroId = t.id
where year(oc.fecha) = 2024 and month(oc.fecha) = 1
group by t.nombre
order by sum(oc.total) desc
