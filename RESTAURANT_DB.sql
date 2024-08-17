CREATE TABLE [Custommers] (
  [username] nvarchar(255) PRIMARY KEY,
  [number] nvarchar(255),
  [name] nvarchar(255),
  [email] nvarchar(255),
  [password] nvarchar(255),
  [balance] money
)
GO

CREATE TABLE [Admins] (
  [id] integer PRIMARY KEY IDENTITY(1,1),
  [username] nvarchar(255),
  [number] nvarchar(255),
  [name] nvarchar(255),
  [password] nvarchar(255)
)
GO

CREATE TABLE [Foods] (
  [id] integer PRIMARY KEY IDENTITY(1,1),
  [name] nvarchar(255),
  [url] nvarchar(255),
  [price] money,
  [quantity] integer,
  [category_id] integer
)
GO

CREATE TABLE [Catagories] (
  [id] integer PRIMARY KEY IDENTITY(1,1),
  [name] nvarchar(255)
)
GO

CREATE TABLE [Orders] (
  [id] integer PRIMARY KEY IDENTITY(1,1),
  [Order_date] datetime,
  [cus_id] nvarchar(255),
  [total_price] money
)
GO

CREATE TABLE [Order_Details] (
  [id] integer PRIMARY KEY IDENTITY(1,1),
  [food_id] integer,
  [order_id] integer,
  [quantity] integer,
  [price] money
)
GO

CREATE TABLE [Comments] (
  [comment_id] integer PRIMARY KEY IDENTITY(1,1),
  [cus_id] nvarchar(255),
  [content] nvarchar(max),
  [rating] tinyint
)
GO

ALTER TABLE [Foods] ADD FOREIGN KEY ([category_id]) REFERENCES [Catagories] ([id])
GO

ALTER TABLE [Orders] ADD FOREIGN KEY ([cus_id]) REFERENCES [Custommers] ([username])
GO

ALTER TABLE [Order_Details] ADD FOREIGN KEY ([order_id]) REFERENCES [Orders] ([id])
GO

ALTER TABLE [Order_Details] ADD FOREIGN KEY ([food_id]) REFERENCES [Foods] ([id])
GO

ALTER TABLE [Comments] ADD FOREIGN KEY ([cus_id]) REFERENCES [Custommers] ([username])
GO
