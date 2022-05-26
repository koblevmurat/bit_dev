USE [master]
GO
/****** Object:  Database [simple_ecomerce]    Script Date: 26.05.2022 21:30:28 ******/
CREATE DATABASE [simple_ecomerce]
 CONTAINMENT = NONE
 
GO
ALTER DATABASE [simple_ecomerce] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [simple_ecomerce].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [simple_ecomerce] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [simple_ecomerce] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [simple_ecomerce] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [simple_ecomerce] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [simple_ecomerce] SET ARITHABORT OFF 
GO
ALTER DATABASE [simple_ecomerce] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [simple_ecomerce] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [simple_ecomerce] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [simple_ecomerce] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [simple_ecomerce] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [simple_ecomerce] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [simple_ecomerce] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [simple_ecomerce] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [simple_ecomerce] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [simple_ecomerce] SET  DISABLE_BROKER 
GO
ALTER DATABASE [simple_ecomerce] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [simple_ecomerce] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [simple_ecomerce] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [simple_ecomerce] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [simple_ecomerce] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [simple_ecomerce] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [simple_ecomerce] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [simple_ecomerce] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [simple_ecomerce] SET  MULTI_USER 
GO
ALTER DATABASE [simple_ecomerce] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [simple_ecomerce] SET DB_CHAINING OFF 
GO
ALTER DATABASE [simple_ecomerce] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [simple_ecomerce] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [simple_ecomerce] SET DELAYED_DURABILITY = DISABLED 
GO
USE [simple_ecomerce]
GO
/****** Object:  Table [dbo].[customer]    Script Date: 26.05.2022 21:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order]    Script Date: 26.05.2022 21:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order](
	[id] [uniqueidentifier] NOT NULL,
	[customer_id] [uniqueidentifier] NOT NULL,
	[order_date] [datetime] NOT NULL,
 CONSTRAINT [PK_order] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_sku]    Script Date: 26.05.2022 21:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_sku](
	[order_id] [uniqueidentifier] NOT NULL,
	[sku_id] [uniqueidentifier] NOT NULL,
	[amount] [int] NOT NULL,
	[sum] [money] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sku]    Script Date: 26.05.2022 21:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sku](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[category_id] [uniqueidentifier] NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [PK_sku] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sku_category]    Script Date: 26.05.2022 21:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sku_category](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_sku_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[customer] ADD  CONSTRAINT [DF_customer_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[order] ADD  CONSTRAINT [DF_order_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[sku] ADD  CONSTRAINT [DF_sku_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[sku_category] ADD  CONSTRAINT [DF_sku_category_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD  CONSTRAINT [FK_order_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([id])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK_order_customer]
GO
ALTER TABLE [dbo].[order_sku]  WITH CHECK ADD  CONSTRAINT [FK_order_sku_order] FOREIGN KEY([order_id])
REFERENCES [dbo].[order] ([id])
GO
ALTER TABLE [dbo].[order_sku] CHECK CONSTRAINT [FK_order_sku_order]
GO
ALTER TABLE [dbo].[order_sku]  WITH CHECK ADD  CONSTRAINT [FK_order_sku_sku] FOREIGN KEY([sku_id])
REFERENCES [dbo].[sku] ([id])
GO
ALTER TABLE [dbo].[order_sku] CHECK CONSTRAINT [FK_order_sku_sku]
GO
ALTER TABLE [dbo].[sku]  WITH CHECK ADD  CONSTRAINT [FK_sku_sku_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[sku_category] ([id])
GO
ALTER TABLE [dbo].[sku] CHECK CONSTRAINT [FK_sku_sku_category]
GO
USE [master]
GO
ALTER DATABASE [simple_ecomerce] SET  READ_WRITE 
GO
