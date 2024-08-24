BEGIN TRY

BEGIN TRAN;

CREATE SCHEMA [compraventa];

-- CreateTable
CREATE TABLE [compraventa].[CentroDeCostos] (
    [id] INT NOT NULL IDENTITY(1,1),
    [codigo] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [CentroDeCostos_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [compraventa].[Tercero] (
    [id] INT NOT NULL IDENTITY(1,1),
    [nombre] NVARCHAR(1000) NOT NULL,
    [nit] NVARCHAR(1000) NOT NULL,
    [tipo] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Tercero_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Tercero_nombre_key] UNIQUE NONCLUSTERED ([nombre])
);

-- CreateTable
CREATE TABLE [compraventa].[Categoria] (
    [id] INT NOT NULL IDENTITY(1,1),
    [nombre] NVARCHAR(1000) NOT NULL,
    [descripcion] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Categoria_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [compraventa].[Producto] (
    [id] INT NOT NULL IDENTITY(1,1),
    [nombre] NVARCHAR(1000) NOT NULL,
    [descripcion] NVARCHAR(1000) NOT NULL,
    [categoriaId] INT NOT NULL,
    CONSTRAINT [Producto_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [compraventa].[PrecioProducto] (
    [id] INT NOT NULL IDENTITY(1,1),
    [precio] FLOAT(53) NOT NULL,
    [productoId] INT NOT NULL,
    [listaId] INT NOT NULL,
    CONSTRAINT [PrecioProducto_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [compraventa].[ListaDePrecios] (
    [id] INT NOT NULL IDENTITY(1,1),
    [nombre] NVARCHAR(1000) NOT NULL,
    [fecha] DATETIME2 NOT NULL,
    CONSTRAINT [ListaDePrecios_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [compraventa].[OrdenDeCompra] (
    [id] INT NOT NULL IDENTITY(1,1),
    [codigo] NVARCHAR(1000) NOT NULL,
    [total] NVARCHAR(1000) NOT NULL,
    [fecha] DATETIME2 NOT NULL,
    [centroDeCostosId] INT NOT NULL,
    [terceroId] INT NOT NULL,
    CONSTRAINT [OrdenDeCompra_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [OrdenDeCompra_codigo_key] UNIQUE NONCLUSTERED ([codigo])
);

-- CreateTable
CREATE TABLE [compraventa].[Movimiento] (
    [id] INT NOT NULL IDENTITY(1,1),
    [cantidad] INT NOT NULL,
    [fecha] DATETIME2 NOT NULL,
    [tipo] NVARCHAR(1000) NOT NULL,
    [productoId] INT NOT NULL,
    [ordenDeCompraId] INT,
    [facturaDeVentaId] INT,
    [responsableId] INT NOT NULL,
    CONSTRAINT [Movimiento_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [compraventa].[FacturaDeVenta] (
    [id] INT NOT NULL IDENTITY(1,1),
    [codigo] NVARCHAR(1000) NOT NULL,
    [total] NVARCHAR(1000) NOT NULL,
    [fecha] DATETIME2 NOT NULL,
    [terceroId] INT NOT NULL,
    CONSTRAINT [FacturaDeVenta_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [FacturaDeVenta_codigo_key] UNIQUE NONCLUSTERED ([codigo])
);

-- CreateTable
CREATE TABLE [compraventa].[Usuario] (
    [id] INT NOT NULL IDENTITY(1,1),
    [nombre] NVARCHAR(1000) NOT NULL,
    [correo] NVARCHAR(1000) NOT NULL,
    [identificacion] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Usuario_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Usuario_correo_key] UNIQUE NONCLUSTERED ([correo]),
    CONSTRAINT [Usuario_identificacion_key] UNIQUE NONCLUSTERED ([identificacion])
);

-- AddForeignKey
ALTER TABLE [compraventa].[Producto] ADD CONSTRAINT [Producto_categoriaId_fkey] FOREIGN KEY ([categoriaId]) REFERENCES [compraventa].[Categoria]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [compraventa].[PrecioProducto] ADD CONSTRAINT [PrecioProducto_productoId_fkey] FOREIGN KEY ([productoId]) REFERENCES [compraventa].[Producto]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [compraventa].[PrecioProducto] ADD CONSTRAINT [PrecioProducto_listaId_fkey] FOREIGN KEY ([listaId]) REFERENCES [compraventa].[ListaDePrecios]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [compraventa].[OrdenDeCompra] ADD CONSTRAINT [OrdenDeCompra_centroDeCostosId_fkey] FOREIGN KEY ([centroDeCostosId]) REFERENCES [compraventa].[CentroDeCostos]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [compraventa].[OrdenDeCompra] ADD CONSTRAINT [OrdenDeCompra_terceroId_fkey] FOREIGN KEY ([terceroId]) REFERENCES [compraventa].[Tercero]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [compraventa].[Movimiento] ADD CONSTRAINT [Movimiento_productoId_fkey] FOREIGN KEY ([productoId]) REFERENCES [compraventa].[Producto]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [compraventa].[Movimiento] ADD CONSTRAINT [Movimiento_ordenDeCompraId_fkey] FOREIGN KEY ([ordenDeCompraId]) REFERENCES [compraventa].[OrdenDeCompra]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [compraventa].[Movimiento] ADD CONSTRAINT [Movimiento_facturaDeVentaId_fkey] FOREIGN KEY ([facturaDeVentaId]) REFERENCES [compraventa].[FacturaDeVenta]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [compraventa].[Movimiento] ADD CONSTRAINT [Movimiento_responsableId_fkey] FOREIGN KEY ([responsableId]) REFERENCES [compraventa].[Usuario]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [compraventa].[FacturaDeVenta] ADD CONSTRAINT [FacturaDeVenta_terceroId_fkey] FOREIGN KEY ([terceroId]) REFERENCES [compraventa].[Tercero]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
