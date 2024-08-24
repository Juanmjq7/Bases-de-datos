
-- insert into compraventa.Categoria(nombre,descripcion)
-- select nombre, descripcion from compraventa.tmp_categoria;


select * from compraventa.Categoria;

--insert into compraventa.Producto (nombre, descripcion, categoriaId)
--select nombre, descripcion, categoriaId from compraventa.tmp_producto;

select * from compraventa.Producto;

--insert into compraventa.CentroDeCostos (codigo)
--select codigo from compraventa.tmp_centro_de_costos;

select * from compraventa.CentroDeCostos;

-- insert into compraventa.Tercero (nombre, nit, tipo)
-- select nombre, nit, tipo from compraventa.tmp_tercero;

select * from compraventa.Tercero;

--insert into compraventa.OrdenDeCompra (codigo, total, fecha, centroDeCostosId, terceroId)
--select codigo, total, fecha, centroDeCostosId, terceroId from compraventa.tmp_orden_de_compra;

select * from compraventa.OrdenDeCompra;
